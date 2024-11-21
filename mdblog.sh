#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Please provide a markdown file path as an argument."
  exit 1
fi

markdown_file="$1"
assets_folder="${markdown_file%.md}.assets"

run_sed() {
  local pattern=$1
  sed '-i '' -E' "$pattern" "$markdown_file"

  # MacOS
  if [[ -e "${markdown_file}-E" ]]; then
    rm -f "${markdown_file}-E"
  fi

  # Linux
  if [[ -e "${markdown_file}  -E" ]]; then
    rm -f "${markdown_file}  -E"
  fi
}

# Function to convert image files to WebP, rename, and delete original files
convert_to_webp_and_rename() {
  index=1
  for image_file in "$assets_folder"/*; do
    if [ -e "$image_file" ]; then
      extension="${image_file##*.}"

      if [ "$extension" != "webp" ]; then
        webp_file="${assets_folder}/${index}.webp"

        # Convert image file to WebP
        if [ "$extension" == "gif" ]; then
          gif2webp "$image_file" -o "$webp_file" && rm "$image_file"
        else
          cwebp "$image_file" -o "$webp_file" && rm "$image_file"
        fi

        # Update alt text
        filename_without_ext=$(basename "$image_file" .$extension)
        run_sed "s|\[${filename_without_ext}\]|[${index}]|g"

        # Update image file name
        run_sed "s|$(basename "$image_file")|${index}.webp|g"

        index=$((index + 1))
      fi
    fi
  done
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

# Function to replace relative paths with absolute paths in the markdown file
replace_relative_paths_with_absolute() {
  # Get the absolute path to the markdown file's directory
  markdown_file_abs_path="$(
    cd "$(dirname "$markdown_file")"
    pwd
  )"

  # Replace `](./` with the absolute path
  run_sed "s|](\./|](${markdown_file_abs_path}/|g"
}

replace_relative_paths_with_absolute
convert_to_webp_and_rename
replace_paths_with_urls
