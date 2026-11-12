# Note: why linear enstrophy-history growth does not imply BKM blow-up

This note folds the former companion repo *Clay-CD-not-certified* (Zenodo v2.1.0, DOI 10.5281/zenodo.23959184; concept DOI 10.5281/zenodo.23653014) into Clay-.

`lean/Clay/Notes/NotBlowup.lean` records two definitional identities. With a constant vorticity sup-norm `M`, the BKM integral over `[0,T]` is `M*T`, which is finite. The quadratic history `M*M*T` still grows linearly in `T`. So linear history growth alone does not signal BKM blow-up. Both statements hold by `rfl`; they are a worked illustration, not analysis. They neither prove nor disprove Fefferman (C) or (D), and nothing here claims the Millennium problem is solved.
