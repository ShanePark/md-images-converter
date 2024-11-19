# Markdown Image Processor

> Convert to WebP and Update Image Paths

## Requirements

```bash
brew install ack
brew install webp
```

## Overview

This script automates the following tasks for Markdown files:

1. **Convert images to WebP format:** All images in the `.assets` folder are converted to the WebP format to optimize file size and performance.
2. **Update relative image paths:** Relative image paths in the Markdown file are replaced with absolute external paths, pointing to your GitHub repository for seamless web integration.

By running this script, markdown files will be optimized for upload to GitHub with all image paths updated to direct links.

## Instrument

### Step 1: Find Your Markdown File

You can locate the Markdown file you wish to process by searching for specific content:

```bash
ack 'blog post content text'
```

### Step 2: Execute the Script

```bash
./mdblog.sh myfile.md
```

### Step 3: Results

The script performs the following:

- **Convert Images to WebP:** All images in the `.assets` folder associated with the Markdown file will be converted to `.webp` format. The original files are deleted after conversion.

- Update Image Paths in Markdown:

  - Relative image paths like `](./watermark.assets/image.png)` are replaced with absolute paths pointing to my GitHub repository

    ```
    ](https://raw.githubusercontent.com/YourUsername/YourRepo/main/path/to/image.webp)
    ```

### Step 4: Upload Files

Once the script has processed your files, you can upload the updated Markdown file and WebP images to your GitHub repository.

## Batch Processing

If you want to run it for all your `.md` files, use `md-worker.sh`

```bash
./md-worker.sh ~/Documents/GitHub/markdownBlog/
```

remember, it takes pretty long time, and also there's no GPU acceleration for cwebp yet

after it copies all `.md` files into output folder, then you can easily find the file and open with typora

```bash
typora $(find . -name 'webstorage.md')
```

Then you only need to search the post with `#H1` Then update each.
