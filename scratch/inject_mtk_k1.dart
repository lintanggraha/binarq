import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('bank_soal.json');
  final json = jsonDecode(file.readAsStringSync()) as List;

  // Filter out existing K1 MTK questions to replace them with better ones
  json.removeWhere((q) => q['metadata']['kelas'] == 1 && q['metadata']['mapel'] == 'MTK');

  final newK1MTK = <Map<String, dynamic>>[];

  // Helper to create questions
  void addQ(String id, String topik, String q, List<String> opts, String ans, String expl, String cat) {
    newK1MTK.add({
      "id": id,
      "metadata": {
        "kelas": 1,
        "fase": "A",
        "mapel": "MTK",
        "topik": topik,
        "kategori_ujian": cat,
        "tingkat_kesulitan": "mudah",
        "xp_reward": 10,
        "konteks_islami": true,
        "tag_nilai_islam": ["ilmu", "adab"]
      },
      "content": {
        "tipe_soal": "pilihan_ganda",
        "pertanyaan": q,
        "pilihan": [
          {"id_pilihan": "A", "teks": opts[0]},
          {"id_pilihan": "B", "teks": opts[1]},
          {"id_pilihan": "C", "teks": opts[2]}
        ],
        "jawaban_benar": ans
      },
      "feedback": {
        "penjelasan_anak": expl,
        "hint": "Coba hitung pelan-pelan ya!"
      }
    });
  }

  // --- Bilangan Cacah & Satuan ---
  addQ("MTK-K1-NEW-001", "Bilangan Cacah", "Berapa jumlah jari pada satu tangan manusia?", ["4", "5", "6"], "B", "Satu tangan kita punya 5 jari, ciptaan Allah yang sempurna.", "Sumatif Awal Semester");
  addQ("MTK-K1-NEW-002", "Bilangan Cacah", "Angka setelah 12 adalah...", ["11", "13", "14"], "B", "Setelah dua belas adalah tiga belas.", "Sumatif Awal Semester");
  addQ("MTK-K1-NEW-003", "Bilangan Cacah", "Lambang bilangan 'tujuh belas' adalah...", ["71", "17", "27"], "B", "Tujuh belas ditulis angka 1 lalu 7.", "Sumatif Awal Semester");
  addQ("MTK-K1-NEW-004", "Bilangan Cacah", "Ada berapa jumlah rakaat shalat Subuh?", ["2", "3", "4"], "A", "Shalat Subuh dilakukan sebanyak 2 rakaat di pagi hari.", "Sumatif Awal Semester");
  addQ("MTK-K1-NEW-005", "Bilangan Cacah", "Manakah angka yang lebih besar dari 15?", ["14", "15", "16"], "C", "Angka 16 lebih besar nilainya daripada 15.", "Sumatif Awal Semester");

  // --- Penjumlahan (Satuan & Konteks Variatif) ---
  addQ("MTK-K1-NEW-006", "Penjumlahan", "Ahmad punya 3 apel. Maryam memberi 4 apel lagi. Berapa jumlah apel Ahmad sekarang?", ["6", "7", "8"], "B", "3 + 4 = 7 apel.", "Sumatif Awal Semester");
  addQ("MTK-K1-NEW-007", "Penjumlahan", "Di kolam ada 5 ikan warna merah dan 5 ikan warna kuning. Berapa semua ikan di kolam?", ["10", "11", "12"], "A", "5 + 5 = 10 ikan.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-008", "Penjumlahan", "Ibu membeli 8 telur, lalu ayah membeli 2 telur lagi. Berapa telur semuanya?", ["9", "10", "11"], "B", "8 + 2 = 10 telur.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-009", "Penjumlahan", "Ada 6 burung di pohon. Datang lagi 3 burung. Berapa jumlah burung di pohon?", ["8", "9", "10"], "B", "6 + 3 = 9 burung.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-010", "Penjumlahan", "Zaid punya 7 kelereng. Menang lagi 5 kelereng. Berapa kelereng Zaid sekarang?", ["11", "12", "13"], "B", "7 + 5 = 12 kelereng.", "Sumatif Tengah Semester");

  // --- Pengurangan ---
  addQ("MTK-K1-NEW-011", "Pengurangan", "Ali punya 10 balon. Meletus 3 balon. Sisa balon Ali adalah...", ["6", "7", "8"], "B", "10 - 3 = 7 balon.", "Sumatif Awal Semester");
  addQ("MTK-K1-NEW-012", "Pengurangan", "Ada 15 burung merpati. Terbang 5 ekor. Berapa merpati yang masih ada?", ["9", "10", "11"], "B", "15 - 5 = 10 burung.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-013", "Pengurangan", "Fatimah punya 12 permen. Diberikan ke adik 4 permen. Sisa permen Fatimah...", ["7", "8", "9"], "B", "12 - 4 = 8 permen.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-014", "Pengurangan", "Di piring ada 8 kue donat. Dimakan kakak 2 kue. Sisa kue di piring adalah...", ["5", "6", "7"], "B", "8 - 2 = 6 kue.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-015", "Pengurangan", "Umar punya 20 pensil. Patah 2 pensil. Pensil yang masih bagus ada...", ["17", "18", "19"], "B", "20 - 2 = 18 pensil.", "Sumatif Tengah Semester");

  // --- Bangun Datar ---
  addQ("MTK-K1-NEW-016", "Bangun Datar", "Bentuk dari roda sepeda adalah...", ["Segitiga", "Lingkaran", "Persegi"], "B", "Roda berbentuk bulat atau lingkaran agar bisa berputar.", "Sumatif Awal Semester");
  addQ("MTK-K1-NEW-017", "Bangun Datar", "Buku tulis biasanya berbentuk...", ["Lingkaran", "Persegi Panjang", "Segitiga"], "B", "Buku tulis memiliki sisi panjang dan pendek, yaitu persegi panjang.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-018", "Bangun Datar", "Bangun datar yang memiliki 3 sudut dan 3 sisi adalah...", ["Segitiga", "Persegi", "Lingkaran"], "A", "Segitiga punya 3 sisi dan 3 pojok/sudut.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-019", "Bangun Datar", "Atap rumah biasanya terlihat berbentuk...", ["Persegi", "Segitiga", "Lingkaran"], "B", "Atap rumah seringkali berbentuk segitiga.", "Sumatif Tengah Semester");
  addQ("MTK-K1-NEW-020", "Bangun Datar", "Benda yang berbentuk lingkaran adalah...", ["Meja", "Uang koin", "Penggaris"], "B", "Uang koin berbentuk lingkaran.", "Sumatif Tengah Semester");

  // --- Pengukuran ---
  addQ("MTK-K1-NEW-021", "Pengukuran", "Manakah benda yang lebih berat?", ["Kapas", "Batu besar", "Kertas"], "B", "Batu besar jauh lebih berat daripada kapas dan kertas.", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-022", "Pengukuran", "Benda yang paling panjang adalah...", ["Pensil", "Meja guru", "Penghapus"], "B", "Meja guru lebih panjang ukurannya dibandingkan pensil.", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-023", "Pengukuran", "Kita sarapan pagi biasanya pada pukul...", ["6 pagi", "12 siang", "9 malam"], "A", "Sarapan dilakukan di pagi hari sebelum berangkat sekolah.", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-024", "Pengukuran", "Setelah hari Senin adalah hari...", ["Minggu", "Selasa", "Rabu"], "B", "Urutan hari: Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu.", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-025", "Pengukuran", "Alat untuk mengukur panjang adalah...", ["Timbangan", "Penggaris", "Jam"], "B", "Penggaris digunakan untuk mengukur panjang benda.", "Sumatif Akhir Semester");

  // --- Pola & Logika ---
  addQ("MTK-K1-NEW-026", "Pola Bilangan", "Lanjutkan pola ini: 2, 4, 6, ...", ["7", "8", "9"], "B", "Ini pola loncat dua angka: 2, 4, 6, 8.", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-027", "Pola Bilangan", "Lanjutkan pola ini: 10, 9, 8, ...", ["7", "6", "5"], "A", "Ini pola hitung mundur: 10, 9, 8, 7.", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-028", "Logika", "Jika hari ini Selasa, besok adalah hari...", ["Senin", "Rabu", "Kamis"], "B", "Setelah Selasa adalah hari Rabu.", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-029", "Bilangan Cacah", "Angka 15 jika dipisah menjadi puluhan dan satuan adalah...", ["1 puluhan dan 5 satuan", "5 puluhan dan 1 satuan", "10 puluhan dan 5 satuan"], "A", "Angka 15 artinya 10 (1 puluhan) dan 5 (satuan).", "Sumatif Akhir Semester");
  addQ("MTK-K1-NEW-030", "Bilangan Cacah", "Angka 8 menempati posisi...", ["Satuan", "Puluhan", "Ratusan"], "A", "Angka 8 berdiri sendiri, maka disebut satuan.", "Sumatif Akhir Semester");

  // Add ISIAN questions (5 for Grade 1 MTK)
  void addIsian(String id, String topik, String q, String ans, String expl, String cat) {
    newK1MTK.add({
      "id": id,
      "metadata": {
        "kelas": 1,
        "fase": "A",
        "mapel": "MTK",
        "topik": topik,
        "kategori_ujian": cat,
        "tingkat_kesulitan": "mudah",
        "xp_reward": 15,
        "konteks_islami": true,
        "tag_nilai_islam": ["ilmu", "kejujuran"]
      },
      "content": {
        "tipe_soal": "isian",
        "pertanyaan": q,
        "jawaban_benar": ans
      },
      "feedback": {
        "penjelasan_anak": expl,
        "hint": "Tuliskan angkanya saja ya!"
      }
    });
  }

  addIsian("MTK-K1-NEW-I01", "Penjumlahan", "Aisyah punya 5 donat. Ibu beri 5 donat lagi. Berapa donat Aisyah sekarang?", "10", "5 + 5 = 10 donat.", "Sumatif Akhir Semester");
  addIsian("MTK-K1-NEW-I02", "Pengurangan", "Ada 12 burung merpati di masjid. Terbang 2 ekor. Berapa yang tersisa?", "10", "12 - 2 = 10 burung.", "Sumatif Akhir Semester");
  addIsian("MTK-K1-NEW-I03", "Bilangan Cacah", "Lambang bilangan delapan belas adalah...", "18", "Delapan belas ditulis 1 lalu 8.", "Sumatif Akhir Semester");
  addIsian("MTK-K1-NEW-I04", "Penjumlahan", "8 + 5 = ...", "13", "8 ditambah 5 hasilnya tiga belas.", "Sumatif Akhir Semester");
  addIsian("MTK-K1-NEW-I05", "Pengurangan", "20 - 1 = ...", "19", "Sebelum angka 20 adalah sembilan belas.", "Sumatif Akhir Semester");

  // Add all new questions to the main list
  json.addAll(newK1MTK);

  print('Total questions now: ${json.length}');
  print('Added ${newK1MTK.length} high-quality K1 MTK questions.');

  file.writeAsStringSync(jsonEncode(json));
  print('✅ Varied K1 MTK questions injected into bank_soal.json.');
}
