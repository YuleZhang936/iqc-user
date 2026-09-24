# IQC User Distribution

This repository provides the binary IQC user distribution. The offline package
includes compiled IQC implementation modules, dependency wheels, public
examples and installation checks.

## License

IQC binary releases are licensed under the PolyForm Noncommercial License 1.0.0.
Commercial use requires a separate commercial license from the IQC authors.
Third-party dependencies retain their respective licenses. See `LICENSE` and
`NOTICE`.

## Requirements

- Linux x86_64 with an x86-64-v2 CPU and glibc 2.34 or newer
- A C++ runtime providing `GLIBCXX_3.4.29` (GCC 11 or compatible)
- CPython 3.12.x with `venv` support
- NVIDIA A100/A800 GPU (`sm_80`)
- A working NVIDIA driver compatible with the bundled CUDA 12 runtime

See the package's `COMPAT.md` for platform and runtime requirements. The normal
installation does not require a system CUDA toolkit or access to a Python
package index.

## Download and install

```bash
curl -L --fail -O https://raw.githubusercontent.com/YuleZhang936/iqc-user/main/download_iqc.sh
bash download_iqc.sh v2.0.0
cd iqc-v2.0.0/iqc-linux-x64-cp312-cu12-sm80
bash install.sh
source .venv-iqc/bin/activate
python verify.py
```

The download script uses a directory for the selected version, reads the part
list from the release manifest, verifies each part, joins the archive and
verifies it before extraction. Downloads require internet access; installation
from the downloaded package is offline.

If necessary, select Python explicitly:

```bash
PYTHON=/path/to/python3.12 bash install.sh
```

## Examples

After installation and activation:

```bash
python examples/dft/rks.py
python examples/tddft/rtd.py
python examples/satddft/h2o.py
python examples/satddft/thermal.py --output thermal-spectrum
IQC_IXC_HE_STEPS=0 python examples/ixc/he.py
```

The thermal example constructs a canonical spectrum from stationary SA-TDDFT
states and transition dipoles. Temperature changes the state populations;
it does not reoptimize orbitals.

## Manual download

Download every numbered `.tar.gz.partNN` asset, `PARTS_SHA256SUMS.txt` and
`SHA256SUMS.txt` from the same release into an empty directory. Then run:

```bash
sha256sum -c PARTS_SHA256SUMS.txt
cat iqc-linux-x64-cp312-cu12-sm80.tar.gz.part* > iqc-linux-x64-cp312-cu12-sm80.tar.gz
sha256sum -c SHA256SUMS.txt
tar -xf iqc-linux-x64-cp312-cu12-sm80.tar.gz
```

On macOS, use `shasum -a 256 -c` for checksum verification. The package itself
runs on the Linux target specified above.

## Updating from v1.0.2

Use a fresh virtual environment for v2.0.0. Read
[the v2.0.0 release notes](RELEASE_NOTES_v2.0.0.md) for API changes and removed
finite-temperature methods.

## Source visibility

IQC implementation modules are compiled; package `__init__.py` files and
runtime data remain in the wheel. Public example scripts are distributed as
Python source. The package excludes internal research scripts and datasets.
