# Typora Markdown images into webp

## requirements

```bash
brew install ack
brew install webp
```

## Instrument

1. find where the md file is

```bash
ack 'blog post content text'
```

2. execute shell

```bash
./webp.sh myfile.md
```

Then it will 

- convert all images in `.assets` into webp
- change all image path in `.md` file into `.webp`

3. upload

That's it. now You can then upload your own enhanced md file and images

## Batch

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
