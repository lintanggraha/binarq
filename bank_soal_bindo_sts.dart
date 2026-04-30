import 'package:supabase/supabase.dart';
import 'dart:math';

// Helper
Map<String, dynamic> buatSoal(
  String id, int kelas, String mapel, String topik, String kategoriUjian,
  String pertanyaan, List<String> pilihanTeks, String jawabanBenarId, String penjelasan,
) {
  return {
    "id": id,
    "metadata": {
      "kelas": kelas, "fase": "A", "mapel": mapel, "topik": topik,
      "kategori_ujian": kategoriUjian,
      "tingkat_kesulitan": "sedang", "xp_reward": 20,
      "konteks_islami": true, "tag_nilai_islam": ["adab_dan_akhlak"]
    },
    "content": {
      "tipe_soal": "pilihan_ganda", "pertanyaan": pertanyaan,
      "pilihan": [
        {"id_pilihan": "A", "teks": pilihanTeks[0]},
        {"id_pilihan": "B", "teks": pilihanTeks[1]},
        {"id_pilihan": "C", "teks": pilihanTeks[2]},
        {"id_pilihan": "D", "teks": pilihanTeks[3]}
      ],
      "jawaban_benar": jawabanBenarId
    },
    "feedback": {
      "penjelasan_anak": penjelasan,
      "hint": "Coba diingat-ingat lagi pelajaran di kelas ya!"
    }
  };
}

void main() async {
  final supabase = SupabaseClient(
    'https://zohccxhlueafwpmvhasn.supabase.co',
    'sb_publishable_U9IG5DbHLbJ9NEyhx7KS3Q_dJdTcnrB',
  );

  List<Map<String, dynamic>> soal = [];

  // ==========================================
  // BAHASA INDONESIA KELAS 1 - SUMATIF TENGAH SEMESTER (BAB 5 & 6)
  // TOTAL: 25 SOAL
  // ==========================================
  
  // BAB 5: Huruf M, suku kata ma-mi-mu-me-mo (6 soal)
  soal.add(buatSoal("BIN-K1-STS-001", 1, "B. Indo", "Suku Kata M", "STS_GENAP", 
    "Kata di bawah ini yang diawali dengan suku kata 'ma' adalah...", 
    ["Minum", "Makan", "Mulut", "Melihat"], "B", "Kata 'Makan' diawali dengan huruf m dan a, dibaca 'ma'."));
  soal.add(buatSoal("BIN-K1-STS-002", 1, "B. Indo", "Suku Kata M", "STS_GENAP", 
    "Benda yang digunakan untuk minum dan diawali suku kata 'ge' adalah...", 
    ["Garpu", "Gelas", "Guling", "Gula"], "B", "'Gelas' diawali suku kata ge."));
  soal.add(buatSoal("BIN-K1-STS-003", 1, "B. Indo", "Suku Kata M", "STS_GENAP", 
    "Bagian wajah yang berfungsi untuk mengunyah makanan, diawali suku kata 'mu' adalah...", 
    ["Mata", "Mulut", "Muka", "Mimi"], "B", "'Mulut' digunakan untuk makan dan diawali suku kata mu."));
  soal.add(buatSoal("BIN-K1-STS-004", 1, "B. Indo", "Suku Kata M", "STS_GENAP", 
    "Hewan yang suka melompat dan memanjat pohon, diawali huruf 'm' adalah...", 
    ["Macan", "Merpati", "Monyet", "Musang"], "C", "Monyet adalah hewan ciptaan Allah yang jago memanjat."));
  soal.add(buatSoal("BIN-K1-STS-005", 1, "B. Indo", "Suku Kata M", "STS_GENAP", 
    "Lengkapi kata berikut: ...-rah. Warna bunga mawar itu...", 
    ["Ma", "Me", "Mi", "Mo"], "B", "Suku kata yang tepat adalah 'Me', menjadi 'Merah'."));
  soal.add(buatSoal("BIN-K1-STS-006", 1, "B. Indo", "Suku Kata M", "STS_GENAP", 
    "Minyak wangi Rasulullah memiliki aroma harum. 'Minyak' diawali dengan suku kata...", 
    ["Ma", "Me", "Mi", "Mo"], "C", "Kata 'Minyak' diawali suku kata mi."));

  // BAB 5: Merawat kebersihan tubuh & lingkungan (7 soal)
  soal.add(buatSoal("BIN-K1-STS-007", 1, "B. Indo", "Kebersihan Tubuh", "STS_GENAP", 
    "Sebelum shalat, kita wajib membersihkan diri dari hadas dengan cara...", 
    ["Tidur", "Mandi atau Wudhu", "Makan", "Bermain"], "B", "Kebersihan adalah sebagian dari iman. Kita harus wudhu sebelum shalat."));
  soal.add(buatSoal("BIN-K1-STS-008", 1, "B. Indo", "Kebersihan Tubuh", "STS_GENAP", 
    "Benda yang kita gunakan untuk membersihkan gigi setelah bangun tidur adalah...", 
    ["Sabun", "Sikat gigi dan pasta", "Sampo", "Sisir"], "B", "Sikat gigi membuat mulut kita wangi dan bersih."));
  soal.add(buatSoal("BIN-K1-STS-009", 1, "B. Indo", "Kebersihan Tubuh", "STS_GENAP", 
    "Agar rambut bersih dari kotoran dan wangi, kita harus mencucinya menggunakan...", 
    ["Sabun cuci", "Odol", "Sampo", "Minyak goreng"], "C", "Sampo digunakan khusus untuk membersihkan rambut."));
  soal.add(buatSoal("BIN-K1-STS-010", 1, "B. Indo", "Lingkungan", "STS_GENAP", 
    "Apa yang harus dilakukan jika melihat sampah bungkus jajan di halaman masjid?", 
    ["Dibiarkan saja", "Menyuruh teman membuangnya", "Membuangnya ke tempat sampah", "Ditendang"], "C", "Membuang sampah pada tempatnya dapat pahala lho."));
  soal.add(buatSoal("BIN-K1-STS-011", 1, "B. Indo", "Lingkungan", "STS_GENAP", 
    "Kebersihan pangkal dari...", 
    ["Kekayaan", "Kesehatan", "Kepandaian", "Kemalasan"], "B", "Orang yang bersih akan dijauhkan dari penyakit."));
  soal.add(buatSoal("BIN-K1-STS-012", 1, "B. Indo", "Lingkungan", "STS_GENAP", 
    "Bunda menyapu lantai agar rumah menjadi...", 
    ["Kotor", "Berantakan", "Bersih", "Harum"], "C", "Menyapu membersihkan debu di lantai."));
  soal.add(buatSoal("BIN-K1-STS-013", 1, "B. Indo", "Kebersihan Tubuh", "STS_GENAP", 
    "Kita memotong kuku tangan dan kaki setiap hari...", 
    ["Senin", "Jumat", "Ahad", "Kamis"], "B", "Sunnah Nabi Muhammad adalah memotong kuku di hari Jumat."));

  // BAB 5: Kalimat perintah dan larangan (5 soal)
  soal.add(buatSoal("BIN-K1-STS-014", 1, "B. Indo", "Kalimat Perintah", "STS_GENAP", 
    "Manakah di bawah ini yang merupakan kalimat perintah?", 
    ["Apakah kamu mau main?", "Tolong buang sampah ini ke tong sampah!", "Saya suka makan apel.", "Kemarin hari Minggu."], "B", "Kalimat perintah biasanya berakhiran tanda seru (!) dan menyuruh melakukan sesuatu."));
  soal.add(buatSoal("BIN-K1-STS-015", 1, "B. Indo", "Kalimat Larangan", "STS_GENAP", 
    "Kalimat yang digunakan untuk mencegah orang lain berbuat buruk disebut...", 
    ["Kalimat pujian", "Kalimat tanya", "Kalimat larangan", "Kalimat cerita"], "C", "Kalimat larangan biasanya menggunakan kata 'Jangan'."));
  soal.add(buatSoal("BIN-K1-STS-016", 1, "B. Indo", "Kalimat Larangan", "STS_GENAP", 
    "Kata yang tepat untuk melengkapi: '... buang sampah sembarangan!'", 
    ["Mari", "Ayo", "Jangan", "Tolong"], "C", "'Jangan' digunakan untuk melarang."));
  soal.add(buatSoal("BIN-K1-STS-017", 1, "B. Indo", "Kalimat Perintah", "STS_GENAP", 
    "Tanda baca yang biasanya ada di akhir kalimat perintah adalah...", 
    ["Tanda titik (.)", "Tanda koma (,)", "Tanda tanya (?)", "Tanda seru (!)"], "D", "Tanda seru (!) menandakan penekanan perintah."));
  soal.add(buatSoal("BIN-K1-STS-018", 1, "B. Indo", "Kalimat Larangan", "STS_GENAP", 
    "'Jangan berlari di dalam masjid!' adalah contoh kalimat...", 
    ["Pujian", "Larangan", "Tanya", "Ajakan"], "B", "Karena ada kata 'Jangan', maka itu kalimat larangan."));

  // BAB 6: Suku kata ga, gi, gu, ge, go & Persamaan/perbedaan anak (7 soal)
  soal.add(buatSoal("BIN-K1-STS-019", 1, "B. Indo", "Suku Kata G", "STS_GENAP", 
    "Nama hewan bertubuh besar dan punya belalai yang diawali suku kata 'ga' adalah...", 
    ["Gagak", "Gajah", "Garuda", "Gurita"], "B", "Gajah ciptaan Allah yang sangat besar."));
  soal.add(buatSoal("BIN-K1-STS-020", 1, "B. Indo", "Suku Kata G", "STS_GENAP", 
    "Di dalam mulut kita ada tulang putih untuk mengunyah. Bagian itu adalah...", 
    ["Gigi", "Gusi", "Garam", "Gula"], "A", "'Gigi' diawali dengan suku kata 'gi'."));
  soal.add(buatSoal("BIN-K1-STS-021", 1, "B. Indo", "Suku Kata G", "STS_GENAP", 
    "Guru di sekolah harus kita...", 
    ["Jauhi", "Bohongi", "Hormati", "Lupakan"], "C", "Menghormati guru adalah adab santri yang baik."));
  soal.add(buatSoal("BIN-K1-STS-022", 1, "B. Indo", "Suku Kata G", "STS_GENAP", 
    "Lengkapi kata berikut: ...-la. Rasanya manis sekali.", 
    ["Ga", "Gi", "Gu", "Ge"], "C", "Suku kata yang tepat adalah 'Gu', menjadi kata 'Gula'."));
  soal.add(buatSoal("BIN-K1-STS-023", 1, "B. Indo", "Persamaan/Perbedaan", "STS_GENAP", 
    "Rambut Ali keriting, sedangkan rambut Umar lurus. Meskipun berbeda, mereka harus saling...", 
    ["Mengejek", "Menyayangi", "Bermusuhan", "Diam-diaman"], "B", "Allah menciptakan manusia berbeda-beda agar saling mengenal dan menyayangi."));
  soal.add(buatSoal("BIN-K1-STS-024", 1, "B. Indo", "Persamaan/Perbedaan", "STS_GENAP", 
    "Aisyah suka makan ayam, Fatimah suka makan ikan. Sikap mereka sebaiknya...", 
    ["Berebut makanan", "Menghina makanan teman", "Saling menghargai", "Membuang makanan"], "C", "Perbedaan kesukaan itu biasa, kita harus menghargainya."));
  soal.add(buatSoal("BIN-K1-STS-025", 1, "B. Indo", "Mengurutkan Kata", "STS_GENAP", 
    "Urutkan kata acak berikut: masjid - ke - pergi - Ali", 
    ["Masjid pergi ke Ali", "Ali ke masjid pergi", "Ali pergi ke masjid", "Pergi Ali masjid ke"], "C", "Susunan yang benar adalah: Ali pergi ke masjid."));

  print("🚀 Memulai upload 25 soal Sumatif Tengah Semester B.Indo Kelas 1...");
  try {
    final payload = soal.map((q) => {'id': q['id'], 'data_json': q}).toList();
    await supabase.from('questions').upsert(payload);
    print('✅ Berhasil upload 25 soal STS!');
  } catch (e) {
    print('❌ Gagal upload: $e');
  }
}
