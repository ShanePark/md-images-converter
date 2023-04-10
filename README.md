# Typora Markdown images into webp

## requirements

```bash
brew install ack
brew install webp
```

## Instrument

1. find where the md file is

```bash
ack 'blog comtents text'
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
