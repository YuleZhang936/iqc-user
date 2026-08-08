# IQC v1.0.2 Binary User Distribution

This release provides a binary-only offline installer for Linux x86_64,
CPython 3.12, CUDA 12 runtime wheels, and NVIDIA A100/A800 GPUs (`sm_80`).

IQC binary releases are licensed under the PolyForm Noncommercial License 1.0.0.
Commercial use requires a separate commercial license from the IQC authors.

Built from IQC source commit:

- `932ace48ef8b998176d8850b9927aea0a06d19c0`

## Changes Since v1.0.1

- Made the IQC GPU chemistry runtime self-contained, including molecular,
  basis-set, SCF, XC, integral, symmetry, and CUDA runtime components.
- Added and optimized multi-GPU execution for SCF, FTROKS, direct JK, XC grids,
  and SATDDFT response calculations.
- Added CUDA FFI paths for direct JK and semilocal XC contractions, together
  with bounded-memory and sharded response workflows for larger calculations.
- Added FT-SATDDFT transition-density and oscillator-strength analysis.
- Added analytic GPU molecular dipole integrals and SATDDFT oscillator strengths.
- Upgraded the packaged runtime to JAX 0.11 and refreshed public examples and
  native installation support.

## Assets

- `iqc-linux-x64-cp312-cu12-sm80.tar.gz.part00`
- `iqc-linux-x64-cp312-cu12-sm80.tar.gz.part01`
- `PARTS_SHA256SUMS.txt`
- `SHA256SUMS.txt`

Join the parts before installation:

```bash
sha256sum -c PARTS_SHA256SUMS.txt
cat iqc-linux-x64-cp312-cu12-sm80.tar.gz.part* > iqc-linux-x64-cp312-cu12-sm80.tar.gz
sha256sum -c SHA256SUMS.txt
tar -xf iqc-linux-x64-cp312-cu12-sm80.tar.gz
cd iqc-linux-x64-cp312-cu12-sm80
bash install.sh
```

On macOS, replace `sha256sum -c` with `shasum -a 256 -c`.

## Validation

The package was validated with a fresh user-style offline install from the
generated release tarball on an NVIDIA A100-SXM4-80GB worker, with the process
restricted to one GPU. The installer verification passed with:

- IQC installed as version `1.0.2`
- 133 IQC compiled `.so` modules installed
- no non-`__init__.py` IQC Python source files exposed
- JAX and CuPy detecting the selected CUDA device
- the IQC direct-JK CUDA FFI loading successfully
- CUDA/JAX smoke testing passing
- installed-package imports for SATDDFT transition analysis passing
- analytic dipole-integral value and origin-shift smoke testing passing

Verification finished with `IQC VERIFY OK`.
