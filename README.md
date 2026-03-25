# SISOP-1-2026-IT-033  
 
Nama : Daffa Ulhaq Fadhlurrahman  
NRP : 5027251033  

## Soal 1
### Penyelesaian

Langkah pertama yang dilakukan adalah mengunduh file passenger.csv secara manual, kemudian file tersebut dipindahkan ke dalam direktori "soal_1" yang telah dibuat sebelumnya. 
```bash
cp /mnt/c/Users/Daffa/Downloads/passenger.csv ~/
```
Kemudian praktikan membuat file `KANJ.sh` untuk membuat shell script untuk melakukan beberapa operasi. Script dimulai dengan
```bash
#!/bin/bash

file=$1
option=$2

case $option in
```
Baris `#!/bin/bash` digunakan untuk menentukan bahwa script dijalankan menggunakan bash interpreter. Selanjutnya, baris `file=$1` dan `option=$2` digunakan untuk mengambil argumen pertama dan kedua saat script dijalankan. Lalu, `case $option` dibuat agar kita bisa melakukan input berbeda-beda dan akan menghasilkan output sesuai input yang diberikan. Kemudian, barulah operasi lain dilakukan sesuai dengan soal.
#### a.) Menghitung seluruh jumlah penumpang
Perhitungan dilakukan dengan cara menghitung seluruh baris yang ada dalam dataset, kecuali baris pertama / header.
```bash
count_passenger=$(awk -F',' 'NR>1 {count++} END {print count}' $file)
echo "Jumlah seluruh penumpang KANJ adalah ${count_passenger} orang"
;;
```
#### b.) Menghitung Jumlah Gerbong pada Kereta Argo Ngawi Jesgejes
Perhitungan dilakukan dengan mengambil kolom-4 (gerbong) dan menghapus duplikatnya, kemudian jumlah barisnya dihitung.
```bash
carriage=$(awk -F',' 'NR>1 {print $4}' $file | sort -u | wc -l)
echo "Jumlah gerbong penumpang KANJ adalah ${carriage} gerbong"
;;
```
#### c.) Mencari Penumpang Tertua
Untuk mencari penumpang tertua, program dibagi menjadi dua variabel `oldest` dan `age`.

```bash
oldest=$(awk -F',' 'NR>1{
if($2>max){max=$2; nama=$1}
}
END {print nama}' "$file")
```
Program akan membandingkan setiap nilai usia pada kolom kedua dan menyimpan usia tertua ke variabel `max` serta nama penumpang ke variabel `nama`. Kemudian, `{print nama}` akan mencetak nama dengan usia tertua dan menyimpannya ke variabel `oldest`.
```bash
age=$(awk -F',' 'NR>1{
if($2>max){max=$2}
}
END {print max}' "$file")

echo "${oldest} adalah penumpang kereta tertua dengan usia ${age} tahun"
;;
```
Cara kerja program ini berkerja kurang lebih sama seperti program sebelumnya, dimana program akan membandingkan setiap nilai usia pada kolom kedua dan menyimpan usia tertua tersebut ke variabel `max`. Kemudian, `{print max}` akan mencetak angka usia tertua dan menyimpannya ke variabel `age`.
#### d.) Menghitung Rata-rata Usia Penumpang
`total+=$2` akan menghitung jumlah seluruh usia penumpang pada kolom ke-2, sedangkan `count++` akan menghitung total baris dataset kecuali baris pertama. Kemudian, `print int(total/count)` akan mencetak angka bulat rata-rata usia penumpang dan menyimpannya ke variabel `average_age`.
```bash
average_age=$(awk -F',' 'NR>1 {total+=$2; count++}
END {print int(total/count)}' $file)

echo "Rata-rata usia penumpang adalah ${average_age} tahun"
;;
```
#### e.) Menghitung Jumlah Penumpang Business Class
Program akan mencari kata kunci `Business` pada kolom ke-3 dan menjumlahkannya (`count++`).
```bash
business_passenger=$(awk -F',' 'NR>1 && $3=="Business" {count++}
END {print count}' $file)

echo "Jumlah penumpang business class ada ${business_passenger} orang"
;;
```
#### f.) Error Handling
Program akan memberikan output yang menyuruh pengguna untuk menginput a/b/c/d/e.
```bash
*)
echo "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
;;
```
### Output
<img width="1152" height="372" alt="Screenshot 2026-03-25 193909" src="https://github.com/user-attachments/assets/2709d81d-e5b0-483a-b805-43d375ac60c1" />

### Kendala  
Pada awalnya, perintah `./KANJ.sh passenger.csv b` akan mengeluarkan output `5 gerbong`, padahal seharusnya gerbong pada kereta tersebut berjumlah `4 gerbong`. Setelah ditelusuri, praktikan menemukan adanya carriage return `(^M)` akibat adanya baris kosong pada baris paling bawah yang membuat program membaca itu adalah hal yang berbeda dengan yang lain.
`Gerbong1^M$   
 Gerbong2^M$  
 Gerbong3^M$  
 Gerbong4^M$  
 Gerbong1^M$  
 Gerbong2^M$  
 Gerbong3$`.
 Masalah diselesaikan dengan menghapus baris terakhir tersebut pada `nano passenger.csv`.
## Soal 2
