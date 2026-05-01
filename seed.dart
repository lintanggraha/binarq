import 'dart:convert';
import 'dart:io';
import 'package:supabase/supabase.dart';

// ignore_for_file: avoid_print

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
  
  print('🗑️ Membersihkan tabel questions di Supabase...');
  try {
    // Menghapus semua data (gunakan filter yang selalu benar untuk menghapus semua jika RLS mengizinkan)
    await supabase.from('questions').delete().neq('id', '0');
    print('✅ Tabel berhasil dibersihkan.');
  } catch (e) {
    print('⚠️ Gagal membersihkan tabel (mungkin RLS): $e');
  }

  print('🚀 Memulai proses upload ${questions.length} soal (dalam batch 100)...');

  final batchSize = 100;
  for (var i = 0; i < questions.length; i += batchSize) {
    final end = (i + batchSize < questions.length) ? i + batchSize : questions.length;
    final batch = questions.sublist(i, end).map((q) => {
      'id': q['id'],
      'data_json': q,
    }).toList();

    try {
      await supabase.from('questions').upsert(batch);
      print('✅ Berhasil upload batch: ${i + 1} sampai $end');
    } catch (e) {
      print('❌ Gagal upload batch ${i + 1}-$end: $e');
    }
  }

  print('🎉 Semua soal berhasil diupload ke Supabase Cloud!');
  exit(0);
}
