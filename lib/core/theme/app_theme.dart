import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      
      // Typography
      textTheme: TextTheme(
        // Judul pakai Fredoka One
        displayLarge: GoogleFonts.fredoka(color: AppColors.textDark),
        displayMedium: GoogleFonts.fredoka(color: AppColors.textDark),
        headlineLarge: GoogleFonts.fredoka(color: AppColors.textDark),
        titleLarge: GoogleFonts.fredoka(color: AppColors.textDark, fontSize: 22),
        titleMedium: GoogleFonts.fredoka(color: AppColors.textDark, fontSize: 18),
        
        // Body teks (Soal) pakai Nunito
        bodyLarge: GoogleFonts.nunito(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.w600),
        bodyMedium: GoogleFonts.nunito(color: AppColors.textDark, fontSize: 16),
        bodySmall: GoogleFonts.nunito(color: AppColors.textLight, fontSize: 14),
      ),
      
      // ElevatedButton (Tombol Gemoy)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.fredoka(fontSize: 18, letterSpacing: 1),
        ),
      ),
    );
  }
}
