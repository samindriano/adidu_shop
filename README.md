Samuel Indriano - B - 2406400524
## TUGAS 9
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
Perlu model Dart saat mengambil/mengirim data JSON agar setiap field punya tipe yang jelas, UI jadi lebih rapih, dan struktur data terpusat di satu tempat. Kalau langsung memetakan Map<String, dynamic> tanpa model, maka tidak ada jaminan tipe, null-safety lemah, dan maintainability jelek kalau struktur JSON nya makin kompleks / sering berubah.

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
- Package http:
    1. Hanya untuk melakukan GET / POST
    2. Tidak mengelola session / cookie secara otomatis
    3. Cocok untuk request yang tidak butuh autentikasi

- CookieRequest:
    1. Khusus integrasi Django
    2. Menyimpan dan mengirim cookie session
    3. Dipakai untuk komunikasi yang membutuhkan status login ke server Django

3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Karena status login disimpan di dalam satu objek CookieRequest. Jika tiap halaman membuat instance CookieRequest sendiri, maka nanti state login nya tidak konsisten dan cookie session tidak ikut ke semua request. Oleh karena itu, dengan membagikan satu instance yang sama, maka semua request Flutter ke Django akan selalu memakai session yang sama.

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Konfigurasi konektivitas yang diperlukan:
- Menambahkan 10.0.2.2 di ALLOWED_HOSTS
Karena di android emulator, 10.0.2.2 adalah alias ke localhost PC. Kalau tidak ditambahkan, Django akan menolak request dengan error DisallowedHost.

- Mengaktifkan CORS dan pengaturan SameSite/cookie
CORS harus diizinkan agar request dari Flutter tidak diblokir browser. SameSite/cookie harus diatur agar cookie session dan CSRF bisa dikirim lintas origin. Kalau SameSite/cookie tidak diatur, request bisa kena error CORS, cookie/CSRF tidak terkirim, login/POST bisa gagal.

- Menambahkan izin akses internet di Android
Perlu menambahkan izin akses internet di Android agar sistem Android mengizinkan app membuka koneksi jaringan (HTTP/HTTPS) ke server. Kalau izin akses internet tidak ada, semua percobaan koneksi dari Flutter akan di block oleh OS.

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
User mengisi form di Flutter, aplikasi memvalidasi input, membentuk payload JSON, lalu mengirimnya via CookieRequest/http ke endpoint Django. Django melakukan routing URL ke view, kemudian memvalidasi data, membaca/menyimpan ke database, dan merespon JSON dengan status. Kemudian Flutter menerima respons, melakukan jsonDecode ke model Dart, memperbarui state, dan widget melakukan rebuild sehingga data tampil.

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
User mengisi form register/login di Flutter, aplikasi memvalidasi input lalu mengirim JSON melalui CookieRequest ke endpoint Django. Di register, Django memvalidasi data dan membuat user baru dengan password ter hash, kemudian mengembalikan respons JSON. Di login, Django mengautentikasi kredensial dan membuat session dan mengirim session cookie. CookieRequest menyimpannya sehingga request berikutnya otomatis terautentikasi ke endpoint yang dilindungi. Flutter membaca respons, menyimpan status login kemudian melakukan navigasi ke menu utama yang hanya tampil jika status login valid. Saat logout, Flutter memanggil endpoint logout, Django menghapus session, Flutter membersihkan state/cookie lokal, dan aplikasi kembali ke halaman login.

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
    1. Memastikan deployment proyek tugas Django kamu telah berjalan dengan baik.
    Aktifkan env dan run "python manage.py runserver" di terminal trus cek apakah server berjalan dengan baik di localhost.

    2. Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.
    Di Django, buat app baru "authentication", kemudian mengaktifkan django-cors-headers, mengatur CORS dan cookie, dan menambahkan view register dan path nya. Di Flutter, install package, buat RegisterPage, kirim request.postJson ke auth/register/, kemudian kembali ke LoginPage.

    3. Membuat halaman login pada proyek tugas Flutter.
    Di Django, buat view login dan path nya. Di Flutter, buat login page, panggil request.login, dan jika berhasil akan navigasi ke MyHomePage dan menampilkan snackbar.

    4. Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
    Bungkus MaterialApp dengan Provider(...), set home ke LoginPage, ambil instance dengan context.watch<CookieRequest>(), dan tambah tombol logout.
    
    5. Membuat model kustom sesuai dengan proyek aplikasi Django.
    Ambil JSON dari show_json yang berisi atribut produk. Menggunakan QuickType untuk membuat model ProductEntry dan menggunakan ProductEntry di semua UI untuk menampilkan data product.

    6. Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.
    Membuat ProductEntryCard dan ProductEntryListPage. Kemudian menghubungkan card "All Products" di home ke ProductEntryListPage(onlyMine: false) dan item "My Products" di left drawer ke ProductEntryListPage(onlyMine: true).

    7. Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.
    Membuat ProductDetailPage yang menerima ProductEntry product dan menampilkan semua atribut penting.

    8. Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.
    Di Django saya menambahkan endpoint JSON yang hanya mengembalikan produk dengan user sama dengan user yang sedang login. Kemudian di Flutter saya membuat "My Products" yang memanggil endpoint itu sehingga akan menampilkan produk yang dibuat oleh user yang sedang login.


## TUGAS 8
1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
- Navigator.push() berfungsi untuk menambahkan halaman baru di atas stack tanpa menghapus halaman sebelumnya. Pada AdiduShop, cocok dipakai saat masuk ke "Tambah Produk" dari halaman utama. User bisa balik ke halaman utama dengan tombol back.

- Navigator.pushReplacement() berfungsi untuk mengganti halaman saat ini dengan halaman baru. Pada AdiduShop, cocok dipakai untuk drawer halaman utama. Jadi user tidak bisa kembali ke halaman lama dengan tombol back.

2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
Saya memanfaatkan Scaffold sebagai kerangka setiap halaman, AppBar untuk judul dan warna tema, dan Drawer yang sama di semua halaman sehingga navigasi aplikasi akan konsisten.

3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
- Menggunakan Padding berfungsi agar jarak antar elemen nya rapih dan mudah dibaca. 
Contoh: productlist_form.dart line 47

- Menggunakan SingeChildScrollView berfungsi agar halaman bisa di scroll ketika isi konten lebih tinggi dari layar, jadi tidak akan overflow ketika buka keyboard / karena layar kecil.
Contoh: productlist_form.dart line 41

- Menggunakan ListView berfungsi untuk menampilkan daftar product yang di scroll secara vertikal dan bisa mengatur sendiri tinggi kontennya.
Contoh: left_drawer.dart line 10

4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Saya menggunakan ColorScheme.fromSeed(seedColor: Colors.teal) di main.dart line 15, sehingga semua komponen di aplikasi memiliki tema warna yang sama yaitu teal. Buat menggunakan tema warna utama teal, saya menggunakan Theme.of(context).colorScheme.primary di beberapa bagian kode.

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