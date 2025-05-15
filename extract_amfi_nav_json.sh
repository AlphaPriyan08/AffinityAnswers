#!/bin/bash

URL="https://www.amfiindia.com/spages/NAVAll.txt"
OUTPUT_FILE="amfi_nav.json"

# Download NAVAll.txt
curl -s "$URL" -o NAVAll.txt

# Process to JSON:
# We'll convert each line into a JSON object with keys "SchemeName" and "AssetValue"

echo "[" > "$OUTPUT_FILE"
awk -F '|' 'NR > 1 {
    # Escape double quotes in Scheme Name
    gsub(/"/, "\\\"", $4);
    printf "  {\"SchemeName\": \"%s\", \"AssetValue\": \"%s\"}", $4, $5
    if (NR > 1) print ",";
}' NAVAll.txt >> "$OUTPUT_FILE"

# Fix trailing comma by rewriting the file properly
# Using sed to remove the last comma before the closing bracket

# Close JSON array
echo "]" >> "$OUTPUT_FILE"

# Fix trailing comma before the closing bracket (if any)
sed -i '$!b;N;s/,\n]/\n]/' "$OUTPUT_FILE"

echo "JSON extraction complete. Output saved to $OUTPUT_FILE"
