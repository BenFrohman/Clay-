# Solution-linked vortex-line implementation: proved and unproved scope

The new module `Clay.Depletion.SolutionLinkedVortexLines` uses exactly the
existing `E3`, `curl`, `pd`, `lifespanSet`, `NSOn` and `BKMIntegralFinite`.
The old free `DHYPacket` and its equivalence diagnostic are preserved unchanged.

## Implemented actual linkage

For each velocity field u and lifespan T, a `Packet u T` supplies actual moving
points x(t), y(t), a curve gamma(t,s), a length L(t), and finite constants K>=1
and C>=0. On the lifespan it requires:

- gamma(t,0)=x(t) and gamma(t,L(t))=y(t);
- Omega(t)<=K |curl u(t,x(t))|;
- at nonzero peak vorticity, L(t)>0, curl u is nonzero everywhere on the segment,
  and gamma has derivative xi=curl u/|curl u| along [0,L(t)];
- actual integrability of div xi along that segment, and
  |integral_0^L div xi(gamma(t,s)) ds|<=C;
- measurability of the moving points, length, actual endpoint-vorticity magnitude
  and actual line control. The measured quantities are evaluated from u, not
  free fields that can be filled with zeros. Observations are extended by zero
  outside the lifespan, where NSOn imposes no control.

This is explicitly a NONDEGENERATE specialization of the spatial hypotheses
of Theorem 1 in Deng--Hou--Yu, arXiv:math-ph/0402032. Positive length on active
segments is an extra restriction of this implementation, not a claim that the
paper excludes degenerate segments. At zero peak vorticity the positive-length,
nonvanishing and tangent requirements are inactive. No Euler Theorem 2 is used.

## Proved in Lean

- Normalized nonzero vorticity has norm one: the prescribed tangent has actual
  unit speed, not merely a name suggesting arc length.
- The far endpoint belongs to the same nonzero-vorticity segment when active.
- If packet length is zero, actual curl u is zero at EVERY spatial point.
  Conversely any nonzero vorticity anywhere forces positive packet length.
  Thus a legacy all-zero placeholder cannot certify a nonzero-vorticity field.
- The actual zero field satisfies NSOn, admits zeroPacket, and satisfies both
  the separate endpoint-integrability hypothesis and spatial comparison.
- Given the explicit pointwise comparison
    |omega(t,x(t))| <= exp(C) |omega(t,y(t))|
  AND the separate actual endpoint integral being finite, extended-integral
  monotonicity proves BKMIntegralFinite. The hypotheses are arguments of the
  theorem, not conclusions inferred from the existence of a packet.
- The zero-solution regression exercises this complete conditional route.

All new declarations are included in the existing full-library axiom audit.
`SolutionLinkedRegression.lean`, invoked by CI, retains the universal zero-
length rejection, actual zero-solution acceptance and standard-axiom checks.

## Exact unproved bridge (not an axiom)

`SpatialBridgeObligation` is a Prop declaration only. It says that on the actual
smooth finite NS solutions, each linked packet yields SpatialComparison.
No theorem or inhabitant of this Prop is supplied. Its missing proof consists of:

1. derive spatial C1 vorticity and div(curl u)=0 from actual NSOn smoothness;
2. along the nonzero unit-speed curve, apply the chain rule to obtain
   d/ds log|omega(gamma(s))| = -div xi(gamma(s));
3. justify the fundamental theorem of calculus along the segment and exponentiate
   the actual integrated-divergence bound to compare the two endpoint magnitudes.

This is the spatial Lemma 1 / equation (3.2) argument used in the paper's
Theorem 1, which applies to Euler AND Navier--Stokes. It is much narrower than
BKM integrability: it has no temporal integral or regularity conclusion.
The paper's moving-segment Theorem 2 relies on Euler transport and is NOT
transferred to viscous NS by this implementation.

## Still needed for a regularity argument

The packet type does not include endpoint-integral finiteness or BKM finiteness.
EndpointIntegralFinite is a separate, unproved-for-general-data hypothesis as
in the cited theorem. Constructing suitable measurable packets for arbitrary
solutions, proving their uniform geometric bounds, and proving their actual
endpoint integrals finite also remain unsupplied. Even completing the spatial
bridge would not discharge these global analytic obligations or solve Statement B.

No added axiom, sorry, changed established theorem, or claimed Millennium solution.
