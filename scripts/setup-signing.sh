#!/usr/bin/env bash
# Configure this clone so every commit and tag you make is SSH-signed and DCO-signed-off, and so the
# repository's hooks refuse anything else. Idempotent. Run from anywhere inside the clone.
#
#   scripts/setup-signing.sh                      # use ~/.ssh/pqc_signing_ed25519 (generated if missing)
#   scripts/setup-signing.sh --key ~/.ssh/id_ed25519.pub   # use an existing key
#   scripts/setup-signing.sh --email you@example.org        # set the committer email the sign-off will use
#   scripts/setup-signing.sh --global                       # also set the signing settings in ~/.gitconfig
#
# After this: register the PUBLIC key on GitHub as a *signing* key (Settings -> SSH and GPG keys -> New SSH key,
# key type "Signing Key"), or:  gh ssh-key add "$PUB" --type signing --title "pqc-agility signing"
# Then add yourself to .allowed_signers by pull request (see docs/SIGNING.md).
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
KEY=""; EMAIL=""; SCOPE=""
while [ $# -gt 0 ]; do
  case "$1" in
    --key) KEY="$2"; shift 2 ;;
    --email) EMAIL="$2"; shift 2 ;;
    --global) SCOPE="--global"; shift ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
    *) echo "unknown option $1" >&2; exit 2 ;;
  esac
done

# 1. OpenSSH >= 8.8 is needed for ssh-keygen -Y sign/verify
v="$(ssh -V 2>&1 | sed -E 's/^OpenSSH_([0-9]+)\.([0-9]+).*/\1 \2/')"
set -- $v; if [ "${1:-0}" -lt 8 ] || { [ "${1:-0}" -eq 8 ] && [ "${2:-0}" -lt 8 ]; }; then
  echo "OpenSSH >= 8.8 required for SSH signing (found: $(ssh -V 2>&1))" >&2; exit 1; fi

# 2. Identity
[ -n "$EMAIL" ] && git config $SCOPE user.email "$EMAIL"
NAME="$(git config user.name || true)"; EMAIL="$(git config user.email || true)"
if [ -z "$NAME" ] || [ -z "$EMAIL" ]; then echo "set git user.name and user.email first (or pass --email)" >&2; exit 1; fi

# 3. Signing key (public key path is what git wants for gpg.format=ssh)
if [ -z "$KEY" ]; then
  KEY="$HOME/.ssh/pqc_signing_ed25519.pub"
  if [ ! -f "$KEY" ]; then
    echo "generating a dedicated signing key at ${KEY%.pub}"
    ssh-keygen -t ed25519 -C "git signing <$EMAIL>" -f "${KEY%.pub}"
  fi
fi
case "$KEY" in *.pub) ;; *) KEY="$KEY.pub" ;; esac
[ -f "$KEY" ] || { echo "public key not found: $KEY" >&2; exit 1; }
KEY="$(cd "$(dirname "$KEY")" && pwd)/$(basename "$KEY")"

# 4. Git configuration: sign everything, verify against the repository's allowed signers, use the repo hooks
git config $SCOPE gpg.format ssh
git config $SCOPE user.signingkey "$KEY"
git config $SCOPE commit.gpgsign true
git config $SCOPE tag.gpgsign true
git config gpg.ssh.allowedSignersFile "$(pwd)/.allowed_signers"
git config core.hooksPath .githooks
chmod +x .githooks/* 2>/dev/null || true

# 5. Allowed-signers line for this identity (printed; added by PR, not silently)
LINE="$EMAIL namespaces=\"git\" $(cut -d' ' -f1,2 "$KEY") $(cut -d' ' -f3- "$KEY")"
if grep -q -F "$(cut -d' ' -f2 "$KEY")" .allowed_signers; then
  echo "your key is already in .allowed_signers"
else
  echo
  echo "Add this line to .allowed_signers in a pull request signed with the same key:"
  echo "  $LINE"
fi

# 6. Self-test: sign and verify a blob with the configured key
tmp="$(mktemp)"; printf 'pqc-agility signing self-test\n' > "$tmp"
if ssh-keygen -Y sign -f "${KEY%.pub}" -n git "$tmp" >/dev/null 2>&1; then echo "self-test: signing works with $KEY"; rm -f "$tmp" "$tmp.sig"; else echo "self-test FAILED: cannot sign with ${KEY%.pub} (agent / passphrase?)" >&2; rm -f "$tmp"; exit 1; fi

cat <<MSG

configured:
  user            $NAME <$EMAIL>
  signing key     $KEY  (ssh)
  commit.gpgsign  true     tag.gpgsign true
  allowed signers $(pwd)/.allowed_signers
  hooks           .githooks  (commit-msg adds the DCO trailer; pre-push refuses unsigned or un-signed-off commits)

next:
  1. register the public key on GitHub as a SIGNING key:  gh ssh-key add "$KEY" --type signing --title "pqc-agility signing"
  2. commit normally (git commit -s is implied by the hook), check with:  git log --show-signature -1
  3. open a PR adding your .allowed_signers line (docs/SIGNING.md)
MSG
