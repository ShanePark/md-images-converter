
if [ $# -eq 0 ]; then
  echo "Please provide a markdown file path as an argument."
  exit 1
fi

markdown_file="$1"
assets_folder="${markdown_file%.md}.assets"
temp_markdown_file="${markdown_file%.md}_temp.md"

# Function to convert image files to WebP and delete original files
convert_to_webp() {
  for image_file in "$assets_folder"/*; do
    if [ -e "$image_file" ]; then
      extension="${image_file##*.}"
      
      if [ "$extension" != "webp" ]; then
        webp_file="${image_file%.$extension}.webp"
        
        if [ "$extension" == "gif" ]; then
          gif2webp -q 60 "$image_file" -o "$webp_file" && rm "$image_file"
        else
          cwebp -q 60 "$image_file" -o "$webp_file" && rm "$image_file"
        fi
        
        extensions_to_replace="$extensions_to_replace|$extension"
      fi
    fi
  done
}

extensions_to_replace=""

# Convert all non-WebP image files to WebP and delete original files
convert_to_webp

# Remove the leading '|' character from the list of extensions
extensions_to_replace="${extensions_to_replace#|}"

# Replace the image file extensions with .webp in the markdown file
if [ -n "$extensions_to_replace" ]; then
  sed -E "s/\.($extensions_to_replace)/.webp/g" "$markdown_file" > "$temp_markdown_file"

  # Replace the original markdown file with the modified one
  mv "$temp_markdown_file" "$markdown_file"
fi