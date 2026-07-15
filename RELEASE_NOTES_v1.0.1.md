# IQC v1.0.1 Binary User Distribution

This release provides a binary-only offline installer for Linux x86_64,
CPython 3.12, CUDA 12 runtime wheels, and NVIDIA A100/A800 GPUs (`sm_80`).

IQC binary releases are licensed under the PolyForm Noncommercial License 1.0.0.
Commercial use requires a separate commercial license from the IQC authors.

Built from IQC source commit:

- `74f12f5eeb49402192a842adf5ac0a26b17dd694`

## Changes Since v1.0.0

- Added SATDDFT natural-orbital and one-particle density-matrix analysis.
- Corrected equal-spin coupling, iterative minus-vector, and spin-square workflows.
- Improved open-shell and TDA-only SATDDFT workflows.
- Improved finite-temperature SATDDFT averaging and memory use.
- Updated public SATDDFT examples and radical-state labels.

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
generated release tarball on an 8 x A100-SXM4-80GB GPU worker, with the
verification process restricted to one GPU. The installer verification passed
with:

- IQC installed as version `1.0.1`
- 58 IQC compiled `.so` modules installed
- no non-`__init__.py` IQC Python source files exposed
- JAX detecting the selected CUDA device
- CuPy detecting the selected CUDA device
- the IQC CUDA FFI loading successfully
- CUDA/JAX smoke test passing

Verification finished with `IQC VERIFY OK`.
