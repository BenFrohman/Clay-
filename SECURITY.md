# Security policy

## Reporting

Report suspected software/build-chain vulnerabilities privately to the maintainer's
designated address: **frohmanbenjamin@gmail.com**. Include the affected commit,
Lean/dependency versions, impact and minimal reproduction. Do not send credentials,
private keys, access tokens or unnecessary personal data.

GitHub private vulnerability reporting was checked on 2026-11-06 and is **disabled**
for this repository. Do not post sensitive vulnerability details publicly or assume
that GitHub's private-report form is available. This policy does not promise an
acknowledgment, remediation deadline or supported security-service SLA.

Non-sensitive mathematical or documentation errors can be reported through
[repository issues](https://github.com/BenFrohman/Clay-/issues). A mathematical gap
is not by itself a software vulnerability.

## Scope and verification

This is research formalization, not production security software. Reproduce checks
using the pinned Lean/Mathlib versions and inspect changes before executing build
scripts. Standard-axiom audits do not establish semantic accuracy or dependency
security. Reproducibility bundles require the Lean kernel and pinned dependencies;
they are not standalone independent proof certificates.
