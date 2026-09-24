# IQC v2.0.0 Binary User Distribution

This release provides an offline binary installer for Linux x86_64,
CPython 3.12, CUDA 12 and NVIDIA A100/A800 GPUs (`sm_80`).

IQC binary releases are licensed under the PolyForm Noncommercial License 1.0.0.
Commercial use requires a separate commercial license from the IQC authors.

## Changes since v1.0.2

- Added periodic Gaussian-orbital support, GTH pseudopotentials,
  periodic SCF and DFT, and AFT, Gaussian density-fitting and direct J/K backends.
- Added finite-wavevector TDHF and spin-adapted TDDFT response for periodic
  systems.
- Added GPU density inversion with molecular initialization and spin-resolved
  targets.
- Improved molecular SA-TDDFT J/K and XC contractions, charge response and GPU
  memory use.
- Added canonical thermal populations, spectra and time-dependent response
  from stationary electronic states, with a public thermal SA-TDDFT example.
- Updated the binary runtime, dependency bundle and installation checks.

## Compatibility changes

- This build requires an x86-64-v2 CPU, glibc 2.34 or newer, and a C++ runtime
  providing `GLIBCXX_3.4.29`. See the bundled `COMPAT.md`.
- Gaussian-orbital implementations are organized under `iqc.gto`. Code that
  imports internal implementation modules may need updated import paths.
  The bundled examples demonstrate the current user APIs.
- Removed FTROKS and the previous finite-temperature SATDDFT implementation.
  The new `iqc.thermal` workflow applies canonical populations to stationary
  states; it does not perform temperature-dependent orbital optimization.
- Install v2.0.0 into a fresh virtual environment instead of updating an
  existing v1.0.2 environment in place.

## Download and install

```bash
curl -L --fail -O https://raw.githubusercontent.com/YuleZhang936/iqc-user/main/download_iqc.sh
bash download_iqc.sh v2.0.0
cd iqc-v2.0.0/iqc-linux-x64-cp312-cu12-sm80
bash install.sh
source .venv-iqc/bin/activate
python verify.py
```

Release assets contain all archive parts, `PARTS_SHA256SUMS.txt` and
`SHA256SUMS.txt`. The download script verifies the parts and combined archive.
The installer uses only the bundled wheels and checks the installed package.
