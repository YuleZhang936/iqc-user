# IQC User Distribution

This repository provides the binary IQC user distribution. The offline package
includes compiled IQC modules, dependency wheels, `.inp` calculation examples
and installation checks.

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
bash download_iqc.sh v2.1.0
cd iqc-v2.1.0/iqc-linux-x64-cp312-cu12-sm80
bash install.sh
```

The download script verifies each archive part and the joined archive before
extraction. Downloads require internet access; installation from the downloaded
package is offline. The installer checks the GPU runtime and creates the `./iqc`
launcher, which activates its environment automatically.

If necessary, select Python explicitly:

```bash
PYTHON=/path/to/python3.12 bash install.sh
```

## Run a calculation

Edit an `.inp` file, check it, and run it:

```bash
./iqc --check examples/dft/rhf.inp
./iqc examples/dft/rhf.inp
./iqc examples/tddft/rtd.inp
./iqc examples/satddft/h2o.inp
```

A calculation writes `<input-name>.out` and `<input-name>.json` in the current
directory. The text report includes settings, SCF progress, energies and
termination status. Use `--output water.out` to choose a report name or
`--overwrite` to replace existing results.

The package contains 17 input examples covering HF/DFT, density fitting, X2C,
TDHF/TDA and spin-adapted response. Response examples use HF references.
See `examples/README.md` and `examples/INPUT.md` in the installed package for
the examples and complete input syntax. Input checks can run on a CPU/login
node after installation; calculations require a CUDA GPU.

To make `iqc` available directly in the current shell:

```bash
source .venv-iqc/bin/activate
iqc examples/dft/rhf.inp
```

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

## Updating

Install v2.1.0 in a fresh directory and virtual environment. Read
[the v2.1.0 release notes](RELEASE_NOTES_v2.1.0.md) for input-interface changes,
response-property updates and removed thermal-spectrum APIs. Existing Python
calculation APIs remain available for research workflows.

## Source visibility

IQC implementation modules are compiled; package `__init__.py` files and
runtime data remain in the wheel. Public calculation examples contain `.inp`
files and documentation. The package excludes internal research scripts and
datasets.
