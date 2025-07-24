#!/bin/bash

# Check if pubspec.yaml file exists
if [ ! -f "pubspec.yaml" ]; then
  echo "pubspec.yaml file not found!"
  exit 1
fi

# Extract name and version properties and concatenate them
name=$(grep -m 1 "name:" pubspec.yaml | awk '{print $2}')
version=$(grep -m 1 "version:" pubspec.yaml | awk '{print $2}')

if [ -z "$name" ] || [ -z "$version" ]; then
  echo "Failed to extract name and/or version from pubspec.yaml"
  exit 1
fi

result="${name}@${version}"
echo $result