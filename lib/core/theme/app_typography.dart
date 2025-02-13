import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTypography {
  // Display Styles (for very large titles or banners)
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    color: AppColors.white,
  );

  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    color: AppColors.white,
  );

  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    color: AppColors.white,
  );

  // Headline Styles (for large headers or titles)
  static TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    color: AppColors.white,
  );

  static TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    color: AppColors.white,
  );

  static TextStyle headlineSmall = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    color: AppColors.white,
  );

  // Title Styles (for medium emphasis text)
  static TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    color: AppColors.white,
  );

  static TextStyle titleMedium = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    color: AppColors.textPrimary,
  );

  static TextStyle titleSmall = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    color: AppColors.white,
  );

  // Body Text Styles (for paragraphs and longer text)
  static TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.white,
  );

  static TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.white,
  );

  // Label Styles (for buttons or small elements)
  static TextStyle labelLarge = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.white,
  );

  static TextStyle labelMedium = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.white,
  );

  static TextStyle labelSmall = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: AppColors.white,
  );
}

// displayLarge	Very large, prominent text	App title on a splash screen
// displayMedium	Large headlines	Section headings or major content
// displaySmall	Sub-headlines or secondary titles	Section subheaders
// headlineLarge	Major section headings	Major section titles like “Trending”
// headlineMedium	Medium-sized section headers	Secondary section titles
// headlineSmall	Small section or subsection headers	Subsection titles
// titleLarge	Large item titles	Product or card titles
// titleMedium	Medium-sized item titles	Subtitles or less prominent titles
// titleSmall	Small item titles	Secondary or supplementary titles
// bodyLarge	Main body text	Articles, large paragraph text
// bodyMedium	Regular body text	General content, lists
// bodySmall	Small body text	Captions, footnotes
// labelLarge	Large labels	Button text, tags
// labelMedium	Medium-sized labels	Secondary buttons, small tags
// labelSmall	Small labels	Status tags, input field labels
