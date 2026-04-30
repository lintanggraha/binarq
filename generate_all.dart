import 'dart:convert';
import 'dart:io';
import 'dart:math';

const subjects = <String, String>{
  'MTK': 'Matematika',
  'PAI': 'Pendidikan Agama Islam',
  'QURAN': 'Al-Qur\'an dan Tahfidz',
  'ARB': 'Bahasa Arab',
  'BIND': 'Bahasa Indonesia',
  'IPAS': 'Ilmu Pengetahuan Alam dan Sosial',
  'PPKN': 'Pendidikan Pancasila',
  'BIG': 'Bahasa Inggris',
  'PJOK': 'PJOK',
  'SBDP': 'Seni Budaya',
};

const stages = <String, String>{
  'SAS': 'Sumatif Awal Semester',
  'STS': 'Sumatif Tengah Semester',
  'SAT': 'Sumatif Akhir Tahun',
};

String faseFor(int grade) {
  if (grade <= 2) return 'A';
  if (grade <= 4) return 'B';
  return 'C';
}

String difficultyFor(String code) {
  if (code == 'SAS') return 'mudah';
  if (code == 'STS') return 'sedang';
  return 'menantang';
}

List<String> topicsFor(String subject, int grade, String stageCode) {
  final phase = faseFor(grade);
  final bank = <String, Map<String, List<String>>>{
    'MTK': {
      'A': ['Bilangan Cacah', 'Penjumlahan', 'Pengurangan', 'Bangun Datar', 'Pengukuran Sederhana'],
      'B': ['Perkalian', 'Pembagian', 'Pecahan', 'Keliling dan Luas', 'Data Sederhana'],
      'C': ['Operasi Hitung Campuran', 'Pecahan dan Desimal', 'Rasio', 'Volume', 'Penyajian Data'],
    },
    'PAI': {
      'A': ['Huruf Hijaiyah', 'Rukun Iman', 'Akhlak Terpuji', 'Wudu dan Salat', 'Kisah Nabi'],
      'B': ['Surah Pendek', 'Asmaul Husna', 'Puasa', 'Zakat', 'Keteladanan Rasul'],
      'C': ['Tajwid Dasar', 'Iman kepada Kitab dan Rasul', 'Akhlak Bermasyarakat', 'Haji dan Kurban', 'Khulafaur Rasyidin'],
    },
    'QURAN': {
      'A': ['Al-Fatihah', 'An-Nas', 'Al-Falaq', 'Adab Membaca Al-Qur\'an', 'Makharijul Huruf'],
      'B': ['Al-Ikhlas', 'Al-Kautsar', 'Al-Maun', 'Hukum Nun Sukun', 'Murajaah Hafalan'],
      'C': ['At-Tin', 'Al-Alaq', 'Al-Qadr', 'Mad Thabi\'i', 'Tadabbur Ayat'],
    },
    'ARB': {
      'A': ['Salam', 'Anggota Keluarga', 'Angka 1-10', 'Warna', 'Benda Kelas'],
      'B': ['Isim Isyarah', 'Dhamir', 'Profesi', 'Hari', 'Kalimat Sederhana'],
      'C': ['Fi\'il Mudhari', 'Jumlah Ismiyah', 'Percakapan', 'Waktu', 'Kata Sifat'],
    },
    'BIND': {
      'A': ['Menyimak Cerita', 'Suku Kata', 'Kalimat Sederhana', 'Tanda Baca', 'Cerita Pengalaman'],
      'B': ['Ide Pokok', 'Teks Informasi', 'Pantun', 'Wawancara', 'Paragraf'],
      'C': ['Teks Eksplanasi', 'Pidato', 'Laporan Pengamatan', 'Iklan', 'Resensi Sederhana'],
    },
    'IPAS': {
      'A': ['Tubuhku', 'Tumbuhan', 'Hewan', 'Lingkungan Rumah', 'Cuaca'],
      'B': ['Siklus Hidup', 'Wujud Zat', 'Gaya', 'Peta Lingkungan', 'Kegiatan Ekonomi'],
      'C': ['Sistem Organ', 'Rantai Makanan', 'Energi', 'Tata Surya', 'Keragaman Sosial Budaya'],
    },
    'PPKN': {
      'A': ['Simbol Pancasila', 'Aturan Rumah', 'Aturan Sekolah', 'Kerja Sama', 'Identitas Diri'],
      'B': ['Hak dan Kewajiban', 'Musyawarah', 'Norma', 'Keberagaman', 'Gotong Royong'],
      'C': ['UUD 1945', 'NKRI', 'Bhinneka Tunggal Ika', 'Demokrasi', 'Tanggung Jawab Warga'],
    },
    'BIG': {
      'A': ['Greeting', 'Numbers', 'Colors', 'Family', 'Classroom Objects'],
      'B': ['Daily Activities', 'Food and Drink', 'Animals', 'Simple Present', 'Directions'],
      'C': ['Past Activities', 'Describing People', 'Procedure Text', 'Public Places', 'Invitation'],
    },
    'PJOK': {
      'A': ['Gerak Lokomotor', 'Gerak Nonlokomotor', 'Kebersihan Tubuh', 'Permainan Sederhana', 'Keselamatan Bermain'],
      'B': ['Kebugaran Jasmani', 'Senam Lantai', 'Permainan Bola', 'Pola Hidup Sehat', 'Renang Dasar'],
      'C': ['Atletik', 'Strategi Permainan', 'Kesehatan Reproduksi Dasar', 'Cedera Ringan', 'Sportivitas'],
    },
    'SBDP': {
      'A': ['Garis dan Warna', 'Lagu Anak', 'Gerak Tari', 'Kolase', 'Irama'],
      'B': ['Ragam Hias', 'Ansambel Sederhana', 'Pola Lantai', 'Kriya', 'Apresiasi Karya'],
      'C': ['Komposisi Rupa', 'Tangga Nada', 'Tari Nusantara', 'Poster', 'Pameran Karya'],
    },
  };

  final topics = bank[subject]![phase]!;
  final offset = stages.keys.toList().indexOf(stageCode).clamp(0, 2);
  return [topics[(grade + offset) % topics.length], topics[(grade + offset + 2) % topics.length]];
}

Map<String, dynamic> question({
  required String id,
  required int grade,
  required String subject,
  required String stageCode,
  required String topic,
  required String prompt,
  required List<String> options,
  required int correctIndex,
  required String explanation,
  required String hint,
}) {
  final labels = ['A', 'B', 'C', 'D'];
  return {
    'id': id,
    'metadata': {
      'kelas': grade,
      'fase': faseFor(grade),
      'mapel': subject,
      'topik': topic,
      'kategori_ujian': stages[stageCode] ?? stageCode,
      'tingkat_kesulitan': difficultyFor(stageCode),
      'xp_reward': difficultyFor(stageCode) == 'mudah' ? 10 : difficultyFor(stageCode) == 'sedang' ? 15 : 20,
      'konteks_islami': true,
      'tag_nilai_islam': ['adab', 'amanah', 'ilmu_bermanfaat'],
    },
    'content': {
      'tipe_soal': 'pilihan_ganda',
      'pertanyaan': prompt,
      'pilihan': [
        for (var i = 0; i < options.length; i++) {'id_pilihan': labels[i], 'teks': options[i]},
      ],
      'jawaban_benar': labels[correctIndex],
    },
    'feedback': {
      'penjelasan_anak': explanation,
      'hint': hint,
    },
  };
}

Map<String, dynamic> buildQuestion(String subject, int grade, String stageCode, String topic, int index) {
  final rng = Random('$subject-$grade-$stageCode-$index'.codeUnits.fold(0, (a, b) => a + b));
  final id = '$subject-K$grade-${faseFor(grade)}-$stageCode-${index.toString().padLeft(3, '0')}';

  if (subject == 'MTK') {
    final a = grade * 4 + index + rng.nextInt(5);
    final b = grade + index + rng.nextInt(4);
    final answer = stageCode == 'SAS' ? a + b : stageCode == 'STS' ? a * b : (a + b) * 2;
    final options = [answer, answer + 2, max(0, answer - 2), answer + grade + 3]..shuffle(rng);
    return question(
      id: id,
      grade: grade,
      subject: subject,
      stageCode: stageCode,
      topic: topic,
      prompt: 'Kelas $grade mengumpulkan $a buku wakaf dan mendapat tambahan $b buku. Pada materi $topic, jawaban yang tepat untuk perhitungan ini adalah...',
      options: options.map((e) => '$e').toList(),
      correctIndex: options.indexOf(answer),
      explanation: 'Jawabannya $answer. Matematika membantu kita menghitung amanah dengan teliti.',
      hint: 'Perhatikan operasi hitung yang diminta pada soal.',
    );
  }

  final data = _subjectItems(subject, grade, topic, stageCode, index);
  final options = List<String>.from(data.options)..shuffle(rng);
  return question(
    id: id,
    grade: grade,
    subject: subject,
    stageCode: stageCode,
    topic: topic,
    prompt: data.prompt,
    options: options,
    correctIndex: options.indexOf(data.answer),
    explanation: data.explanation,
    hint: data.hint,
  );
}

({String prompt, String answer, List<String> options, String explanation, String hint}) _subjectItems(
  String subject,
  int grade,
  String topic,
  String stageCode,
  int index,
) {
  final stage = stages[stageCode]!;
  final name = subjects[subject]!;
  final base = 'Soal $stage $name kelas $grade tentang $topic.';
  final items = <String, ({String prompt, String answer, List<String> options, String explanation, String hint})>{
    'PAI': (
      prompt: '$base Sikap terbaik saat berbeda pendapat dengan teman adalah...',
      answer: 'bermusyawarah dengan santun',
      options: ['bermusyawarah dengan santun', 'memaksakan pendapat', 'mengejek teman', 'meninggalkan salat'],
      explanation: 'Musyawarah dan santun termasuk akhlak terpuji yang diajarkan Islam.',
      hint: 'Pilih sikap yang menunjukkan adab baik.',
    ),
    'QURAN': (
      prompt: '$base Adab yang benar sebelum membaca Al-Qur\'an adalah...',
      answer: 'berwudu dan membaca dengan tartil',
      options: ['berwudu dan membaca dengan tartil', 'membaca sambil berlari', 'meletakkan mushaf sembarangan', 'berbicara keras'],
      explanation: 'Membaca Al-Qur\'an dilakukan dengan suci, tenang, dan tartil.',
      hint: 'Ingat adab kepada kalam Allah.',
    ),
    'ARB': (
      prompt: '$base Arti kata "madrasah" dalam bahasa Indonesia adalah...',
      answer: 'sekolah',
      options: ['sekolah', 'pasar', 'rumah sakit', 'lapangan'],
      explanation: '"Madrasah" berarti sekolah atau tempat belajar.',
      hint: 'Kata ini sering dipakai untuk tempat belajar.',
    ),
    'BIND': (
      prompt: '$base Kalimat yang memakai tanda baca titik dengan benar adalah...',
      answer: 'Ali membaca buku di perpustakaan.',
      options: ['Ali membaca buku di perpustakaan.', 'Ali membaca buku di perpustakaan?', 'Ali membaca buku di perpustakaan!', 'ali membaca buku di perpustakaan'],
      explanation: 'Kalimat berita diakhiri tanda titik dan diawali huruf kapital.',
      hint: 'Cari kalimat berita yang rapi.',
    ),
    'IPAS': (
      prompt: '$base Contoh menjaga ciptaan Allah di lingkungan sekolah adalah...',
      answer: 'membuang sampah pada tempatnya',
      options: ['membuang sampah pada tempatnya', 'memetik tanaman sembarangan', 'membiarkan keran terbuka', 'mencoret meja'],
      explanation: 'Lingkungan bersih membantu makhluk hidup tetap sehat.',
      hint: 'Pilih tindakan yang membuat lingkungan bersih.',
    ),
    'PPKN': (
      prompt: '$base Contoh pengamalan gotong royong adalah...',
      answer: 'membersihkan kelas bersama-sama',
      options: ['membersihkan kelas bersama-sama', 'mengerjakan piket sendirian lalu marah', 'menolak membantu teman', 'mengambil hak orang lain'],
      explanation: 'Gotong royong berarti bekerja sama untuk kebaikan bersama.',
      hint: 'Cari kegiatan yang dilakukan bersama.',
    ),
    'BIG': (
      prompt: '$base The correct response to "Assalamu\'alaikum, good morning" is...',
      answer: 'Wa\'alaikumussalam, good morning',
      options: ['Wa\'alaikumussalam, good morning', 'Good night, I sleep', 'I am a pencil', 'No, it is red'],
      explanation: 'Sapaan dijawab dengan sapaan yang sesuai dan santun.',
      hint: 'Pilih jawaban untuk greeting.',
    ),
    'PJOK': (
      prompt: '$base Kebiasaan sehat setelah berolahraga adalah...',
      answer: 'minum air dan membersihkan badan',
      options: ['minum air dan membersihkan badan', 'langsung tidur tanpa ganti baju', 'makan berlebihan', 'berlari di lantai licin'],
      explanation: 'Tubuh perlu cairan dan kebersihan setelah bergerak.',
      hint: 'Pilih kebiasaan yang menjaga kesehatan.',
    ),
    'SBDP': (
      prompt: '$base Warna primer terdiri dari...',
      answer: 'merah, kuning, dan biru',
      options: ['merah, kuning, dan biru', 'hijau, ungu, dan jingga', 'hitam, putih, dan abu-abu', 'cokelat, emas, dan perak'],
      explanation: 'Merah, kuning, dan biru adalah warna dasar untuk mencampur warna lain.',
      hint: 'Warna primer adalah warna dasar.',
    ),
  };
  return items[subject]!;
}

void main() {
  final questions = <Map<String, dynamic>>[];

  for (var grade = 1; grade <= 6; grade++) {
    final gradeStages = {...stages};
    if (grade == 6) {
      gradeStages.addAll({
        'TKA': 'Tes Kemampuan Akademik',
        'US': 'Ujian Sekolah',
      });
    }

    for (final subject in subjects.keys) {
      for (final stageCode in gradeStages.keys) {
        final topics = topicsFor(subject, grade, stages.containsKey(stageCode) ? stageCode : 'SAT');
        for (var i = 0; i < topics.length; i++) {
          questions.add(buildQuestion(subject, grade, stageCode, topics[i], i + 1));
        }
      }
    }
  }

  const encoder = JsonEncoder.withIndent('  ');
  File('bank_soal.json').writeAsStringSync('${encoder.convert(questions)}\n');
  print('Generated ${questions.length} questions into bank_soal.json');
}
