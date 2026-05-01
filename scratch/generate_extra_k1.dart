import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  final file = File('bank_soal.json');
  final json = jsonDecode(file.readAsStringSync()) as List;

  final random = Random();
  final extraK1MTK = <Map<String, dynamic>>[];

  final items = ["permen", "pensil", "penghapus", "bola", "kelereng", "pisang", "donat", "ikan", "burung", "buku doa"];
  final names = ["Ali", "Ahmad", "Fatimah", "Zaid", "Maryam", "Umar", "Aisyah", "Hassan"];

  // Generate 100 varied addition/subtraction questions
  for (var i = 0; i < 100; i++) {
    final name = names[random.nextInt(names.length)];
    final item = items[random.nextInt(items.length)];
    final isAddition = random.nextBool();
    
    int n1, n2, result;
    String qText, ans;
    List<String> opts;

    if (isAddition) {
      n1 = random.nextInt(10) + 1; // 1-10
      n2 = random.nextInt(9) + 1;  // 1-9
      result = n1 + n2;
      qText = "$name memiliki $n1 $item. Lalu ia membeli lagi $n2 $item. Berapa jumlah $item $name sekarang?";
      ans = result.toString();
    } else {
      n1 = random.nextInt(10) + 11; // 11-20
      n2 = random.nextInt(10) + 1;  // 1-10
      result = n1 - n2;
      qText = "Di dalam tas ada $n1 $item. $name mengambil $n2 $item untuk diberikan ke teman. Berapa $item yang tersisa di tas?";
      ans = result.toString();
    }

    // Create unique options
    final optSet = {ans};
    while (optSet.length < 3) {
      final fake = (result + random.nextInt(5) - 2).clamp(0, 40).toString();
      optSet.add(fake);
    }
    opts = optSet.toList()..shuffle();
    final ansChar = String.fromCharCode(65 + opts.indexOf(ans));

    extraK1MTK.add({
      "id": "MTK-K1-VAR-${i.toString().padLeft(3, '0')}",
      "metadata": {
        "kelas": 1,
        "fase": "A",
        "mapel": "MTK",
        "topik": isAddition ? "Penjumlahan" : "Pengurangan",
        "kategori_ujian": "Sumatif Akhir Semester",
        "tingkat_kesulitan": "sedang",
        "xp_reward": 10,
        "konteks_islami": true,
        "tag_nilai_islam": ["berbagi", "ilmu"]
      },
      "content": {
        "tipe_soal": "pilihan_ganda",
        "pertanyaan": qText,
        "pilihan": [
          {"id_pilihan": "A", "teks": opts[0]},
          {"id_pilihan": "B", "teks": opts[1]},
          {"id_pilihan": "C", "teks": opts[2]}
        ],
        "jawaban_benar": ansChar
      },
      "feedback": {
        "penjelasan_anak": "Hasil dari hitunganmu adalah $result. Hebat!",
        "hint": "Coba hitung pakai jari ya!"
      }
    });
  }

  json.addAll(extraK1MTK);
  file.writeAsStringSync(jsonEncode(json));
  print('✅ Successfully added 100 extra varied K1 MTK questions.');
}
