#!/usr/bin/env python3
"""Check every \\declref{name}{file}{line} and every `lean{name} (lean{file}:line)`
reference in spatial_bridge.tex against the repository source.

A reference passes when the cited line of the cited file declares the cited
name (theorem/lemma/def/abbrev/structure/inductive, with optional attributes).
Exit status is nonzero on any failure. Run from this directory or anywhere.
"""
import pathlib
import re
import sys

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parent.parent
TEX = HERE / "spatial_bridge.tex"

DECL = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+)?(?:protected\s+)?"
    r"(?:theorem|lemma|def|abbrev|structure|inductive|class)\s+([^\s:({\[]+)")

def main() -> int:
    text = TEX.read_text(encoding="utf-8")
    # \declref paths are relative to lean/Clay/
    refs = [(n, "lean/Clay/" + f, l) for n, f, l in
            re.findall(r"\\declref\{([^}]*)\}\{([^}]*)\}\{(\d+)\}", text)]
    # \lean{name} (\lean{path}:NN) style references
    refs += re.findall(r"\\lean\{([^}]*)\}\s*\(\\lean\{([^}]*\.lean)\}:(\d+)\)", text)
    failures = []
    for name, path, line in refs:
        f = ROOT / path
        if not f.is_file():
            failures.append(f"{name}: missing file {path}")
            continue
        lines = f.read_text(encoding="utf-8").splitlines()
        n = int(line)
        if n < 1 or n > len(lines):
            failures.append(f"{name}: {path}:{n} out of range")
            continue
        m = DECL.match(lines[n - 1])
        declared = m.group(1) if m else None
        if declared is None or declared.split(".")[-1] != name.split(".")[-1]:
            failures.append(f"{name}: {path}:{n} declares {declared!r}: {lines[n-1].strip()!r}")
    # bare "(\lean{X}, line~N)" references inside the two Depletion files
    for name, n in re.findall(r"\\lean\{([A-Za-z_0-9.]+)\}[^\\]{0,40}?line~(\d+)", text):
        hits = []
        for path in ("lean/Clay/Depletion/SolutionLinkedVortexLines.lean",
                     "lean/Clay/Depletion/ActualSpatialBridge.lean"):
            lines = (ROOT / path).read_text(encoding="utf-8").splitlines()
            k = int(n)
            if 1 <= k <= len(lines):
                m = DECL.match(lines[k - 1])
                if m and m.group(1) == name:
                    hits.append(path)
        refs.append((name, "line", n))
        if not hits:
            failures.append(f"{name}: no Depletion file declares it at line {n}")
    print(f"checked {len(refs)} references")
    for f in failures:
        print("FAIL", f)
    return 1 if failures else 0

if __name__ == "__main__":
    sys.exit(main())
