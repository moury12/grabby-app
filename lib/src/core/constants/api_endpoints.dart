class ApiEndpoints {
  ApiEndpoints._(); // prevent instantiation

  // ─── Base URL ──────────────────────────────────────────────────────────────
  // Swap this based on environment (dev / staging / prod)
  static const String baseUrl = "http://10.10.20.50:5001";

  // ─── Auth ──────────────────────────────────────────────────────────────────
  static const String customerRegister = "/auth/customer/register";
  static const String customerLogin = "/auth/login";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resendOtp = "/auth/resend-otp";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resendForgotCode = "/auth/resend-forgot-code";
  static const String verifyForgotOtp = "/auth/verify-forgot-otp";
  static const String resetPassword = "/auth/reset-password";
  static const String changePassword = "/auth/change-password";
  static const String logout = "/auth/customer/logout";

  // ─── Profile ───────────────────────────────────────────────────────────────
  static const String profile = "/auth/profile";
  static const String updateProfile = "/customers/profile";
  static const String updateUserLocation = "/customers/location";
}
