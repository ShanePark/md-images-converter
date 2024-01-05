if [ $# -eq 0 ]; then
  echo "Please provide a markdown file path as an argument."
  exit 1
fi

markdown_file="$1"

# Function to replace local file paths with GitHub URLs
replace_paths_with_urls() {
  linux_path="/home/shane/Documents/git/shane/mdblog/"
  github_url="https://raw.githubusercontent.com/ShanePark/mdblog/main/"

  # Replace local file paths with GitHub URLs
  sed -i -E "s!${linux_path}!${github_url}!g" "$markdown_file"
  echo "[Completed] Local file paths replaced with GitHub URLs."
}

replace_paths_with_urls