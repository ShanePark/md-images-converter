if [ $# -eq 0 ]; then
  echo "Please provide a markdown file path as an argument."
  exit 1
fi

markdown_file="$1"
assets_folder="${markdown_file%.md}.assets"

# Function to convert image files to WebP, rename, and delete original files
convert_to_webp_and_rename() {
  index=1
  for image_file in "$assets_folder"/*; do
    if [ -e "$image_file" ]; then
      extension="${image_file##*.}"
      
      if [ "$extension" != "webp" ]; then
        webp_file="${assets_folder}/${index}.webp"
        
        if [ "$extension" == "gif" ]; then
          gif2webp "$image_file" -o "$webp_file" && rm "$image_file"
        else
          cwebp "$image_file" -o "$webp_file" && rm "$image_file"
        fi
        
        # Update the markdown file with the new image file name
        if [[ "$OSTYPE" == "darwin"* ]]; then
          sed -i '' -E "s!$(basename "$image_file")!$(basename "$webp_file")!g" "$markdown_file"
        else
          sed -i -E "s!$(basename "$image_file")!$(basename "$webp_file")!g" "$markdown_file"
        fi
        index=$((index+1))
      fi
    fi
  done
}

convert_to_webp_and_rename
