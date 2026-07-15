# IQC User Distribution

This repository hosts the public binary-only IQC user distribution.

IQC source code is not included in this repository or in the release
installer. The installer contains compiled IQC extension modules, dependency
wheels, verification scripts, and public examples.

## License

IQC binary releases are licensed under the PolyForm Noncommercial License 1.0.0.
Commercial use requires a separate commercial license from the IQC authors.

Third-party dependencies included in the offline wheelhouse remain governed by
their respective licenses.

## Requirements

- Linux x86_64
- CPython 3.12.x with `venv` support
- NVIDIA A100/A800 GPU (`sm_80`)
- NVIDIA driver with `nvidia-smi`
- Driver support for CUDA 12 applications

An installed CUDA toolkit is not required for normal installation. The release
bundle includes CUDA 12 user-space Python wheels.

## Download

Download the release bundle from the latest GitHub Release:

```bash
curl -L -O https://raw.githubusercontent.com/YuleZhang936/iqc-user/main/download_iqc.sh
bash download_iqc.sh v1.0.1
```

The script downloads all release parts, verifies each part, joins them into
`iqc-linux-x64-cp312-cu12-sm80.tar.gz`, verifies the joined tarball, and
extracts it.

## Install

```bash
cd iqc-linux-x64-cp312-cu12-sm80
bash install.sh
source .venv-iqc/bin/activate
python verify.py
```

If Python 3.12 is not named `python3.12`, pass it explicitly:

```bash
PYTHON=/path/to/python3.12 bash install.sh
```

## Examples

After installation and activation:

```bash
python examples/dft/rks.py
python examples/tddft/rtd.py
python examples/satddft/h2o.py
IQC_IXC_HE_STEPS=0 python examples/ixc/he.py
```

## Manual Download

If you prefer not to use `download_iqc.sh`, download these release assets into
one directory:

- `iqc-linux-x64-cp312-cu12-sm80.tar.gz.part00`
- `iqc-linux-x64-cp312-cu12-sm80.tar.gz.part01`
- `PARTS_SHA256SUMS.txt`
- `SHA256SUMS.txt`

Then run:

```bash
sha256sum -c PARTS_SHA256SUMS.txt
cat iqc-linux-x64-cp312-cu12-sm80.tar.gz.part* > iqc-linux-x64-cp312-cu12-sm80.tar.gz
sha256sum -c SHA256SUMS.txt
tar -xf iqc-linux-x64-cp312-cu12-sm80.tar.gz
```

On macOS, replace `sha256sum -c` with `shasum -a 256 -c`.

## Source Visibility

The IQC wheel contains compiled extension modules and package `__init__.py`
files only. Core modules such as `iqc.scf`, `iqc.xc`, and
`iqc.satddft.sadrive` are installed as `.so` files.

Native binaries can still be analyzed by determined reverse engineering. For
stronger IP protection, run IQC as a server-side service.
