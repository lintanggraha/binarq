import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('bank_soal.json');
  final json = jsonDecode(file.readAsStringSync()) as List;
  
  final k1mtk = json.where((q) => q['metadata']['kelas'] == 1 && q['metadata']['mapel'] == 'MTK').toList();
  print('Total K1 MTK questions: ${k1mtk.length}');
  
  final topics = k1mtk.map((q) => q['metadata']['topik']).toSet();
  print('Topics in K1 MTK: $topics');
  
  final questionTexts = k1mtk.map((q) => q['content']['pertanyaan']).toList();
  final uniqueQuestions = questionTexts.toSet();
  print('Unique question texts: ${uniqueQuestions.length}');
  
  print('\n--- Sample of 20 questions ---');
  for (var i = 0; i < (k1mtk.length > 20 ? 20 : k1mtk.length); i++) {
    print('${i+1}. ${k1mtk[i]['content']['pertanyaan']}');
  }
}
