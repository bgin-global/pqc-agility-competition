# Draft — call for testbed node hosts

**Where:** new topic in category 44.
**Title:** `Testbed: expressions of interest for node hosting`

---

The neutral evaluation testbed is what separates this competition from a paper exercise, and it needs hosts. The formal node call is a W3 output (November); this is the expression-of-interest stage, so that W3 starts with a map instead of a blank sheet.

**Offer a node:** the *Node host offer* issue template at https://github.com/bgin-global/pqc-agility-competition/issues/new/choose, or a reply here.

### Shape

The IKP-WG discussion started from ten nodes over six months; the current specification says on the order of 10–15 nodes, multi-region, running over multiple months. What matters is not the count but the two properties the count is a proxy for: **geographic and organisational distribution**, and **reproduction** — the same run, on different hardware in different jurisdictions, agreeing within a stated tolerance.

Reproduction tolerance is calibrated during the W5 pilot with three to five nodes. That calibration is the difference between a number and evidence.

### What hosting involves

- Running the harness described in `testbed/HARNESS.md` against a fixed result schema (`testbed/schema/result.schema.json`).
- Reporting results in that schema, reproducibly, on a schedule.
- Accepting that results tied to a named operator are handled as confidential and that what gets published is the aggregate that identifies no one, unless the operator agrees otherwise.

Both the harness interface and the result schema are draft and adopted at W3. An operator who reads the harness spec now and says what is unworkable is more useful than one who says yes to it as written.

### Open, and better answered by hosts than by conveners

The reference CPU class and the reference transaction mix are undecided — open questions 4 in the metric register. So is the block mix that the per-block overhead metrics anchor to. These are the parameters that decide whether numbers from different nodes can be compared at all, and the people who will actually run the machines should set them.

### Neutrality

Node hosts are not applicants. The testbed measures; it does not compete. Where a host has an interest in an applicant or a scheme, the conflict-of-interest policy applies to the measurement seat as it does to the review seats.
