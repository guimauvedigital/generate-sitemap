#!/bin/bash
set -e

BASE_URL="$1"
OUTPUT_FILE="$2"
INPUT_DIR="$3"

if [ -z "$BASE_URL" ]; then
  echo "Error: Missing base URL."
  echo "Usage: $0 <base_url> <output_path> <input_dir>"
  exit 1
fi

if [ -z "$OUTPUT_FILE" ]; then
  OUTPUT_FILE="sitemap.xml"
fi

if [ -z "$INPUT_DIR" ]; then
  INPUT_DIR="."
fi

NOW="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

echo '<?xml version="1.0" encoding="UTF-8"?>' > "$OUTPUT_FILE"
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' >> "$OUTPUT_FILE"

find "$INPUT_DIR" -type f \( -name "*.html" -o -name "*.md" \) | while read -r file; do
  basename="$(basename "$file")"
  dirname="$(dirname "$file")"
  [[ "$basename" == .* ]] && continue
  [[ "$dirname" == */.* ]] && continue

  relative_path="${file#"$INPUT_DIR"/}"
  if [[ "$relative_path" == *.md ]]; then
    relative_path="${relative_path%.md}.html"
  fi

  url_path=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$relative_path'''))")

  echo "  <url>" >> "$OUTPUT_FILE"
  echo "    <loc>${BASE_URL%/}/$url_path</loc>" >> "$OUTPUT_FILE"
  echo "    <lastmod>$NOW</lastmod>" >> "$OUTPUT_FILE"
  echo "    <changefreq>weekly</changefreq>" >> "$OUTPUT_FILE"
  echo "    <priority>0.5</priority>" >> "$OUTPUT_FILE"
  echo "  </url>" >> "$OUTPUT_FILE"
done

echo '</urlset>' >> "$OUTPUT_FILE"
