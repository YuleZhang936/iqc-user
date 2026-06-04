# IQC v0.1.0 Binary User Distribution

This release provides a binary-only offline installer for Linux x86_64,
CPython 3.12, CUDA 12 runtime wheels, and NVIDIA A100/A800 GPUs (`sm_80`).

IQC binary releases are licensed under the PolyForm Noncommercial License 1.0.0.
Commercial use requires a separate commercial license from the IQC authors.

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

The package was validated with a fresh user-style install from the generated
release tarball. The installer verification passed with:

- IQC core modules installed as compiled `.so` files
- no non-`__init__.py` IQC Python source files exposed
- CUDA/JAX smoke test passing on one GPU

Representative public examples were also run successfully:

- `examples/dft/rks.py`
- `examples/tddft/rtd.py`
- `examples/satddft/h2o.py`
- `examples/ixc/he.py`
