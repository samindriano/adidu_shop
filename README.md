Samuel Indriano - B - 2406400524
## TUGAS 7
1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Widget tree pada adalah gambaran logis tentang susunan semua widget dari UI. Flutter memiliki widget tree agar bisa mengetahui root dan parent-child. Hubungan parent-child bekerja dengan parent membungkus child, dan child mewarisi konteks dari parent nya. Kalau parent dihapus, anaknya akan hilang. Kalau parent di rebuild, maka anaknya akan ke build lagi.


2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
main.dart:
- MyApp -> root widget, return MaterialApp.
- MaterialApp -> set title, set theme, set home page.
- ThemeData -> setting warna app
- MyHomePage -> home page

menu.dart:
- Scaffold -> dashboard page
- AppBar -> bar warna teal
- Padding -> membungkus Column di body
- Column -> menyusun widget dari atas ke bawah
- Row -> menyusun InfoCard dari kiri ke kanan
- InfoCard -> menampilkan label dan isinya dalam card
- GridView.count -> menampilkan daftar menu utama dalam 3 kolom
- ItemCard -> card warna biru, hijau, merah yang bisa ditekan, nampilin ikon dan teks, dan menampilkan SnackBar saat ditekan
- ItemHomePage -> class model untuk menyimpan teks, ikon, dan warna


3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
MaterialApp berfungsi untuk menginisialisasi app Flutter berbasis Material, seperti pengaturan tema, judul, halaman awal, navigator, dan resource Material yang lain. MaterialApp sering digunakan sebagai widget root karena dia menyediakan konteks Material untuk semua widget lain di bawahnya.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
StatelessWidget adalah widget yang deskripsinya ditentukan sekali oleh parent lewat constructor, dan setelah itu tidak diubah oleh widget itu sendiri. Kalau mau berubah, parent yang harus kirim data baru. Sedangkan StatefulWidget adalah widget yang selain menerima data dari parent, juga menyimpan state lokal di objek State. Ketika state ini berubah misal karena klik button, maka widget akan di-rebuild untuk menampilkan keadaan terbaru.

Pilih StatelessWidget kalau UI cukup ditentukan oleh parent aja. Pilih StatefulWidget kalau UI harus bereaksi terhadap perubahan internal, misal klik, counter, atau ambil data.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext adalah objek yang menunjuk posisi suatu widget di dalam widget tree. Dengan context itu, widget bisa mengakses data dari atasnya, seperti tema, navigator, atau ScaffoldMessenger. Oleh Karena itu, method build selalu menerima BuildContext context, supaya waktu membuat UI kita bisa mengambil resource yang disediakan parent.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Hot reload hanya mengirim perubahan kode ke Dart VM dan menggambar ulang widget tree tanpa menghapus state, sehingga main() dan initState() tidak dijalankan lagi. Hot restart juga mengirim perubahan kode ke VM, tetapi me-restart aplikasi Flutter, sehingga state hilang dan aplikasi mulai dari awal.