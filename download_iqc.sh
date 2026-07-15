#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-v1.0.1}"
REPO="YuleZhang936/iqc-user"
BASE_URL="https://github.com/${REPO}/releases/download/${TAG}"
PACKAGE="iqc-linux-x64-cp312-cu12-sm80.tar.gz"
PARTS=(
  "${PACKAGE}.part00"
  "${PACKAGE}.part01"
)

checksum_check() {
  local file="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum -c "${file}"
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 -c "${file}"
  else
    echo "missing sha256sum or shasum" >&2
    exit 1
  fi
}

download() {
  local name="$1"
  if [ -f "${name}" ]; then
    echo "exists: ${name}"
    return
  fi
  echo "download: ${name}"
  curl -L --fail -O "${BASE_URL}/${name}"
}

download "SHA256SUMS.txt"
download "PARTS_SHA256SUMS.txt"
for part in "${PARTS[@]}"; do
  download "${part}"
done

checksum_check "PARTS_SHA256SUMS.txt"
cat "${PARTS[@]}" > "${PACKAGE}"
checksum_check "SHA256SUMS.txt"
tar -xf "${PACKAGE}"

echo "IQC release extracted: iqc-linux-x64-cp312-cu12-sm80"
echo "Next:"
echo "  cd iqc-linux-x64-cp312-cu12-sm80"
echo "  bash install.sh"
