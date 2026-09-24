#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-v2.0.0}"
REPO="YuleZhang936/iqc-user"
BASE_URL="${IQC_RELEASE_BASE_URL:-https://github.com/${REPO}/releases/download/${TAG}}"
PACKAGE="iqc-linux-x64-cp312-cu12-sm80.tar.gz"
DEST="${IQC_DOWNLOAD_DIR:-iqc-${TAG}}"

mkdir -p "$DEST"
cd "$DEST"

checksum_check() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum -c "$1"
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 -c "$1"
  else
    echo "missing sha256sum or shasum" >&2
    exit 1
  fi
}

download() {
  local name="$1"
  echo "download: $name"
  curl -L --fail --retry 3 -o "${name}.download" "${BASE_URL}/${name}"
  mv -- "${name}.download" "$name"
}

download SHA256SUMS.txt
download PARTS_SHA256SUMS.txt
PARTS=()
while read -r digest name extra; do
  [[ -z "${digest:-}" ]] && continue
  if [[ ! "$digest" =~ ^[[:xdigit:]]{64}$ || -n "${extra:-}" || ! "$name" =~ ^iqc-linux-x64-cp312-cu12-sm80\.tar\.gz\.part[0-9]+$ ]]; then
    echo 'Invalid release part manifest' >&2
    exit 1
  fi
  PARTS+=("$name")
done < PARTS_SHA256SUMS.txt
if [[ ${#PARTS[@]} -eq 0 ]]; then
  echo 'Empty release part manifest' >&2
  exit 1
fi
for part in "${PARTS[@]}"; do
  download "$part"
done
checksum_check PARTS_SHA256SUMS.txt
cat "${PARTS[@]}" > "${PACKAGE}.download"
mv -- "${PACKAGE}.download" "$PACKAGE"
checksum_check SHA256SUMS.txt
tar -xf "$PACKAGE"
echo "IQC release extracted: ${DEST}/${PACKAGE%.tar.gz}"
echo 'Next:'
echo "  cd ${DEST}/${PACKAGE%.tar.gz}"
echo '  bash install.sh'
