# generate-sitemap

A lightweight GitHub Action to generate a `sitemap.xml` from `.html` and `.md` files in your repository.
Ideal for static sites hosted on GitHub Pages — no runtime or external dependencies required.

> Markdown files are treated as if converted to `.html` (like GitHub Pages does).

## Features

* Converts `.md` files to `.html` in the sitemap
* Ignores dotfiles and hidden folders
* Supports custom base URL, input folder, and output path
* Zero dependencies – runs as a bash script

## Usage

Add this to your GitHub Actions workflow:

```yaml
- name: Generate sitemap
  uses: guimauvedigital/generate-sitemap@v1
  with:
    base_url: "https://example.com"
    output_path: "public/sitemap.xml"
    input_dir: "public"
```

You can also use it with defaults:

```yaml
- name: Generate sitemap
  uses: guimauvedigital/generate-sitemap@v1
  with:
    base_url: "https://example.com"
```

## Inputs

| Name          | Required | Default       | Description                                                |
| ------------- | -------- | ------------- | ---------------------------------------------------------- |
| `base_url`    | ✅ Yes    | —             | The base URL of your website (e.g., `https://example.com`) |
| `output_path` | ❌ No     | `sitemap.xml` | Where to write the generated sitemap file                  |
| `input_dir`   | ❌ No     | `.`           | Directory to scan for `.html` / `.md` files                |

## Example File Structure

```
├── public/
│   ├── index.html
│   ├── about.md        ← becomes about.html in sitemap
│   └── blog/
│       └── post.md     ← becomes blog/post.html
```

With `input_dir: public`, this produces:

```xml
<url>
  <loc>https://example.com/index.html</loc>
  ...
</url>
<url>
  <loc>https://example.com/about.html</loc>
  ...
</url>
<url>
  <loc>https://example.com/blog/post.html</loc>
  ...
</url>
```

## Development

This action uses a simple shell script: [`generate_sitemap.sh`](./generate_sitemap.sh).
You can run it locally to test:

```bash
bash generate_sitemap.sh https://example.com ./sitemap.xml ./public
```

## Versioning

* Use `@v1` to always get the latest v1 version
* Use tags like `@v1.0.0` for a specific version
