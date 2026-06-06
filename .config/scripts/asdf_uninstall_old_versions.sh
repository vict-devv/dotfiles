#!/usr/bin/env bash

echo "============================================"
echo "ASDF - Uninstall Plugins Old Versions"
echo "============================================"

# 1. Check if asdf is installed.
if ! command -v asdf &>/dev/null; then
  echo "❌ASDF is not installed. Exiting..."
  exit 1
fi

# 2.1 Core variables.
current_plugin=""
latest_version=""

# 2.2 Metric counters
success_count=0
failed_count=0

# 3. Main loop to traverse the installed plugins, compare the current version with the latest one,
# install the latest version and uninstall the old ones if any. Observation: we need to clear the
# IFS variable, otherwise the `read` command will automatically trim spaces for every single line.
while IFS= read -r line; do
  # The `asdf list` output has indented lines for versions
  if [[ "$line" =~ ^[[:space:]] ]]; then
    # Trim leading spaces and asterisk with xargs and tr to clear version value
    version=$(echo "$line" | xargs | tr -d "*")
    if [[ "$version" != "$latest_version" ]]; then
      # Remove old version if it doesn't match the latest one.
      if ! asdf uninstall "$current_plugin" "$version" 2>/dev/null; then
        echo "⚠️Warning: could not uninstall $current_plugin $version". Skipping...
        ((failed_count++))
        continue
      fi
      echo "✅Uninstalled old $current_plugin $version."
      ((success_count++))
    else
      echo "✅$current_plugin current version for is already the latest: $version."
    fi
  else
    # Capture the value of the current plugin, no trim needed.
    current_plugin="$line"
    # Check for its latest version, install it and set as the current version.
    if ! latest_version=$(asdf latest $current_plugin 2>/dev/null); then
      echo "⚠️Warning: could not find the latest version for $current_plugin. Skipping..."
      continue
    fi
  fi
done < <(asdf list)

# 4. Display Summary
echo "============================================"
echo "✅Total Plugins versions: $((success_count + failed_count))"
echo "✅Success Uninstalls: $success_count"
echo "❌Failed Uninstalls: $failed_count"
echo "============================================"
echo
echo "✅Execution completed! Bye!"
