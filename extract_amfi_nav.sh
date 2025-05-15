#!/bin/bash

# URL of the NAVAll.txt file
URL="https://www.amfiindia.com/spages/NAVAll.txt"

# Output TSV file
OUTPUT_FILE="amfi_nav.tsv"

# Download the file
curl -s "$URL" -o NAVAll.txt

# Process the file to extract Scheme Name and Asset Value and save as TSV
# Fields in NAVAll.txt are | separated:
# Field 1: Scheme Code
# Field 2: ISIN Div Payout/ ISIN Growth
# Field 3: ISIN Div Reinvestment
# Field 4: Scheme Name
# Field 5: Net Asset Value (NAV)
# We want fields 4 and 5

awk -F '|' 'NR > 1 {print $4 "\t" $5}' NAVAll.txt > "$OUTPUT_FILE"

echo "Extraction complete. Output saved to $OUTPUT_FILE"
