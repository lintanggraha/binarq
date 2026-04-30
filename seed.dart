import 'dart:convert';
import 'dart:io';
import 'package:supabase/supabase.dart';

void main() async {
  print('⏳ Menyambungkan ke Supabase...');
  final supabase = SupabaseClient(
    'https://zohccxhlueafwpmvhasn.supabase.co',
    'sb_publishable_U9IG5DbHLbJ9NEyhx7KS3Q_dJdTcnrB',
  );

  final file = File('bank_soal.json');
  if (!file.existsSync()) {
    print('❌ File bank_soal.json tidak ditemukan!');
    exit(1);
  }

  final content = await file.readAsString();
  final List<dynamic> questions = jsonDecode(content);

  print('🚀 Memulai proses upload ${questions.length} soal...');

  for (var q in questions) {
    try {
      // Menggunakan upsert agar jika id sudah ada, dia akan mereplace (update)
      await supabase.from('questions').upsert({
        'id': q['id'],
        'data_json': q,
      });
      print('✅ Berhasil upload: ${q["id"]}');
    } catch (e) {
      print('❌ Gagal upload ${q["id"]}: $e');
    }
  }
  
  print('🎉 Semua soal berhasil diupload ke Supabase Cloud!');
  exit(0);
}
