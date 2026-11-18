# IQC v2.1.0

## Input-file interface

- Run calculations with `iqc calculation.inp`. Input files contain a route,
  title, charge and multiplicity, and Cartesian coordinates.
- Use `--check` to validate input and basis data before starting a calculation.
- Reports include SCF progress, energies, response roots and termination status;
  a separate JSON file records settings and results.
- The installer creates a `./iqc` launcher that activates the installed
  environment automatically.
- Public examples now contain 17 `.inp` files and documentation. Response
  examples use HF references, including TDHF/TDA and spin-adapted response.
- Python calculation APIs remain available for research scripts.

## Response properties

Spin-adapted response includes relaxed interstate transition densities and
transition dipoles. The response-property implementation uses matrix-free
operations to reduce storage requirements. The former canonical thermal-spectrum
extension has been removed; the v2.0.0 thermal example and its associated APIs
are not part of this release.

## Installation and compatibility

Use a fresh installation directory and virtual environment. The target remains
Linux x86_64, CPython 3.12, CUDA 12, and NVIDIA A100/A800 (`sm_80`). See the bundled
`COMPAT.md` for platform and runtime requirements and build details.

The archive contains the complete wheelhouse for offline installation. Download
all numbered archive parts and both checksum manifests from this release.
The download script checks the parts and joined archive before extraction.

IQC implementation modules are compiled. Public examples contain input files
and documentation; internal research scripts and datasets are excluded.

## Validation

The binary package was installed offline into a new virtual environment on an
NVIDIA A100 40 GB node. Installation verified the GPU runtime, all four CUDA FFI
extensions, the command entry point, and the absence of IQC implementation
source files. Native-library checks found no absolute build-machine runtime
paths; required symbols are at most GLIBC 2.34 and GLIBCXX 3.4.29.

A complete CO/para-benzyne calculation with aug-cc-pVTZ finished successfully
using the installed binary package and fresh JAX/CuPy caches. It included
BHHLYP SA-TDA, unrelaxed and relaxed interstate transition densities, and
SA7-CASSCF reference calculations. The validation environment additionally
installed PySCF 2.14.0 for the reference calculations. Default numerical settings
were retained. Wall times were approximately 142 s for CO and 1074 s for
para-benzyne on one A100 with 16 CPU threads.

The installed package passed 15 fast regression tests and 6 input-command
end-to-end tests, including comparison with the Python calculation API.
All 17 public input examples completed successfully. One multi-GPU test was
skipped because validation exposed one GPU. The other slower test suites were
not part of this release-validation run.
