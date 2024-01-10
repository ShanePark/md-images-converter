#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Please provide a markdown file path as an argument."
  exit 1
fi

markdown_file="$1"
assets_folder="${markdown_file%.md}.assets"

# Function to execute sed command with compatibility for macOS and other OSes
run_sed() {
  local pattern=$1
  local sed_option='-i -E'
  [[ "$OSTYPE" == "darwin"* ]] && sed_option='-i '' -E'
  sed $sed_option "$pattern" "$markdown_file"
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

convert_to_webp_and_rename
