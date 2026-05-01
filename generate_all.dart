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
      'A': [
        'Bilangan Cacah',
        'Penjumlahan',
        'Pengurangan',
        'Bangun Datar',
        'Pengukuran Sederhana'
      ],
      'B': [
        'Perkalian',
        'Pembagian',
        'Pecahan',
        'Keliling dan Luas',
        'Data Sederhana'
      ],
      'C': [
        'Operasi Hitung Campuran',
        'Pecahan dan Desimal',
        'Rasio',
        'Volume',
        'Penyajian Data'
      ],
    },
    'PAI': {
      'A': [
        'Rukun Iman',
        'Rukun Islam',
        'Akhlak Terpuji',
        'Wudu dan Salat',
        'Kisah Nabi'
      ],
      'B': [
        'Asmaul Husna',
        'Puasa',
        'Zakat',
        'Adab Berteman',
        'Keteladanan Rasul'
      ],
      'C': [
        'Iman kepada Kitab',
        'Iman kepada Rasul',
        'Akhlak Bermasyarakat',
        'Haji dan Kurban',
        'Khulafaur Rasyidin'
      ],
    },
    'QURAN': {
      'A': [
        'Al-Fatihah',
        'An-Nas',
        'Al-Falaq',
        'Adab Membaca Al-Qur\'an',
        'Makharijul Huruf'
      ],
      'B': [
        'Al-Ikhlas',
        'Al-Kautsar',
        'Al-Maun',
        'Hukum Nun Sukun',
        'Murajaah Hafalan'
      ],
      'C': ['At-Tin', 'Al-Alaq', 'Al-Qadr', 'Mad Thabi\'i', 'Tadabbur Ayat'],
    },
    'ARB': {
      'A': ['Salam', 'Anggota Keluarga', 'Angka 1-10', 'Warna', 'Benda Kelas'],
      'B': ['Isim Isyarah', 'Dhamir', 'Profesi', 'Hari', 'Kalimat Sederhana'],
      'C': [
        'Fi\'il Mudhari',
        'Jumlah Ismiyah',
        'Percakapan',
        'Waktu',
        'Kata Sifat'
      ],
    },
    'BIND': {
      'A': [
        'Menyimak Cerita',
        'Suku Kata',
        'Kalimat Sederhana',
        'Tanda Baca',
        'Cerita Pengalaman'
      ],
      'B': ['Ide Pokok', 'Teks Informasi', 'Pantun', 'Wawancara', 'Paragraf'],
      'C': [
        'Teks Eksplanasi',
        'Pidato',
        'Laporan Pengamatan',
        'Iklan',
        'Resensi Sederhana'
      ],
    },
    'IPAS': {
      'A': ['Tubuhku', 'Tumbuhan', 'Hewan', 'Lingkungan Rumah', 'Cuaca'],
      'B': [
        'Siklus Hidup',
        'Wujud Zat',
        'Gaya',
        'Peta Lingkungan',
        'Kegiatan Ekonomi'
      ],
      'C': [
        'Sistem Organ',
        'Rantai Makanan',
        'Energi',
        'Tata Surya',
        'Keragaman Sosial Budaya'
      ],
    },
    'PPKN': {
      'A': [
        'Simbol Pancasila',
        'Aturan Rumah',
        'Aturan Sekolah',
        'Kerja Sama',
        'Identitas Diri'
      ],
      'B': [
        'Hak dan Kewajiban',
        'Musyawarah',
        'Norma',
        'Keberagaman',
        'Gotong Royong'
      ],
      'C': [
        'UUD 1945',
        'NKRI',
        'Bhinneka Tunggal Ika',
        'Demokrasi',
        'Tanggung Jawab Warga'
      ],
    },
    'BIG': {
      'A': ['Greeting', 'Numbers', 'Colors', 'Family', 'Classroom Objects'],
      'B': [
        'Daily Activities',
        'Food and Drink',
        'Animals',
        'Simple Present',
        'Directions'
      ],
      'C': [
        'Past Activities',
        'Describing People',
        'Procedure Text',
        'Public Places',
        'Invitation'
      ],
    },
    'PJOK': {
      'A': [
        'Gerak Lokomotor',
        'Gerak Nonlokomotor',
        'Kebersihan Tubuh',
        'Permainan Sederhana',
        'Keselamatan Bermain'
      ],
      'B': [
        'Kebugaran Jasmani',
        'Senam Lantai',
        'Permainan Bola',
        'Pola Hidup Sehat',
        'Renang Dasar'
      ],
      'C': [
        'Atletik',
        'Strategi Permainan',
        'Kesehatan Reproduksi Dasar',
        'Cedera Ringan',
        'Sportivitas'
      ],
    },
    'SBDP': {
      'A': ['Garis dan Warna', 'Lagu Anak', 'Gerak Tari', 'Kolase', 'Irama'],
      'B': [
        'Ragam Hias',
        'Ansambel Sederhana',
        'Pola Lantai',
        'Kriya',
        'Apresiasi Karya'
      ],
      'C': [
        'Komposisi Rupa',
        'Tangga Nada',
        'Tari Nusantara',
        'Poster',
        'Pameran Karya'
      ],
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
    prompt =
        'Kelas $grade mengumpulkan $a buku dan mendapat tambahan $b buku. Berapa jumlah buku sekarang?';
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
    prompt =
        'Sebuah taman berbentuk persegi memiliki sisi $side meter. Berapa kelilingnya?';
  } else {
    final value = ((number % 9) + grade + 2) * 10;
    answer = value;
    prompt =
        'Nilai sedekah kelas ditulis ${value ~/ 10} puluhan rupiah. Berapa nilainya?';
  }

  final options = <int>{
    answer,
    answer + 2,
    max(0, answer - 2),
    answer + grade + 4
  }.toList();
  return (
    prompt: isEssay ? '$prompt Tuliskan angkanya saja.' : prompt,
    answer: '$answer',
    options: options.map((e) => '$e').toList(),
    explanation:
        'Jawabannya $answer. Pada materi $topic, hitung pelan-pelan dan teliti.',
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
  final items = _curriculumItems(subject, grade, topic);
  final item = items[number - 1];

  return (
    prompt: isEssay ? item.prompt.replaceAll('...', '.') : item.prompt,
    answer: item.answer,
    options: isEssay ? const [] : item.options,
    explanation: item.explanation,
    hint: item.hint,
  );
}

List<
    ({
      String prompt,
      String answer,
      List<String> options,
      String explanation,
      String hint,
    })> _curriculumItems(String subject, int grade, String topic) {
  const base = '';
  final data = <String,
      List<
          ({
            String prompt,
            String answer,
            List<String> options,
            String explanation,
            String hint
          })>>{
    'PAI': [
      _item(
          'Ibadah menahan lapar dan haus dari subuh sampai magrib disebut...',
          'puasa',
          ['puasa', 'zakat', 'haji', 'wudu'],
          'Puasa dilakukan dari subuh sampai magrib.',
          'Ingat ibadah Ramadan.'),
      _item(
          'Sikap terbaik saat berbeda pendapat adalah...',
          'bermusyawarah dengan santun',
          [
            'bermusyawarah dengan santun',
            'memaksakan pendapat',
            'mengejek teman',
            'pergi tanpa izin'
          ],
          'Musyawarah dilakukan dengan santun.',
          'Pilih akhlak yang baik.'),
      _item(
          'Bersuci sebelum salat dilakukan dengan...',
          'wudu',
          ['wudu', 'tidur', 'bermain', 'makan'],
          'Wudu adalah cara bersuci sebelum salat.',
          'Dilakukan sebelum salat.'),
      _item(
          'Percaya kepada Allah termasuk rukun...',
          'iman',
          ['iman', 'Islam', 'sekolah', 'olahraga'],
          'Rukun iman berkaitan dengan keyakinan.',
          'Keyakinan disebut iman.'),
      _item(
          'Berbicara sopan kepada orang tua termasuk akhlak...',
          'terpuji',
          ['terpuji', 'tercela', 'sombong', 'malas'],
          'Sopan kepada orang tua adalah akhlak terpuji.',
          'Pilih perilaku baik.'),
      _item(
          'Zakat mengajarkan umat Islam untuk...',
          'peduli kepada sesama',
          ['peduli kepada sesama', 'boros', 'sombong', 'malas belajar'],
          'Zakat melatih kepedulian.',
          'Berkaitan dengan berbagi.'),
      _item(
          'Ketika mendengar azan, sikap yang baik adalah...',
          'menjawab azan dan bersiap salat',
          [
            'menjawab azan dan bersiap salat',
            'berteriak',
            'berlari-lari',
            'mengabaikan'
          ],
          'Azan adalah panggilan salat.',
          'Ingat adab saat azan.'),
      _item(
          'Nabi Muhammad dikenal sebagai orang yang...',
          'jujur dan amanah',
          ['jujur dan amanah', 'pemarah', 'suka berbohong', 'sombong'],
          'Rasulullah memberi teladan jujur dan amanah.',
          'Teladan baik Rasul.'),
      _item(
          'Membaca basmalah dilakukan sebelum...',
          'memulai kegiatan baik',
          ['memulai kegiatan baik', 'berbuat buruk', 'tidur seharian', 'marah'],
          'Basmalah dibaca sebelum kegiatan baik.',
          'Awal kegiatan.'),
      _item(
          'Salat lima waktu hukumnya...',
          'wajib',
          ['wajib', 'mubah', 'makruh', 'haram'],
          'Salat lima waktu wajib bagi muslim.',
          'Ibadah pokok harian.'),
      _item(
          'Menolong teman yang kesulitan termasuk perilaku...',
          'taawun',
          ['taawun', 'hasad', 'takabur', 'dusta'],
          'Taawun berarti tolong-menolong.',
          'Arti tolong-menolong.'),
      _item(
          'Meminjam barang teman harus didahului dengan...',
          'izin',
          ['izin', 'paksaan', 'ejekan', 'marah'],
          'Meminjam barang perlu izin.',
          'Adab memakai milik orang lain.'),
      _item(
          'Allah Maha Melihat berarti Allah memiliki sifat...',
          'Al-Basir',
          ['Al-Basir', 'Al-Ghaffar', 'Al-Malik', 'Ar-Razzaq'],
          'Al-Basir berarti Maha Melihat.',
          'Ingat Asmaul Husna.'),
      _item(
          'Makanan halal adalah makanan yang...',
          'boleh dimakan menurut Islam',
          [
            'boleh dimakan menurut Islam',
            'selalu mahal',
            'selalu manis',
            'dilarang'
          ],
          'Halal berarti boleh menurut syariat.',
          'Lawan halal adalah haram.'),
      _item(
          'Jika berbuat salah kepada teman, sebaiknya...',
          'meminta maaf',
          [
            'meminta maaf',
            'menyalahkan orang lain',
            'mengejek',
            'diam selamanya'
          ],
          'Meminta maaf memperbaiki hubungan.',
          'Akhlak setelah salah.'),
      _item(
          'Rukun Islam yang pertama adalah...',
          'syahadat',
          ['syahadat', 'puasa', 'zakat', 'haji'],
          'Syahadat adalah rukun Islam pertama.',
          'Urutan pertama.'),
      _item(
          'Berdoa sebaiknya dilakukan dengan sikap...',
          'khusyuk',
          ['khusyuk', 'berteriak', 'bercanda', 'tergesa-gesa'],
          'Doa dilakukan dengan khusyuk.',
          'Sikap tenang.'),
      _item(
          'Puasa mengajarkan kita untuk menahan...',
          'hawa nafsu',
          ['hawa nafsu', 'ilmu', 'kebaikan', 'sedekah'],
          'Puasa melatih pengendalian diri.',
          'Selain lapar dan haus.'),
      _item(
          'Amanah berarti dapat...',
          'dipercaya',
          ['dipercaya', 'ditakuti', 'dibeli', 'dibuang'],
          'Amanah berarti dapat dipercaya.',
          'Sifat Nabi.'),
      _item(
          'Membersihkan tempat salat menunjukkan cinta kepada...',
          'kebersihan',
          ['kebersihan', 'kebisingan', 'kemalasan', 'kesombongan'],
          'Islam mengajarkan kebersihan.',
          'Lingkungan ibadah rapi.'),
      _item(
          'Sebelum makan, seorang muslim membaca...',
          'basmalah',
          ['basmalah', 'azan', 'iqamah', 'salam penutup'],
          'Basmalah dibaca sebelum makan.',
          'Bismillah.'),
      _item(
          'Orang yang sabar ketika diuji akan mendapat...',
          'pahala',
          ['pahala', 'dosa', 'ejekan', 'kerugian'],
          'Sabar adalah akhlak terpuji.',
          'Balasan kebaikan.'),
      _item(
          'Berterima kasih kepada orang lain termasuk sikap...',
          'syukur',
          ['syukur', 'iri', 'marah', 'bohong'],
          'Syukur tampak dari ucapan terima kasih.',
          'Menghargai kebaikan.'),
      _item(
          'Masjid adalah tempat untuk...',
          'beribadah',
          ['beribadah', 'berkelahi', 'membuang sampah', 'berdagang curang'],
          'Masjid digunakan untuk ibadah.',
          'Tempat salat berjamaah.'),
      _item(
          'Kisah para nabi memberi kita...',
          'teladan',
          ['teladan', 'mainan', 'makanan', 'hukuman'],
          'Kisah nabi berisi pelajaran dan teladan.',
          'Contoh perilaku baik.'),
      _item(
          'Tuliskan rukun Islam yang dilakukan saat Ramadan.',
          'puasa',
          ['puasa', 'wudu', 'azan', 'sedekah'],
          'Puasa adalah ibadah utama Ramadan.',
          'Jawaban singkat.'),
      _item(
          'Tuliskan sifat yang berarti dapat dipercaya.',
          'amanah',
          ['amanah', 'takabur', 'dusta', 'hasad'],
          'Amanah berarti dapat dipercaya.',
          'Sifat baik.'),
      _item(
          'Tuliskan ibadah wajib yang dikerjakan lima waktu.',
          'salat',
          ['salat', 'haji', 'zakat', 'puasa'],
          'Salat lima waktu wajib dikerjakan.',
          'Ibadah harian.'),
      _item(
          'Tuliskan ucapan yang dibaca sebelum kegiatan baik.',
          'basmalah',
          ['basmalah', 'iqamah', 'azan', 'tasbih'],
          'Basmalah dibaca sebelum kegiatan baik.',
          'Bismillah.'),
      _item(
          'Tuliskan sikap saat melakukan kesalahan kepada teman.',
          'meminta maaf',
          ['meminta maaf', 'mengejek', 'berbohong', 'marah'],
          'Jika salah, kita meminta maaf.',
          'Perbaiki hubungan.'),
    ],
    'QURAN': [
      _item(
          '$base Adab yang benar sebelum membaca Al-Qur\'an adalah...',
          'berwudu dan membaca dengan tartil',
          [
            'berwudu dan membaca dengan tartil',
            'membaca sambil berlari',
            'meletakkan mushaf sembarangan',
            'berbicara keras'
          ],
          'Membaca Al-Qur\'an dilakukan dengan suci, tenang, dan tartil.',
          'Ingat adab kepada kalam Allah.'),
      _item(
          '$base Membaca Al-Qur\'an dengan perlahan dan benar disebut...',
          'tartil',
          ['tartil', 'tergesa-gesa', 'diam', 'berteriak'],
          'Tartil berarti membaca dengan baik dan teratur.',
          'Cari cara membaca yang rapi.'),
      _item(
          '$base Surah pembuka dalam Al-Qur\'an adalah...',
          'Al-Fatihah',
          ['Al-Fatihah', 'An-Nas', 'Al-Falaq', 'Al-Kautsar'],
          'Al-Fatihah adalah surah pembuka.',
          'Surah ini dibaca dalam salat.'),
      _item(
          '$base Tempat keluarnya huruf hijaiyah disebut...',
          'makharijul huruf',
          ['makharijul huruf', 'harakat', 'waqaf', 'tajwid'],
          'Makharijul huruf membahas tempat keluarnya huruf.',
          'Ingat asal bunyi huruf.'),
      _item(
          '$base Mengulang hafalan Al-Qur\'an agar tidak lupa disebut...',
          'murajaah',
          ['murajaah', 'azan', 'iqamah', 'sedekah'],
          'Murajaah berarti mengulang hafalan.',
          'Kegiatan ini menjaga hafalan.'),
      _item('Tanda baca fathah menghasilkan bunyi...', 'a',
          ['a', 'i', 'u', 'e'], 'Fathah berbunyi a.', 'Harakat di atas huruf.'),
      _item(
          'Tanda baca kasrah menghasilkan bunyi...',
          'i',
          ['i', 'a', 'u', 'o'],
          'Kasrah berbunyi i.',
          'Harakat di bawah huruf.'),
      _item(
          'Tanda baca dhammah menghasilkan bunyi...',
          'u',
          ['u', 'a', 'i', 'e'],
          'Dhammah berbunyi u.',
          'Harakat seperti koma kecil.'),
      _item(
          'Berhenti sejenak saat membaca Al-Qur\'an disebut...',
          'waqaf',
          ['waqaf', 'mad', 'idgham', 'ikhfa'],
          'Waqaf berarti berhenti.',
          'Tanda berhenti.'),
      _item(
          'Bacaan panjang dalam tajwid disebut...',
          'mad',
          ['mad', 'waqaf', 'ghunnah', 'qalqalah'],
          'Mad adalah bacaan panjang.',
          'Panjang pendek bacaan.'),
    ],
    'ARB': [
      _item(
          '$base Arti kata "madrasah" adalah...',
          'sekolah',
          ['sekolah', 'pasar', 'rumah sakit', 'lapangan'],
          '"Madrasah" berarti sekolah.',
          'Tempat belajar.'),
      _item(
          '$base Kata sapaan bahasa Arab untuk selamat pagi adalah...',
          'shabahul khair',
          ['shabahul khair', 'lailatun sa\'idah', 'baitun', 'qalamun'],
          'Shabahul khair digunakan untuk sapaan pagi.',
          'Sapaan saat pagi.'),
      _item(
          '$base Arti kata "kitabun" adalah...',
          'buku',
          ['buku', 'meja', 'pintu', 'air'],
          'Kitabun berarti buku.',
          'Benda untuk membaca.'),
      _item(
          '$base Bahasa Arab dari ayah adalah...',
          'abun',
          ['abun', 'ummun', 'akhun', 'bintun'],
          'Abun berarti ayah.',
          'Anggota keluarga laki-laki orang tua.'),
      _item(
          '$base Arti warna "ahmar" adalah...',
          'merah',
          ['merah', 'biru', 'kuning', 'hijau'],
          'Ahmar berarti merah.',
          'Salah satu warna primer.'),
      _item(
          'Arti kata "ummun" adalah...',
          'ibu',
          ['ibu', 'ayah', 'adik', 'guru'],
          'Ummun berarti ibu.',
          'Anggota keluarga.'),
      _item(
          'Arti kata "qalamun" adalah...',
          'pena',
          ['pena', 'kursi', 'rumah', 'pintu'],
          'Qalamun berarti pena.',
          'Alat tulis.'),
      _item(
          'Bahasa Arab dari satu adalah...',
          'wahidun',
          ['wahidun', 'itsnani', 'tsalatsah', 'arbaah'],
          'Wahidun berarti satu.',
          'Angka pertama.'),
      _item(
          'Arti kata "baitun" adalah...',
          'rumah',
          ['rumah', 'sekolah', 'pasar', 'jalan'],
          'Baitun berarti rumah.',
          'Tempat tinggal.'),
      _item(
          'Arti warna "abyadh" adalah...',
          'putih',
          ['putih', 'hitam', 'merah', 'kuning'],
          'Abyadh berarti putih.',
          'Nama warna.'),
    ],
    'BIND': [
      _item(
          '$base Kalimat yang memakai tanda titik dengan benar adalah...',
          'Ali membaca buku di perpustakaan.',
          [
            'Ali membaca buku di perpustakaan.',
            'Ali membaca buku di perpustakaan?',
            'Ali membaca buku di perpustakaan!',
            'ali membaca buku di perpustakaan'
          ],
          'Kalimat berita diakhiri titik dan diawali huruf kapital.',
          'Cari kalimat berita yang rapi.'),
      _item(
          '$base Huruf kapital dipakai pada awal...',
          'kalimat',
          ['kalimat', 'tanda koma', 'spasi', 'titik'],
          'Awal kalimat ditulis dengan huruf kapital.',
          'Lihat huruf pertama.'),
      _item(
          '$base Ide pokok adalah gagasan...',
          'utama',
          ['utama', 'tambahan', 'lucu', 'terakhir'],
          'Ide pokok adalah gagasan utama paragraf.',
          'Cari gagasan paling penting.'),
      _item(
          '$base Tanda tanya digunakan untuk kalimat...',
          'tanya',
          ['tanya', 'berita', 'perintah biasa', 'sapaan'],
          'Kalimat tanya diakhiri tanda tanya.',
          'Kalimat yang meminta jawaban.'),
      _item(
          '$base Cerita pengalaman biasanya menceritakan kejadian yang...',
          'pernah dialami',
          [
            'pernah dialami',
            'tidak masuk akal',
            'selalu masa depan',
            'tanpa tokoh'
          ],
          'Pengalaman adalah kejadian yang pernah dialami.',
          'Ingat peristiwa pribadi.'),
      _item(
          'Kalimat perintah biasanya diakhiri tanda...',
          'seru',
          ['seru', 'koma', 'petik', 'kurung'],
          'Kalimat perintah dapat diakhiri tanda seru.',
          'Tanda untuk perintah kuat.'),
      _item(
          'Tokoh dalam cerita adalah...',
          'pelaku cerita',
          ['pelaku cerita', 'judul buku', 'tanda baca', 'tempat duduk'],
          'Tokoh adalah pelaku dalam cerita.',
          'Siapa yang berbuat.'),
      _item(
          'Paragraf tersusun dari beberapa...',
          'kalimat',
          ['kalimat', 'huruf kapital saja', 'gambar', 'angka'],
          'Paragraf terdiri dari kalimat-kalimat.',
          'Bagian bacaan.'),
      _item(
          'Lawan kata "besar" adalah...',
          'kecil',
          ['kecil', 'tinggi', 'panjang', 'ramai'],
          'Antonim besar adalah kecil.',
          'Kata berlawanan.'),
      _item(
          'Judul bacaan sebaiknya sesuai dengan...',
          'isi bacaan',
          ['isi bacaan', 'warna sampul', 'jumlah halaman', 'nama pembaca'],
          'Judul menggambarkan isi bacaan.',
          'Inti bacaan.'),
    ],
    'IPAS': [
      _item(
          '$base Contoh menjaga lingkungan sekolah adalah...',
          'membuang sampah pada tempatnya',
          [
            'membuang sampah pada tempatnya',
            'memetik tanaman sembarangan',
            'membiarkan keran terbuka',
            'mencoret meja'
          ],
          'Lingkungan bersih membantu makhluk hidup tetap sehat.',
          'Pilih tindakan bersih.'),
      _item(
          '$base Bagian tumbuhan yang menyerap air adalah...',
          'akar',
          ['akar', 'daun', 'bunga', 'buah'],
          'Akar menyerap air dari tanah.',
          'Bagian yang berada di tanah.'),
      _item(
          '$base Hewan yang berkembang biak dengan bertelur disebut...',
          'ovipar',
          ['ovipar', 'vivipar', 'mamalia', 'amfibi'],
          'Ovipar adalah hewan bertelur.',
          'Contohnya ayam.'),
      _item(
          '$base Matahari merupakan sumber...',
          'energi panas dan cahaya',
          ['energi panas dan cahaya', 'air hujan', 'tanah', 'suara'],
          'Matahari memberi panas dan cahaya.',
          'Terasa hangat dan terang.'),
      _item(
          '$base Air dapat berubah menjadi es jika...',
          'didinginkan',
          ['didinginkan', 'dipanaskan terus', 'diberi gula', 'diaduk'],
          'Air membeku menjadi es saat didinginkan.',
          'Suhu menjadi rendah.'),
      _item(
          'Bagian tubuh untuk melihat adalah...',
          'mata',
          ['mata', 'telinga', 'hidung', 'kaki'],
          'Mata digunakan untuk melihat.',
          'Indra penglihatan.'),
      _item(
          'Bagian tubuh untuk mendengar adalah...',
          'telinga',
          ['telinga', 'mata', 'lidah', 'tangan'],
          'Telinga digunakan untuk mendengar.',
          'Indra pendengaran.'),
      _item(
          'Tumbuhan membutuhkan air dan...',
          'cahaya matahari',
          ['cahaya matahari', 'plastik', 'batu', 'asap'],
          'Tumbuhan memerlukan air dan cahaya.',
          'Syarat tumbuh.'),
      _item(
          'Hewan pemakan tumbuhan disebut...',
          'herbivor',
          ['herbivor', 'karnivor', 'omnivor', 'ovipar'],
          'Herbivor memakan tumbuhan.',
          'Contohnya kambing.'),
      _item(
          'Lingkungan sehat biasanya memiliki udara yang...',
          'bersih',
          ['bersih', 'berasap', 'bau', 'gelap'],
          'Udara bersih baik untuk kesehatan.',
          'Ciri lingkungan sehat.'),
    ],
    'PPKN': [
      _item(
          '$base Contoh gotong royong adalah...',
          'membersihkan kelas bersama-sama',
          [
            'membersihkan kelas bersama-sama',
            'menolak membantu teman',
            'mengambil hak orang lain',
            'bertengkar'
          ],
          'Gotong royong berarti bekerja sama.',
          'Dilakukan bersama.'),
      _item(
          '$base Lambang sila pertama Pancasila adalah...',
          'bintang',
          ['bintang', 'rantai', 'pohon beringin', 'padi dan kapas'],
          'Sila pertama dilambangkan bintang.',
          'Lambang Ketuhanan Yang Maha Esa.'),
      _item(
          '$base Aturan sekolah harus...',
          'ditaati',
          ['ditaati', 'dilanggar', 'diabaikan', 'disembunyikan'],
          'Aturan dibuat untuk ketertiban bersama.',
          'Perilaku murid baik.'),
      _item(
          '$base Hak anak di sekolah adalah mendapat...',
          'pelajaran',
          [
            'pelajaran',
            'hukuman tanpa sebab',
            'pekerjaan orang dewasa',
            'larangan belajar'
          ],
          'Mendapat pelajaran adalah hak siswa.',
          'Sesuatu yang diterima siswa.'),
      _item(
          '$base Keputusan bersama sebaiknya diambil dengan...',
          'musyawarah',
          ['musyawarah', 'marah-marah', 'paksaan', 'diam saja'],
          'Musyawarah membantu mencapai mufakat.',
          'Diskusi dengan santun.'),
      _item(
          'Kewajiban siswa saat piket adalah...',
          'membersihkan kelas',
          [
            'membersihkan kelas',
            'membuang sampah sembarangan',
            'pulang diam-diam',
            'mengganggu teman'
          ],
          'Piket adalah kewajiban menjaga kelas.',
          'Tugas kebersihan.'),
      _item(
          'Sila kedua Pancasila dilambangkan dengan...',
          'rantai',
          ['rantai', 'bintang', 'kepala banteng', 'pohon beringin'],
          'Sila kedua dilambangkan rantai.',
          'Kemanusiaan yang adil dan beradab.'),
      _item(
          'Menerima teman yang berbeda suku menunjukkan sikap...',
          'toleransi',
          ['toleransi', 'permusuhan', 'paksaan', 'iri hati'],
          'Toleransi menghargai perbedaan.',
          'Sikap menghargai.'),
      _item(
          'Sebelum memakai barang milik teman, kita harus...',
          'meminta izin',
          ['meminta izin', 'mengambil diam-diam', 'menyembunyikan', 'merusak'],
          'Meminta izin menghargai hak teman.',
          'Adab memakai barang.'),
      _item(
          'Hasil musyawarah sebaiknya...',
          'dilaksanakan bersama',
          ['dilaksanakan bersama', 'diabaikan', 'ditertawakan', 'dirahasiakan'],
          'Keputusan bersama perlu dilaksanakan.',
          'Tanggung jawab bersama.'),
    ],
    'BIG': [
      _item(
          '$base The correct response to "Good morning" is...',
          'Good morning',
          ['Good morning', 'Good night', 'I am pencil', 'No, red'],
          'Greeting dijawab dengan sapaan yang sesuai.',
          'Morning dijawab morning.'),
      _item(
          '$base The English word for "buku" is...',
          'book',
          ['book', 'chair', 'door', 'fish'],
          'Book berarti buku.',
          'Object for reading.'),
      _item(
          '$base The color of grass is usually...',
          'green',
          ['green', 'red', 'black', 'white'],
          'Grass is usually green.',
          'Look at plants.'),
      _item(
          '$base "One, two, three" means...',
          'satu, dua, tiga',
          [
            'satu, dua, tiga',
            'empat, lima, enam',
            'merah, biru, hijau',
            'ayah, ibu, kakak'
          ],
          'One, two, three adalah angka 1, 2, 3.',
          'Numbers.'),
      _item(
          '$base "Mother" in Indonesian means...',
          'ibu',
          ['ibu', 'ayah', 'adik', 'guru'],
          'Mother berarti ibu.',
          'Female parent.'),
      _item(
          'The English word for "pintu" is...',
          'door',
          ['door', 'book', 'chair', 'fish'],
          'Door berarti pintu.',
          'Classroom object.'),
      _item(
          'The English word for "ayah" is...',
          'father',
          ['father', 'mother', 'sister', 'teacher'],
          'Father berarti ayah.',
          'Family member.'),
      _item(
          '"Thank you" is used to say...',
          'terima kasih',
          ['terima kasih', 'selamat tidur', 'maaf', 'sampai jumpa'],
          'Thank you berarti terima kasih.',
          'Expression of gratitude.'),
      _item(
          'The opposite of "big" is...',
          'small',
          ['small', 'long', 'green', 'happy'],
          'Small adalah lawan kata big.',
          'Opposite word.'),
      _item(
          'A place to study is a...',
          'school',
          ['school', 'market', 'kitchen', 'garden'],
          'School adalah tempat belajar.',
          'Students study there.'),
    ],
    'PJOK': [
      _item(
          '$base Kebiasaan sehat setelah olahraga adalah...',
          'minum air dan membersihkan badan',
          [
            'minum air dan membersihkan badan',
            'langsung tidur tanpa ganti baju',
            'makan berlebihan',
            'berlari di lantai licin'
          ],
          'Tubuh perlu cairan dan kebersihan setelah bergerak.',
          'Pilih kebiasaan sehat.'),
      _item(
          '$base Gerak berpindah tempat disebut gerak...',
          'lokomotor',
          ['lokomotor', 'diam', 'pasif', 'istirahat'],
          'Lokomotor adalah gerak berpindah tempat.',
          'Contohnya berjalan.'),
      _item(
          '$base Pemanasan dilakukan sebelum olahraga untuk...',
          'mengurangi risiko cedera',
          [
            'mengurangi risiko cedera',
            'membuat lapar',
            'mengotori baju',
            'mengantuk'
          ],
          'Pemanasan menyiapkan tubuh.',
          'Agar tubuh siap bergerak.'),
      _item(
          '$base Contoh alat permainan bola adalah...',
          'bola',
          ['bola', 'pensil', 'sendok', 'bantal'],
          'Bola digunakan dalam permainan bola.',
          'Benda bulat.'),
      _item(
          '$base Sikap sportif berarti mau menerima...',
          'hasil pertandingan',
          ['hasil pertandingan', 'kecurangan', 'ejekan', 'permusuhan'],
          'Sportif berarti jujur dan menerima hasil.',
          'Sikap baik saat bermain.'),
      _item(
          'Gerak melompat termasuk gerak...',
          'lokomotor',
          ['lokomotor', 'diam', 'tidur', 'pasif'],
          'Melompat membuat tubuh berpindah tempat.',
          'Gerak berpindah.'),
      _item(
          'Minum air setelah olahraga membantu mencegah...',
          'dehidrasi',
          ['dehidrasi', 'kebisingan', 'kemalasan', 'kedinginan'],
          'Air mengganti cairan tubuh.',
          'Kekurangan cairan.'),
      _item(
          'Permainan harus dilakukan dengan sikap...',
          'jujur',
          ['jujur', 'curang', 'marah', 'mengejek'],
          'Jujur adalah sikap sportif.',
          'Tidak curang.'),
      _item(
          'Gerakan menekuk lutut termasuk gerak...',
          'nonlokomotor',
          ['nonlokomotor', 'lokomotor', 'lari cepat', 'renang'],
          'Menekuk lutut tidak berpindah tempat.',
          'Gerak di tempat.'),
      _item(
          'Sebelum memakai alat olahraga, kita harus mengecek...',
          'keamanannya',
          ['keamanannya', 'warnanya saja', 'harganya', 'mereknya'],
          'Keamanan alat mencegah cedera.',
          'Agar tidak celaka.'),
    ],
    'SBDP': [
      _item(
          '$base Warna primer terdiri dari...',
          'merah, kuning, dan biru',
          [
            'merah, kuning, dan biru',
            'hijau, ungu, dan jingga',
            'hitam, putih, dan abu-abu',
            'cokelat, emas, dan perak'
          ],
          'Merah, kuning, dan biru adalah warna dasar.',
          'Warna dasar.'),
      _item(
          '$base Pola bunyi teratur dalam musik disebut...',
          'irama',
          ['irama', 'warna', 'garis', 'patung'],
          'Irama adalah pola bunyi yang teratur.',
          'Ada dalam lagu.'),
      _item(
          '$base Karya seni dari potongan kertas yang ditempel disebut...',
          'kolase',
          ['kolase', 'lagu', 'pantun', 'dialog'],
          'Kolase dibuat dari bahan yang ditempel.',
          'Menempel potongan bahan.'),
      _item(
          '$base Unsur rupa yang berbentuk goresan disebut...',
          'garis',
          ['garis', 'nada', 'gerak', 'suara'],
          'Garis adalah goresan dalam seni rupa.',
          'Bisa lurus atau lengkung.'),
      _item(
          '$base Gerakan indah mengikuti irama disebut...',
          'tari',
          ['tari', 'lukis', 'patung', 'membaca'],
          'Tari menggabungkan gerak dan irama.',
          'Dilakukan dengan tubuh.'),
      _item(
          'Warna hijau dapat dibuat dari campuran...',
          'biru dan kuning',
          [
            'biru dan kuning',
            'merah dan putih',
            'hitam dan merah',
            'ungu dan jingga'
          ],
          'Biru dan kuning menghasilkan hijau.',
          'Campuran warna.'),
      _item(
          'Tinggi rendah bunyi dalam lagu disebut...',
          'nada',
          ['nada', 'garis', 'warna', 'tekstur'],
          'Nada adalah tinggi rendah bunyi.',
          'Unsur musik.'),
      _item(
          'Pola lantai digunakan dalam seni...',
          'tari',
          ['tari', 'patung', 'lukis', 'anyaman'],
          'Pola lantai mengatur posisi penari.',
          'Gerak di ruang.'),
      _item(
          'Karya dua dimensi memiliki panjang dan...',
          'lebar',
          ['lebar', 'volume', 'berat', 'rasa'],
          'Dua dimensi memiliki panjang dan lebar.',
          'Bidang datar.'),
      _item(
          'Poster biasanya berisi gambar dan...',
          'pesan',
          ['pesan', 'rasa', 'harga rahasia', 'suara'],
          'Poster menyampaikan pesan.',
          'Media informasi visual.'),
    ],
  };

  final items = data[subject]!;
  if (items.length >= 30) return items;

  return _expandItems(items);
}

List<
    ({
      String prompt,
      String answer,
      List<String> options,
      String explanation,
      String hint,
    })> _expandItems(
  List<
          ({
            String prompt,
            String answer,
            List<String> options,
            String explanation,
            String hint
          })>
      items,
) {
  return [
    for (var cycle = 0; cycle < 6; cycle++)
      for (final item in items)
        _item(
          _promptVariant(item.prompt, cycle),
          item.answer,
          item.options,
          item.explanation,
          item.hint,
        ),
  ];
}

String _promptVariant(String prompt, int cycle) {
  final clean = prompt.trim();
  if (cycle == 0) return clean;
  if (cycle == 1) {
    final changed = clean
        .replaceFirst('adalah...', 'yang tepat adalah...')
        .replaceFirst('disebut...', 'disebut dengan...');
    return changed == clean
        ? '${clean.replaceAll('...', '')} yang tepat adalah...'
        : changed;
  }
  if (cycle == 2) {
    final changed = clean
        .replaceFirst('adalah...', 'yaitu...')
        .replaceFirst('disebut...', 'dikenal sebagai...');
    return changed == clean
        ? '${clean.replaceAll('...', '')} yaitu...'
        : changed;
  }
  if (cycle == 3) {
    final changed = clean
        .replaceFirst('adalah...', 'adalah apa?')
        .replaceFirst('disebut...', 'disebut apa?');
    return changed == clean
        ? '${clean.replaceAll('...', '')} jawabannya...'
        : changed;
  }
  if (cycle == 4) {
    final changed = clean
        .replaceFirst('adalah...', 'yang paling sesuai adalah...')
        .replaceFirst('disebut...', 'memiliki istilah...');
    return changed == clean
        ? '${clean.replaceAll('...', '')} pilihan yang sesuai...'
        : changed;
  }
  final changed = clean
      .replaceFirst('adalah...', 'dapat dijawab dengan...')
      .replaceFirst('disebut...', 'dapat disebut...');
  return changed == clean
      ? '${clean.replaceAll('...', '')} jawab singkat...'
      : changed;
}

({
  String prompt,
  String answer,
  List<String> options,
  String explanation,
  String hint
}) _item(
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
