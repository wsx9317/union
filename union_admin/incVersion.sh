#!/bin/bash

# Read the HTML file content
html=$(cat index_admin.html)

# Extract the current serviceWorkerVersion
old_version=$(echo "$html" | grep -o 'const serviceWorkerVersion = "[0-9]*";' | grep -o '[0-9]*')

# Increment the version
new_version=$((old_version + 1))

# Replace the old version with the new version in the HTML file
new_html=$(echo "$html" | sed "s/const serviceWorkerVersion = \"$old_version\"/const serviceWorkerVersion = \"$new_version\"/")

# Update the HTML file
echo "$new_html" > index_admin.html
