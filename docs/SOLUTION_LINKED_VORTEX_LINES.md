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

## Actual spatial bridge: now proved

`ActualSpatialBridge.lean` proves the exact existing `SpatialBridgeObligation`.
It does not replace the target or add a regularity supplement:

1. `spatialC2_of_NSOn` restricts the existing joint `ContDiffOn` hypothesis
   to a fixed-time spatial slice, including time zero.
2. `pd_pd_comm` derives equality of actual mixed partials from C2 smoothness;
   `div_curl_eq_zero` proves actual div(curl u)=0 by cancellation.
3. `curl_differentiable_of_C2` and `norm_direction_derivative` use actual
   differentiability, normalization and the product rule to obtain the norm
   derivative in the actual normalized-curl direction.
4. `logDerivativeAlong_of_spatialC2` combines this with the packet tangent
   equation and nonvanishing to prove the actual log-vorticity differential
   equation along the curve.
5. `spatialComparison_of_logDerivativeAlong` applies FTC to the actual
   integrated divergence and exponentiates its bound. The intermediate
   `LogDerivativeAlong` premise is derived, not assumed, in the final theorem.
6. `spatialComparison_of_NSOn` and `spatialBridgeObligation_proved` discharge
   the original spatial target without assumed comparison or new calculus premises.
7. `bkmIntegralFinite_of_NSOn_and_endpoint` uses the proved comparison and
   the separately supplied actual endpoint integral to deduce BKM finiteness.

The argument uses only spatial smoothness from NSOn; the momentum equation,
positive viscosity and velocity incompressibility are not needed for the identity
that div(curl)=0. It is the spatial Lemma 1 / equation (3.2) argument in DHY
Theorem 1, not an Euler transport argument. No Euler-only Theorem 2 is transferred.

## Still needed for a regularity argument

The packet type does not include endpoint-integral finiteness or BKM finiteness.
EndpointIntegralFinite is a separate, unproved-for-general-data hypothesis as
in the cited theorem. Constructing suitable measurable packets for arbitrary
solutions, proving their uniform geometric bounds, and proving their actual
endpoint integrals finite also remain unsupplied. Completing the spatial
bridge does not discharge these global analytic obligations or solve Statement B.

No added axiom, sorry, changed established theorem, or claimed Millennium solution.
