#!/bin/bash

file="titik-penting.txt"

lat_min=$(awk -F', ' '{print $3}' $file | sort -n | head -1)
lat_max=$(awk -F', ' '{print $3}' $file | sort -n | tail -1)

lon_min=$(awk -F', ' '{print $4}' $file | sort -n | head -1)
lon_max=$(awk -F', ' '{print $4}' $file | sort -n | tail -1)

lat_mid=$(echo "($lat_min + $lat_max) / 2" | bc -l)
lon_mid=$(echo "($lon_min + $lon_max) / 2" | bc -l)

echo "$lat_mid, $lon_mid" > posisipusaka.txt

echo "Titik tengah disimpan di posisipusaka.txt"
