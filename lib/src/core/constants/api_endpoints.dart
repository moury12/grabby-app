class ApiEndpoints {
  ApiEndpoints._(); // prevent instantiation

  // ─── Base URL ──────────────────────────────────────────────────────────────
  // Swap this based on environment (dev / staging / prod)
  static const String baseUrl = "http://10.10.20.50:5001";

  // ─── Auth ──────────────────────────────────────────────────────────────────
  static const String customerRegister = "/auth/customer/register";
  static const String shopOwnerRegister = "/auth/shop-owner/register";
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
  static const String updateShopOwnerProfile = "/shop-owner/profile";
  static const String updateUserLocation = "/customers/location";
  static const String updateShopOwnerLocation = "/shop-owner/location";

  // ─── Shop Owner Business ────────────────────────────────────────────────────
  static const String saveBusinessInfo = "/shop-owner/business/info";
  static const String saveBranches = "/shop-owner/business/branches";
  static const String saveBusinessDocuments = "/shop-owner/business/documents";

  // ─── Menu ───────────────────────────────────────────────────────────────────
  static const String createMenuCategory = "/menu-category/create";
  static const String getMenuCategories = "/menu-category/shop";
  static String deleteMenuCategory(String id) => "/menu-category/$id";
  static const String createMenu = "/menu/create";
  static const String getShopMenuItems = "/menu/shop";
  static String updateMenu(String id) => "/menu/$id";
  static String deleteMenu(String id) => "/menu/$id";

  // ─── Branch Management ──────────────────────────────────────────────────────
  static const String branchBase = "/shop-owner/branch";
  static String branchUpdate(String id) => "/shop-owner/branch/$id";
  static String branchDelete(String id) => "/shop-owner/branch/$id";
  static String branchAvailability(String id) => "/shop-owner/branch/$id/availability";

  // ─── Customer Branch Browsing ─────────────────────────────────────────────
  static const String customerBranches = "/customers/branches";
  static String customerBranchDetail(String id) => "/customers/branches/$id";
  static const String upcomingEvents = "/upcoming-events";
  static const String carPlates = "/car-plates";
  static String deleteCarPlate(String id) => "/car-plates/$id";
}