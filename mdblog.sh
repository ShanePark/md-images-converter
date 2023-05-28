if [ $# -eq 0 ]; then
  echo "Please provide a markdown file path as an argument."
  exit 1
fi

markdown_file="$1"

# Function to replace local file paths with GitHub URLs
replace_paths_with_urls() {
  local_path="/Users/shane/Documents/GitHub/mdblog/"
  github_url="https://raw.githubusercontent.com/ShanePark/mdblog/main/"

  # Replace local file paths with GitHub URLs
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -E "s!${local_path}!${github_url}!g" "$markdown_file"
  else
    sed -i -E "s!${local_path}!${github_url}!g" "$markdown_file"
  fi
}

replace_paths_with_urls