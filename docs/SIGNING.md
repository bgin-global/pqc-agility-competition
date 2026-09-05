# Signing — how to make commits this repository accepts

Every commit and tag here must be **cryptographically signed** with a key registered on your GitHub account **and** carry a **Developer Certificate of Origin sign-off** (`DCO.md`). Pushes with anything else are refused by your local hook and again by the server rulesets. This page is the setup; `docs/SECURITY_MODEL.md` is the why.

## 1. Once per person

1. **Two-factor authentication** on your GitHub account (the organization requires it).
2. **A signing key.** SSH signing is the recommended path (no GPG keyring to manage). Either reuse an existing Ed25519 key or, better, make a dedicated one:

   ```
   ssh-keygen -t ed25519 -C "git signing <you@example.org>" -f ~/.ssh/pqc_signing_ed25519
   ```

3. **Register the public key on GitHub as a signing key.** Settings → SSH and GPG keys → New SSH key → key type **Signing Key**. Or with the CLI:

   ```
   gh ssh-key add ~/.ssh/pqc_signing_ed25519.pub --type signing --title "pqc-agility signing"
   ```

   A key registered only as an *authentication* key does not make commits show as verified.

4. **Verified email.** The committer email on your commits must be a verified address on your GitHub account (the `<id>+<login>@users.noreply.github.com` address counts). Sign-off and signature are both matched against it.

## 2. Once per clone

```
scripts/setup-signing.sh --key ~/.ssh/pqc_signing_ed25519.pub
```

This sets `gpg.format ssh`, `user.signingkey`, `commit.gpgsign`, `tag.gpgsign`, points `gpg.ssh.allowedSignersFile` at the repository's `.allowed_signers`, and switches `core.hooksPath` to `.githooks` so that:

- `commit-msg` adds `Signed-off-by: Your Name <you@example.org>` if it is missing and refuses a sign-off that does not match your `user.name` / `user.email`;
- `pre-push` refuses to push any commit that is not verifiably signed or lacks the sign-off.

Add `--global` if you want the same signing defaults in every repository on the machine.

## 3. Add yourself to the allowed signers

`.allowed_signers` lets anyone verify the whole history offline. Open a pull request that adds one line, signed with the same key:

```
you@example.org namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAA... pqc-agility signing 2026
```

The principal must equal your committer email exactly. The PR is verifiable server-side through your GitHub-registered key before the file changes, so there is no chicken-and-egg problem.

## 4. Every day

```
git commit -m "..."            # hook adds the sign-off; commit.gpgsign signs it
git log --show-signature -1     # "Good "git" signature for you@example.org with ED25519 key ..."
scripts/verify-history.sh origin/main..HEAD
git push                        # pre-push re-checks the range
```

If a commit was made elsewhere without signing, fix the range rather than the push:

```
git rebase --exec 'git commit --amend --no-edit -s -S' origin/main
```

## 5. Tags and releases

Call-text packages and any release are **signed tags** created by a repository admin:

```
git tag -s v0.1-call-text -m "Call-text input package for METI/NEDO, W4 2026-12"
git push origin v0.1-call-text
```

The tag ruleset refuses unsigned tags and tag creation by anyone else.

## 6. GPG instead of SSH

Supported. Register the GPG public key on GitHub, then in the clone:

```
git config gpg.format openpgp
git config user.signingkey <KEYID>
git config commit.gpgsign true
git config tag.gpgsign true
git config core.hooksPath .githooks
```

`.allowed_signers` is SSH-only; GPG signers are verified through GitHub and through the keyring of whoever runs `verify-history.sh`.

## 7. Windows notes

- Git for Windows ships its own OpenSSH; `ssh -V` must report 8.8 or newer for `ssh-keygen -Y`. If Windows' built-in OpenSSH is older, set `git config gpg.ssh.program "C:/Program Files/Git/usr/bin/ssh-keygen.exe"`.
- Run the scripts from Git Bash. Hooks are shell scripts and need the LF line endings that `.gitattributes` enforces.
- If the key has a passphrase, start `ssh-agent` and `ssh-add` it once per session, or commits will prompt.

## 8. Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| GitHub shows *Unverified* | Key registered as authentication, not signing; or committer email not verified on the account | Register as signing key; use a verified email |
| `No principal matched` locally | Your committer email is not the principal in `.allowed_signers` | Match them exactly; add the line by PR |
| `pre-push: commit … is not verifiably signed (status 'N')` | `commit.gpgsign` off, or commit made before setup | Amend or rebase with `-S` |
| `Signed-off-by … does not match` | `user.name` / `user.email` changed since the commit | Re-sign-off with `git commit --amend -s` |
| Push rejected by GitHub with "required signatures" | A commit in the range is unsigned, or the signer is not registered | `scripts/verify-history.sh` to find it; amend; push again |
