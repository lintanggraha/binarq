import 'package:isar/isar.dart';

part 'question.g.dart';

@collection
class Question {
  Id id = Isar.autoIncrement;

  late String questionId; // ID unik (misal: MTK-K1-A-0001)

  late Metadata metadata;
  late Content content;
  late FeedbackInfo feedback; // Nama kelas diubah karena Feedback tabrakan dengan Flutter

  Question();

  // Factory dari JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    final q = Question()
      ..questionId = json['id']
      ..metadata = Metadata.fromJson(json['metadata'])
      ..content = Content.fromJson(json['content'])
      ..feedback = FeedbackInfo.fromJson(json['feedback']);
    return q;
  }
}

@embedded
class Metadata {
  int? kelas;
  String? fase;
  String? mapel;
  String? topik;
  String? kategoriUjian;
  String? tingkatKesulitan;
  int? xpReward;
  bool? konteksIslami;
  List<String>? tagNilaiIslam;

  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata()
      ..kelas = json['kelas']
      ..fase = json['fase']
      ..mapel = json['mapel']
      ..topik = json['topik']
      ..kategoriUjian = json['kategori_ujian']
      ..tingkatKesulitan = json['tingkat_kesulitan']
      ..xpReward = json['xp_reward']
      ..konteksIslami = json['konteks_islami']
      ..tagNilaiIslam = List<String>.from(json['tag_nilai_islam'] ?? []);
  }
}

@embedded
class Content {
  String? tipeSoal;
  String? pertanyaan;
  List<Option>? pilihan;
  String? jawabanBenar;

  Content();

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content()
      ..tipeSoal = json['tipe_soal']
      ..pertanyaan = json['pertanyaan']
      ..pilihan = (json['pilihan'] as List?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList()
      ..jawabanBenar = json['jawaban_benar'];
  }
}

@embedded
class Option {
  String? idPilihan;
  String? teks;

  Option();

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option()
      ..idPilihan = json['id_pilihan']
      ..teks = json['teks'];
  }
}

@embedded
class FeedbackInfo {
  String? penjelasanAnak;
  String? hint;

  FeedbackInfo();

  factory FeedbackInfo.fromJson(Map<String, dynamic> json) {
    return FeedbackInfo()
      ..penjelasanAnak = json['penjelasan_anak']
      ..hint = json['hint'];
  }
}
