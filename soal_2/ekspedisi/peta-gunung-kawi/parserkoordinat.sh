#!/bin/bash

file="gsxtrack.json"

grep -E '"id"|"site_name"|"latitude"|"longitude"' $file \
| sed 's/[",]//g' \
| sed 's/: /,/g' \
| awk -F',' '
/id/ {id=$2}
/site_name/ {site=$2}
/latitude/ {lat=$2}
/longitude/ {lon=$2; print id ", " site ", " lat ", " lon}
' > titik-penting.txt

echo "Data tersimpan ke titik-penting.txt"
