#!/bin/bash

file=$1
option=$2

case $option in
a)
count_passenger=$(awk -F',' 'NR>1 {count++} END {print count}' $file)
echo "Jumlah seluruh penumpang KANJ adalah ${count_passenger} orang"
;;

b)
carriage=$(awk -F',' 'NR>1 {print $4}' $file | sort -u | wc -l)
echo "Jumlah gerbong penumpang KANJ adalah ${carriage} gerbong"
;;

c)
oldest=$(awk -F',' 'NR>1{
if($2>max){max=$2; nama=$1}
}
END {print nama}' "$file")

age=$(awk -F',' 'NR>1{
if($2>max){max=$2}
}
END {print max}' "$file")

echo "${oldest} adalah penumpang kereta tertua dengan usia ${age} tahun"
;;

d)
average_age=$(awk -F',' 'NR>1 {total+=$2; count++}
END {print int(total/count)}' $file)

echo "Rata-rata usia penumpang adalah ${average_age} tahun"
;;

e)
business_passenger=$(awk -F',' 'NR>1 && $3=="Business" {count++}
END {print count}' $file)

echo "Jumlah penumpang business class ada ${business_passenger} orang"
;;

*)
echo "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
;;

esac
