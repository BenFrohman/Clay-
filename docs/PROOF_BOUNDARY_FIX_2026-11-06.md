# Monograph/source synchronization

The obsolete 60-theorem / 13-submodule paragraph is removed from the current monograph; the source tree has fourteen Clay submodules plus its root. The current audit inventory is 62 theorem declarations (including generated auxiliaries), not 62 independent analytical results.

The global-existence result remains the implication from `PeriodicMaximalSolutionWithBKM` and `PeriodicBKMIntegrability` to `FeffermanStatementB`. The proof does not discharge either argument, and in particular does not establish the open BKM bound.

`ConditionalRiccati.lean` is unchanged mathematically: `rate`, `C`, `kappa`, and `M` are integers, the hypothesis is `rate ≤ M * (C * M - kappa * M * M)`, and the conclusion is the expanded `rate ≤ C * M * M - kappa * M * M * M`. The prose no longer describes this as a proved real differential law or a vorticity/PDE estimate. Establishing such an analytical interpretation remains an unresolved mathematical input.

The committed PDF is rebuilt from the corrected source with Tectonic. No theorem, hypothesis, or research branch is removed, and no publishing is performed.
