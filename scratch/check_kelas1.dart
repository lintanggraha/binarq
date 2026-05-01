import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('bank_soal.json');
  final json = jsonDecode(file.readAsStringSync()) as List;
  
  print('Total questions: ${json.length}');
  
  final kelas1Questions = json.where((q) => q['metadata']['kelas'] == 1).toList();
  print('Kelas 1 questions: ${kelas1Questions.length}');
  
  final suspicious = kelas1Questions.where((q) {
    final text = q['content']['pertanyaan'].toString().toLowerCase();
    final topik = q['metadata']['topik'].toString().toLowerCase();
    return text.contains('keliling') || text.contains('luas') || 
           topik.contains('keliling') || topik.contains('luas');
  }).toList();
  
  if (suspicious.isEmpty) {
    print('✅ No "Keliling" or "Luas" found in Kelas 1 JSON.');
  } else {
    print('❌ FOUND ${suspicious.length} suspicious questions in Kelas 1:');
    for (var q in suspicious) {
      print('ID: ${q['id']} | Topik: ${q['metadata']['topik']} | Q: ${q['content']['pertanyaan']}');
    }
  }
}
