#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Please provide a markdown file path as an argument."
  exit 1
fi

markdown_file="$1"

run_sed() {
  local pattern=$1
  local sed_option='-i -E'
  [[ "$OSTYPE" == "darwin"* ]] && sed_option='-i '' -E'
  sed $sed_option "$pattern" "$markdown_file"
}

# Function to replace local file paths with GitHub URLs
replace_paths_with_urls() {
  macos_path="/Users/shane/Documents/GitHub/mdblog/"
  linux_path="/home/shane/Documents/git/shane/mdblog/"
  github_url="https://raw.githubusercontent.com/ShanePark/mdblog/main/"

  # Replace local file paths with GitHub URLs
  if [[ "$OSTYPE" == "darwin"* ]]; then
    run_sed "s!${macos_path}!${github_url}!g"
  else
    run_sed "s!${linux_path}!${github_url}!g"
  fi
  echo "[Completed] Local file paths replaced with GitHub URLs."
}

replace_paths_with_urls
