import 'dart:convert';
import 'dart:io';
import 'dart:math';

// ignore_for_file: avoid_print

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
      'A': ['Rukun Iman', 'Rukun Islam', 'Akhlak Terpuji', 'Wudu dan Salat', 'Kisah Nabi'],
      'B': ['Asmaul Husna', 'Puasa', 'Zakat', 'Adab Berteman', 'Keteladanan Rasul'],
      'C': ['Iman kepada Kitab', 'Iman kepada Rasul', 'Akhlak Bermasyarakat', 'Haji dan Kurban', 'Khulafaur Rasyidin'],
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
  return List.generate(5, (i) => topics[(grade + offset + i) % topics.length]);
}

Map<String, dynamic> question({
  required String id,
  required int grade,
  required String subject,
  required String stageCode,
  required String topic,
  required String type,
  required String prompt,
  required String answer,
  required String explanation,
  required String hint,
  List<String> options = const [],
}) {
  final labels = ['A', 'B', 'C', 'D'];
  final correctIndex = options.indexOf(answer);

  return {
    'id': id,
    'metadata': {
      'kelas': grade,
      'fase': faseFor(grade),
      'mapel': subject,
      'topik': topic,
      'kategori_ujian': stages[stageCode] ?? stageCode,
      'tingkat_kesulitan': difficultyFor(stageCode),
      'xp_reward': difficultyFor(stageCode) == 'mudah'
          ? 10
          : difficultyFor(stageCode) == 'sedang'
              ? 15
              : 20,
      'konteks_islami': true,
      'tag_nilai_islam': ['adab', 'amanah', 'ilmu_bermanfaat'],
    },
    'content': {
      'tipe_soal': type,
      'pertanyaan': prompt,
      'pilihan': [
        if (type == 'pilihan_ganda')
          for (var i = 0; i < options.length; i++)
            {'id_pilihan': labels[i], 'teks': options[i]},
      ],
      'jawaban_benar': type == 'pilihan_ganda' ? labels[correctIndex] : answer,
    },
    'feedback': {
      'penjelasan_anak': explanation,
      'hint': hint,
    },
  };
}

Map<String, dynamic> buildQuestion(
  String subject,
  int grade,
  String stageCode,
  int number,
) {
  final isEssay = number > 25;
  final topic = topicsFor(subject, grade, stageCode)[(number - 1) % 5];
  final seed = '$subject-$grade-$stageCode-$number'
      .codeUnits
      .fold<int>(0, (total, value) => total + value);
  final rng = Random(seed);
  final id =
      '$subject-K$grade-${faseFor(grade)}-$stageCode-${number.toString().padLeft(3, '0')}';
  final item = subject == 'MTK'
      ? _mathItem(grade, topic, stageCode, number, rng, isEssay)
      : _subjectItem(subject, grade, topic, number, isEssay);

  final options = List<String>.from(item.options)..shuffle(rng);

  return question(
    id: id,
    grade: grade,
    subject: subject,
    stageCode: stageCode,
    topic: topic,
    type: isEssay ? 'isian' : 'pilihan_ganda',
    prompt: item.prompt,
    answer: item.answer,
    options: isEssay ? const [] : options,
    explanation: item.explanation,
    hint: item.hint,
  );
}

({
  String prompt,
  String answer,
  List<String> options,
  String explanation,
  String hint,
}) _mathItem(
  int grade,
  String topic,
  String stageCode,
  int number,
  Random rng,
  bool isEssay,
) {
  final a = grade * 6 + number + rng.nextInt(8);
  final b = grade * 2 + (number % 7) + rng.nextInt(5) + 1;
  final mode = (number - 1) % 5;
  late String prompt;
  late int answer;

  if (mode == 0) {
    answer = a + b;
    prompt = 'Kelas $grade mengumpulkan $a buku dan mendapat tambahan $b buku. Berapa jumlah buku sekarang?';
  } else if (mode == 1) {
    answer = max(0, a - b);
    prompt = 'Di rak ada $a buku. Dipinjam $b buku. Berapa buku yang tersisa?';
  } else if (mode == 2) {
    answer = grade <= 2 ? a + b + grade : (grade + 2) * ((number % 6) + 2);
    prompt = grade <= 2
        ? 'Ibu membawa $a kurma, lalu ayah menambah $b kurma dan guru memberi $grade kurma. Berapa semuanya?'
        : 'Ada ${grade + 2} kelompok, tiap kelompok berisi ${(number % 6) + 2} siswa. Berapa jumlah siswa?';
  } else if (mode == 3) {
    final side = grade + (number % 6) + 2;
    answer = side * 4;
    prompt = 'Sebuah taman berbentuk persegi memiliki sisi $side meter. Berapa kelilingnya?';
  } else {
    final value = ((number % 9) + grade + 2) * 10;
    answer = value;
    prompt = 'Nilai sedekah kelas ditulis ${value ~/ 10} puluhan rupiah. Berapa nilainya?';
  }

  final options = <int>{answer, answer + 2, max(0, answer - 2), answer + grade + 4}.toList();
  return (
    prompt: isEssay ? '$prompt Tuliskan angkanya saja.' : prompt,
    answer: '$answer',
    options: options.map((e) => '$e').toList(),
    explanation: 'Jawabannya $answer. Pada materi $topic, hitung pelan-pelan dan teliti.',
    hint: 'Tentukan operasi hitung yang sesuai dengan cerita.',
  );
}

({
  String prompt,
  String answer,
  List<String> options,
  String explanation,
  String hint,
}) _subjectItem(
  String subject,
  int grade,
  String topic,
  int number,
  bool isEssay,
) {
  const base = '';
  final items = _itemsBySubject(subject, base);
  final item = items[(number - 1) % items.length];
  final cycle = (number - 1) ~/ items.length;

  if (!isEssay) {
    return (
      prompt: _variantPrompt(item.prompt, cycle),
      answer: item.answer,
      options: item.options,
      explanation: item.explanation,
      hint: item.hint,
    );
  }

  return (
    prompt: _variantPrompt(item.prompt, cycle).replaceAll('...', '.'),
    answer: item.answer,
    options: const [],
    explanation: item.explanation,
    hint: item.hint,
  );
}

String _variantPrompt(String prompt, int cycle) {
  final clean = prompt.trim();
  if (cycle == 0) return clean;
  if (cycle == 1) {
    return clean.replaceFirst('adalah...', 'yang tepat adalah...');
  }
  if (cycle == 2) {
    return clean.replaceFirst('adalah...', 'yaitu...');
  }
  if (cycle == 3) {
    return clean.replaceFirst('disebut...', 'disebut dengan...');
  }
  if (cycle == 4) {
    return clean.replaceFirst('adalah...', 'adalah apa?');
  }
  return clean;
}

List<
    ({
      String prompt,
      String answer,
      List<String> options,
      String explanation,
      String hint,
    })> _itemsBySubject(String subject, String base) {
  final data = <String, List<({String prompt, String answer, List<String> options, String explanation, String hint})>>{
    'PAI': [
      _item('$base Rukun Islam yang dilakukan dengan menahan lapar dan haus dari subuh sampai magrib adalah...', 'puasa', ['puasa', 'zakat', 'haji', 'wudu'], 'Puasa adalah ibadah menahan diri sejak subuh sampai magrib.', 'Ingat ibadah di bulan Ramadan.'),
      _item('$base Sikap terbaik saat berbeda pendapat dengan teman adalah...', 'bermusyawarah dengan santun', ['bermusyawarah dengan santun', 'memaksakan pendapat', 'mengejek teman', 'meninggalkan salat'], 'Musyawarah dan santun termasuk akhlak terpuji.', 'Pilih sikap yang menunjukkan adab baik.'),
      _item('$base Sebelum salat, seorang muslim harus bersuci dengan cara...', 'wudu', ['wudu', 'berlari', 'bernyanyi', 'tidur'], 'Wudu dilakukan untuk bersuci sebelum salat.', 'Ingat kegiatan sebelum salat.'),
      _item('$base Percaya kepada Allah termasuk rukun...', 'iman', ['iman', 'sekolah', 'olahraga', 'warna'], 'Rukun iman dimulai dengan percaya kepada Allah.', 'Pilih rukun yang berkaitan dengan keyakinan.'),
      _item('$base Contoh akhlak terpuji kepada orang tua adalah...', 'berbicara sopan', ['berbicara sopan', 'membentak', 'mengabaikan nasihat', 'berbohong'], 'Berbicara sopan menunjukkan hormat kepada orang tua.', 'Cari perilaku yang baik.'),
    ],
    'QURAN': [
      _item('$base Adab yang benar sebelum membaca Al-Qur\'an adalah...', 'berwudu dan membaca dengan tartil', ['berwudu dan membaca dengan tartil', 'membaca sambil berlari', 'meletakkan mushaf sembarangan', 'berbicara keras'], 'Membaca Al-Qur\'an dilakukan dengan suci, tenang, dan tartil.', 'Ingat adab kepada kalam Allah.'),
      _item('$base Membaca Al-Qur\'an dengan perlahan dan benar disebut...', 'tartil', ['tartil', 'tergesa-gesa', 'diam', 'berteriak'], 'Tartil berarti membaca dengan baik dan teratur.', 'Cari cara membaca yang rapi.'),
      _item('$base Surah pembuka dalam Al-Qur\'an adalah...', 'Al-Fatihah', ['Al-Fatihah', 'An-Nas', 'Al-Falaq', 'Al-Kautsar'], 'Al-Fatihah adalah surah pembuka.', 'Surah ini dibaca dalam salat.'),
      _item('$base Tempat keluarnya huruf hijaiyah disebut...', 'makharijul huruf', ['makharijul huruf', 'harakat', 'waqaf', 'tajwid'], 'Makharijul huruf membahas tempat keluarnya huruf.', 'Ingat asal bunyi huruf.'),
      _item('$base Mengulang hafalan Al-Qur\'an agar tidak lupa disebut...', 'murajaah', ['murajaah', 'azan', 'iqamah', 'sedekah'], 'Murajaah berarti mengulang hafalan.', 'Kegiatan ini menjaga hafalan.'),
    ],
    'ARB': [
      _item('$base Arti kata "madrasah" adalah...', 'sekolah', ['sekolah', 'pasar', 'rumah sakit', 'lapangan'], '"Madrasah" berarti sekolah.', 'Tempat belajar.'),
      _item('$base Kata sapaan bahasa Arab untuk selamat pagi adalah...', 'shabahul khair', ['shabahul khair', 'lailatun sa\'idah', 'baitun', 'qalamun'], 'Shabahul khair digunakan untuk sapaan pagi.', 'Sapaan saat pagi.'),
      _item('$base Arti kata "kitabun" adalah...', 'buku', ['buku', 'meja', 'pintu', 'air'], 'Kitabun berarti buku.', 'Benda untuk membaca.'),
      _item('$base Bahasa Arab dari ayah adalah...', 'abun', ['abun', 'ummun', 'akhun', 'bintun'], 'Abun berarti ayah.', 'Anggota keluarga laki-laki orang tua.'),
      _item('$base Arti warna "ahmar" adalah...', 'merah', ['merah', 'biru', 'kuning', 'hijau'], 'Ahmar berarti merah.', 'Salah satu warna primer.'),
    ],
    'BIND': [
      _item('$base Kalimat yang memakai tanda titik dengan benar adalah...', 'Ali membaca buku di perpustakaan.', ['Ali membaca buku di perpustakaan.', 'Ali membaca buku di perpustakaan?', 'Ali membaca buku di perpustakaan!', 'ali membaca buku di perpustakaan'], 'Kalimat berita diakhiri titik dan diawali huruf kapital.', 'Cari kalimat berita yang rapi.'),
      _item('$base Huruf kapital dipakai pada awal...', 'kalimat', ['kalimat', 'tanda koma', 'spasi', 'titik'], 'Awal kalimat ditulis dengan huruf kapital.', 'Lihat huruf pertama.'),
      _item('$base Ide pokok adalah gagasan...', 'utama', ['utama', 'tambahan', 'lucu', 'terakhir'], 'Ide pokok adalah gagasan utama paragraf.', 'Cari gagasan paling penting.'),
      _item('$base Tanda tanya digunakan untuk kalimat...', 'tanya', ['tanya', 'berita', 'perintah biasa', 'sapaan'], 'Kalimat tanya diakhiri tanda tanya.', 'Kalimat yang meminta jawaban.'),
      _item('$base Cerita pengalaman biasanya menceritakan kejadian yang...', 'pernah dialami', ['pernah dialami', 'tidak masuk akal', 'selalu masa depan', 'tanpa tokoh'], 'Pengalaman adalah kejadian yang pernah dialami.', 'Ingat peristiwa pribadi.'),
    ],
    'IPAS': [
      _item('$base Contoh menjaga lingkungan sekolah adalah...', 'membuang sampah pada tempatnya', ['membuang sampah pada tempatnya', 'memetik tanaman sembarangan', 'membiarkan keran terbuka', 'mencoret meja'], 'Lingkungan bersih membantu makhluk hidup tetap sehat.', 'Pilih tindakan bersih.'),
      _item('$base Bagian tumbuhan yang menyerap air adalah...', 'akar', ['akar', 'daun', 'bunga', 'buah'], 'Akar menyerap air dari tanah.', 'Bagian yang berada di tanah.'),
      _item('$base Hewan yang berkembang biak dengan bertelur disebut...', 'ovipar', ['ovipar', 'vivipar', 'mamalia', 'amfibi'], 'Ovipar adalah hewan bertelur.', 'Contohnya ayam.'),
      _item('$base Matahari merupakan sumber...', 'energi panas dan cahaya', ['energi panas dan cahaya', 'air hujan', 'tanah', 'suara'], 'Matahari memberi panas dan cahaya.', 'Terasa hangat dan terang.'),
      _item('$base Air dapat berubah menjadi es jika...', 'didinginkan', ['didinginkan', 'dipanaskan terus', 'diberi gula', 'diaduk'], 'Air membeku menjadi es saat didinginkan.', 'Suhu menjadi rendah.'),
    ],
    'PPKN': [
      _item('$base Contoh gotong royong adalah...', 'membersihkan kelas bersama-sama', ['membersihkan kelas bersama-sama', 'menolak membantu teman', 'mengambil hak orang lain', 'bertengkar'], 'Gotong royong berarti bekerja sama.', 'Dilakukan bersama.'),
      _item('$base Lambang sila pertama Pancasila adalah...', 'bintang', ['bintang', 'rantai', 'pohon beringin', 'padi dan kapas'], 'Sila pertama dilambangkan bintang.', 'Lambang Ketuhanan Yang Maha Esa.'),
      _item('$base Aturan sekolah harus...', 'ditaati', ['ditaati', 'dilanggar', 'diabaikan', 'disembunyikan'], 'Aturan dibuat untuk ketertiban bersama.', 'Perilaku murid baik.'),
      _item('$base Hak anak di sekolah adalah mendapat...', 'pelajaran', ['pelajaran', 'hukuman tanpa sebab', 'pekerjaan orang dewasa', 'larangan belajar'], 'Mendapat pelajaran adalah hak siswa.', 'Sesuatu yang diterima siswa.'),
      _item('$base Keputusan bersama sebaiknya diambil dengan...', 'musyawarah', ['musyawarah', 'marah-marah', 'paksaan', 'diam saja'], 'Musyawarah membantu mencapai mufakat.', 'Diskusi dengan santun.'),
    ],
    'BIG': [
      _item('$base The correct response to "Good morning" is...', 'Good morning', ['Good morning', 'Good night', 'I am pencil', 'No, red'], 'Greeting dijawab dengan sapaan yang sesuai.', 'Morning dijawab morning.'),
      _item('$base The English word for "buku" is...', 'book', ['book', 'chair', 'door', 'fish'], 'Book berarti buku.', 'Object for reading.'),
      _item('$base The color of grass is usually...', 'green', ['green', 'red', 'black', 'white'], 'Grass is usually green.', 'Look at plants.'),
      _item('$base "One, two, three" means...', 'satu, dua, tiga', ['satu, dua, tiga', 'empat, lima, enam', 'merah, biru, hijau', 'ayah, ibu, kakak'], 'One, two, three adalah angka 1, 2, 3.', 'Numbers.'),
      _item('$base "Mother" in Indonesian means...', 'ibu', ['ibu', 'ayah', 'adik', 'guru'], 'Mother berarti ibu.', 'Female parent.'),
    ],
    'PJOK': [
      _item('$base Kebiasaan sehat setelah olahraga adalah...', 'minum air dan membersihkan badan', ['minum air dan membersihkan badan', 'langsung tidur tanpa ganti baju', 'makan berlebihan', 'berlari di lantai licin'], 'Tubuh perlu cairan dan kebersihan setelah bergerak.', 'Pilih kebiasaan sehat.'),
      _item('$base Gerak berpindah tempat disebut gerak...', 'lokomotor', ['lokomotor', 'diam', 'pasif', 'istirahat'], 'Lokomotor adalah gerak berpindah tempat.', 'Contohnya berjalan.'),
      _item('$base Pemanasan dilakukan sebelum olahraga untuk...', 'mengurangi risiko cedera', ['mengurangi risiko cedera', 'membuat lapar', 'mengotori baju', 'mengantuk'], 'Pemanasan menyiapkan tubuh.', 'Agar tubuh siap bergerak.'),
      _item('$base Contoh alat permainan bola adalah...', 'bola', ['bola', 'pensil', 'sendok', 'bantal'], 'Bola digunakan dalam permainan bola.', 'Benda bulat.'),
      _item('$base Sikap sportif berarti mau menerima...', 'hasil pertandingan', ['hasil pertandingan', 'kecurangan', 'ejekan', 'permusuhan'], 'Sportif berarti jujur dan menerima hasil.', 'Sikap baik saat bermain.'),
    ],
    'SBDP': [
      _item('$base Warna primer terdiri dari...', 'merah, kuning, dan biru', ['merah, kuning, dan biru', 'hijau, ungu, dan jingga', 'hitam, putih, dan abu-abu', 'cokelat, emas, dan perak'], 'Merah, kuning, dan biru adalah warna dasar.', 'Warna dasar.'),
      _item('$base Pola bunyi teratur dalam musik disebut...', 'irama', ['irama', 'warna', 'garis', 'patung'], 'Irama adalah pola bunyi yang teratur.', 'Ada dalam lagu.'),
      _item('$base Karya seni dari potongan kertas yang ditempel disebut...', 'kolase', ['kolase', 'lagu', 'pantun', 'dialog'], 'Kolase dibuat dari bahan yang ditempel.', 'Menempel potongan bahan.'),
      _item('$base Unsur rupa yang berbentuk goresan disebut...', 'garis', ['garis', 'nada', 'gerak', 'suara'], 'Garis adalah goresan dalam seni rupa.', 'Bisa lurus atau lengkung.'),
      _item('$base Gerakan indah mengikuti irama disebut...', 'tari', ['tari', 'lukis', 'patung', 'membaca'], 'Tari menggabungkan gerak dan irama.', 'Dilakukan dengan tubuh.'),
    ],
  };

  return data[subject]!;
}

({String prompt, String answer, List<String> options, String explanation, String hint}) _item(
  String prompt,
  String answer,
  List<String> options,
  String explanation,
  String hint,
) {
  return (
    prompt: prompt.trim(),
    answer: answer,
    options: options,
    explanation: explanation,
    hint: hint,
  );
}

void main() {
  final questions = <Map<String, dynamic>>[];

  for (var grade = 1; grade <= 6; grade++) {
    for (final subject in subjects.keys) {
      for (final stageCode in stages.keys) {
        for (var number = 1; number <= 30; number++) {
          questions.add(buildQuestion(subject, grade, stageCode, number));
        }
      }
    }
  }

  const encoder = JsonEncoder.withIndent('  ');
  File('bank_soal.json').writeAsStringSync('${encoder.convert(questions)}\n');
  print('Generated ${questions.length} questions into bank_soal.json');
}
