# BLUEPRINT RENCANA PENGEMBANGAN APLIKASI
**Nama Aplikasi:** Reminder Sholat (Mualaf Friendly)
---

### 1. Deskripsi Proyek
Aplikasi pengingat waktu sholat berbasis lokasi yang dirancang dengan antarmuka bersih (clean UI) dan minimalis. Selain fitur adzan, aplikasi ini juga berfungsi sebagai asisten belajar bagi mualaf dengan menyediakan panduan niat dan bacaan sholat yang mudah dipahami.
### 2. Fitur Utama
* **Auto Location:** Penentuan jadwal sholat otomatis berdasarkan koordinat GPS pengguna.
* **Jadwal Sholat 5 Waktu:** Menampilkan waktu Imsak, Subuh, Dzuhur, Ashar, Maghrib, dan Isya secara real-time.
* **Early Warning Notification:** Notifikasi khusus 15 menit sebelum masuk waktu sholat.
* **Real-time Countdown:** Menampilkan hitung mundur menuju waktu sholat berikutnya.
* **Notifikasi Adzan:** Pengingat suara atau getar saat memasuki waktu sholat.

### 3. Fitur Khusus(Mualaf Friendly)

* **Panduan Niat & Bacaan:** Daftar niat sholat 5 waktu lengkap dengan teks Arab, Latin, dan terjemahan Indonesia.
* **Step-by-Step Guide:** Penjelasan ringkas mengenai urutan gerakan sholat.
* **Kumpulan Doa Pendek:** Doa-doa harian sederhana untuk menunjang ibadah bagi pemula.

### 4. Teknologi & Library (Flutter)

* **Core Framework:** Flutter & Dart.
* **Library Perhitungan:** `adhan` (Algoritma waktu sholat offline).
* **Library Lokasi:** `geolocator` (Akses koordinat GPS).
* **Library Notifikasi:** `flutter_local_notifications`.
* **Asset Visual:** `google_fonts` (Poppins) untuk tampilan yang modern dan bersih.

### 5. Rencana Kerja (Timeline 1 Bulan)
* **Minggu 1:** Setup awal project, integrasi GPS, dan pengambilan data jadwal sholat.
* **Minggu 2:** Pengembangan logika *countdown* dan sistem penyimpanan data lokal (caching).
* **Minggu 3:** Desain antarmuka (UI) untuk halaman utama dan modul panduan niat (Aestheticing).
* **Minggu 4:** Implementasi notifikasi, pengujian fitur (testing), dan perbaikan bug akhir.

---
*Dokumen ini disusun untuk pemenuhan tugas mata kuliah Mobile Programming*