#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates"
DOCS_DIR="$SCRIPT_DIR/../docs"
echo "$SCRIPT_DIR"
echo "$TEMPLATES_DIR"


# -------------------------------
# 2️⃣ Convert Markdown → HTML
# -------------------------------
mkdir -p "$DOCS_DIR/templates"

for file in "$TEMPLATES_DIR"/*.md; do
  base=$(basename "$file" .md)
  pandoc "$file" -s -o "$DOCS_DIR/templates/${base}.html" 
  echo "Generated "$TEMPLATES_DIR"/${base}.html"
  pandoc "$file" -o "$DOCS_DIR/templates/${base}.docx"
echo "Generated docs/templates/${base}.docx"

done


# -------------------------------
# 3️⃣ Generate index.html
# -------------------------------
cat > "$DOCS_DIR/index.html" <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Technology Governance Templates</title>
<style>
body { font-family: Arial, sans-serif; max-width: 900px; margin: auto; padding: 2rem; }
h1 { color: #222; }
ul { line-height: 1.6; }
a { text-decoration: none; color: #1a73e8; }
a:hover { text-decoration: underline; }
</style>
</head>
<body>
<h1>Technology Governance Templates</h1>
<p>A collection of templates designed to support technology governance</p>


<ul>
EOL

for f in "$DOCS_DIR/templates"/*.html; do
  base=$(basename "$f" .html)
  md_file="$TEMPLATES_DIR"//${base}.md
  echo "$md_file"
   if [ -f "$md_file" ]; then
     title=$(awk '/^---/{flag++;next} flag==1 && /^[[:space:]]*title:/{sub(/^[[:space:]]*title:[[:space:]]*/,""); print; exit}' "$md_file")
    [ -z "$title" ] && title="$base"
  else
    title="$base"
  fi

echo "<li>$title — <a href=\"templates/$base.html\">View HTML</a> | <a href=\"templates/$base.docx\">Download Word</a></li>" >> "$DOCS_DIR/index.html"

done



echo "</ul></body></html>" >> docs/index.html
echo "Generated docs/index.html"

# -------------------------------
# 4️⃣ Preview instructions
# -------------------------------
echo "To preview locally, run: cd docs && python -m http.server 8000"
