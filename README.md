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
### Penyelesaian

Langkah pertama yang dilakukan adalah menginstall package `gdown` menggunakan pip.
```bash
sudo apt install python3-pip
pip install gdown
```
Setelah menginstall `gdown`, praktikan mengunduh file dari link google drive yang diberikan menggunakan `gdown` dan menyimpannya ke folder `ekspedisi`.
```bash
gdown https://drive.google.com/uc?id=1q10pHSC3KFfvEiCN3V6PTroPR7YGHF6Q
```
Maka, file `peta-ekspedisi-amba.pdf` akan muncul di dalam folder `ekspedisi`.
<img width="976" height="47" alt="Screenshot 2026-03-29 221548" src="https://github.com/user-attachments/assets/d772031b-f3e2-4443-aff7-66d172477724" />

Kemudian, praktikan membaca file tersebut menggunakan perintah `cat`, dan menemukan sebuah tautan di dalamnya. Tautan disebut akan menuju kepada sebuah folder yang harus praktiakn clone-kan di folder `ekspedisi`.
<img width="1452" height="236" alt="Screenshot 2026-03-29 221854" src="https://github.com/user-attachments/assets/a7d871a3-470e-4bdc-9f92-bffa08f73cd5" />
```bash
git clone https://github.com/pocongcyber77/peta-gunung-kawi.git
```
Maka, folder `peta-gunung-kawi` akan muncul.
<img width="981" height="51" alt="Screenshot 2026-03-29 222145" src="https://github.com/user-attachments/assets/64fa6ad4-3388-41ea-8c6a-fbab23ce0010" />

Masuk ke folder `peta-gunung-kawi`, terdapat sebuah file bernama gsxtrack.json, kemudian file tersebut dibaca menggunakan perintah `cat`
<img width="1435" height="685" alt="Screenshot 2026-03-29 141404" src="https://github.com/user-attachments/assets/55e347ab-7b67-4c9a-a446-7cdeaf4ddee5" />

Kemudian, file `parserkoordinat.sh` dibuat. File ini berisi shell script untuk mengambil informasi "id", "site_name", "latitude", "longitude", merapikan susunan data, dan mengedit beberapa simbol, seperti menghapus `"` dan `,`, dan mengedit simbol `:` menjadi `,`. Hasil shell scripting disimpan ke file `titik-penting.txt`
```bash
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
```
<img width="1440" height="153" alt="Screenshot 2026-03-29 223040" src="https://github.com/user-attachments/assets/015a8857-1744-4573-a0dc-a7f2ab95cece" />

4 koordinat yang telah diambil dari `gsxtrack.json` akan membentuk seperti persegi jika diproyeksikan ke koordinat geografis. Maka, untuk menemukan titik lokasi pusaka (titik pusat persegi), praktikan membuat shell scripting pada file `nemupusaka.sh` untuk mencari titik tengah persegi tersebut. Koordinat titik tengah tersebut disimpan ke file `posisipusaka.txt`.
```bash
#!/bin/bash

file="titik-penting.txt"

lat_min=$(awk -F', ' '{print $3}' $file | sort -n | head -1)
lat_max=$(awk -F', ' '{print $3}' $file | sort -n | tail -1)

lon_min=$(awk -F', ' '{print $4}' $file | sort -n | head -1)
lon_max=$(awk -F', ' '{print $4}' $file | sort -n | tail -1)

lat_mid=$(echo "($lat_min + $lat_max) / 2" | bc -l)
lon_mid=$(echo "($lon_min + $lon_max) / 2" | bc -l)

echo "$lat_mid, $lon_mid" > posisipusaka.txt

echo "Koordinat pusat: "
echo "$lat_mid, $lon_mid"
```

### Output
`cat posisipusaka.txt` akan mencetak koordinat lokasi pusaka yang dicari.
<img width="1438" height="53" alt="Screenshot 2026-03-29 223928" src="https://github.com/user-attachments/assets/365cb67e-b53b-41a8-985d-0a943026e703" />

### Kendala
Tidak ada.






