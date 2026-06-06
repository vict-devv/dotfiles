#!/usr/bin/env bash

echo "============================================"
echo "ASDF - Install Plugins Latest Versions"
echo "============================================"

# 1. Check if asdf is installed
if ! command -v asdf &>/dev/null; then
  echo "❌ASDF is not installed. Exiting..."
  exit 1
fi

# 2. Metric counters
success_count=0
failure_count=0

# 3. Main update loop that checks only for the tools which latest versions are "missing"
# It not only installed them but also set them as the current version.
while read -r tool version status; do
  if [[ "$status" == "missing" ]]; then
    if asdf install "$tool" "$version"; then
      echo "✅Installed $tool $version successfully!"
      asdf set -u $tool $version
      echo "✅$tool $version set as the current version!"
      ((success_count++))
    else
      echo "⚠️Warning: failed to install $tool for version $version."
      ((failure_count++))
      continue
    fi
  else
    echo "✅$tool latest version $version is already installed!"
  fi
done < <(asdf latest --all)

# 4. Print Summary
echo "======================================"
echo "✅Total: $((success_count + failure_count))"
echo "✅Success: $success_count"
echo "❌Failure: $failure_count"
echo "======================================"
echo
echo "✅Execution completed! Bye!"
