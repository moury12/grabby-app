class ApiEndpoints {
  ApiEndpoints._(); // prevent instantiation

  // ─── Base URL ──────────────────────────────────────────────────────────────
  // Swap this based on environment (dev / staging / prod)
  static const String baseUrl = "https://your-api.com/api/v1";

  // ─── Auth ──────────────────────────────────────────────────────────────────
  static const String customerRegister = "/auth/customer/register";
  static const String customerLogin    = "/auth/customer/login";
  static const String verifyOtp        = "/auth/customer/verify-otp";
  static const String resendOtp        = "/auth/customer/resend-otp";
  static const String forgotPassword   = "/auth/customer/forgot-password";
  static const String resetPassword    = "/auth/customer/reset-password";
  static const String logout           = "/auth/customer/logout";

  // ─── Profile ───────────────────────────────────────────────────────────────
  static const String profile          = "/customer/profile";
}
