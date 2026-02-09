import '../../src_export.dart';

class AppTheme {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Main Colors
      primaryColor: AppColors.kPrimaryColor,
      scaffoldBackgroundColor: AppColors.kBackgroundColor,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.kPrimaryColor,
        secondary: AppColors.kSecondaryColor,
        surface: AppColors.kBackgroundColor,
        error: AppColors.kRedColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.kTextColor,
        onError: Colors.white,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.kTextColor),
        titleTextStyle: TextStyle(
          color: AppColors.kTextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Text Theme (Applies the text color globally)
      textTheme: TextTheme(
        // Responsive text styles
        headlineLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeLarge(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.bold,
          color: AppColors.kTextColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeDefault(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w500,
          color: AppColors.kTextColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeSmall(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w400,
          color: AppColors.kTextColor,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeLarge(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.bold,
          color: AppColors.kTextColor,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeDefault(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w600,
          color: AppColors.kTextColor,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeSmall(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w400,
          color: AppColors.kTextColor,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeDefault(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w500,
          color: AppColors.kTextColor,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeSemiSmall(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w400,
          color: AppColors.kTextColor,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeSmall(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w400,
          color: AppColors.kTextColor,
        ),
        displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeOverLarge(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.bold,
          color: AppColors.kTextColor,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeLarge(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w700,
          color: AppColors.kTextColor,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ResponsiveTextSizes.getFontSizeSemiSmall(
            context,
          ), // Responsive font size
          fontWeight: FontWeight.w600,
          color: AppColors.kTextColor,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.kTextColor),
    );
  }
}
