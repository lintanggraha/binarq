import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('bank_soal.json');
  final json = jsonDecode(file.readAsStringSync()) as List;
  
  print('Total questions before: ${json.length}');
  
  final originalLength = json.length;
  
  // Scrubbing logic:
  // Remove questions from Kelas 1 or 2 that mention "keliling" or "luas" in question text or topic.
  json.removeWhere((q) {
    final kelas = q['metadata']['kelas'];
    if (kelas == 1 || kelas == 2) {
      final text = q['content']['pertanyaan'].toString().toLowerCase();
      final topik = q['metadata']['topik'].toString().toLowerCase();
      final match = text.contains('keliling') || text.contains('luas') || 
                    topik.contains('keliling') || topik.contains('luas');
      if (match) {
        print('Scrubbing ID: ${q['id']} (Kelas $kelas) - Q: ${q['content']['pertanyaan']}');
        return true;
      }
    }
    return false;
  });
  
  print('Total questions after: ${json.length}');
  print('Removed ${originalLength - json.length} questions.');
  
  file.writeAsStringSync(jsonEncode(json));
  print('✅ Cleaned bank_soal.json saved.');
}
