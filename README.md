# Grabby App 🍔📍

A modern, multi-vendor food discovery, ordering, and branch management mobile application built with **Flutter**, utilizing **Clean Architecture** and **BLoC (Business Logic Component)** pattern.

Grabby connects customers with local restaurants and food shops while empowering business owners to manage multiple branch locations, real-time incoming orders, menus, and marketing campaigns from a single unified platform.

---

## 📱 App Purpose & Core Value Proposition

Grabby bridges the gap between culinary merchants and food lovers through an intuitive, location-aware digital marketplace. It serves two distinct user roles:

1. **Customers:** Discover nearby eateries, explore localized menus, place orders seamlessly, track fulfillment status in real-time on live maps, and earn loyalty rewards.
2. **Shop Owners / Merchants:** Operate and scale single or multi-branch restaurant businesses, manage real-time order workflows, customize operational hours and menus per branch, and monitor business performance.

---

## 👥 User Roles & Features Breakdown

### 1. 🛍️ Shop Owner (Merchant) Role

The merchant interface is tailored for streamlined kitchen and multi-branch operations:

- **Multi-Branch Operations & Onboarding:**
  - **Branch Creation & Profiling:** Add multiple branch locations with specific names, addresses, contact details, and precise Google Maps coordinates.
  - **Operational Timings (`branch_timings_page`):** Set daily opening and closing hours, operational shifts, and active/inactive status per branch.
  - **Menu Synchronization:** Choose to share a universal menu across all branches or customize unique menus for specific branch locations.
- **Shop Dashboard & Analytics (`ShopHomePage`):**
  - High-level business overview with real-time statistics (total orders, revenue, active orders).
  - Branch-wise filter dropdown to switch performance and order metrics across different outlets dynamically.
- **Live Order Management (`ShopOrderManagementPage`):**
  - End-to-end status lifecycle tabs: `Placed` ➔ `Preparing` ➔ `Ready` ➔ `Completed` / `Cancelled`.
  - Detailed order view with itemized receipts, customer notes, delivery details, and one-tap status updates.
- **Menu & Category Management (`ShopMenuManagementPage`):**
  - Add, edit, and organize categories and food items with pricing, descriptions, preparation times, and dish imagery.
  - Fast search with debounced filtering and item availability toggles.
- **Business Profile & Payouts:**
  - Automated payout onboarding via **Stripe Connect** WebView.
  - Document verification submission for business compliance.

---

### 2. 🍽️ Customer Role

The customer interface provides an engaging, hyper-local dining and delivery experience:

- **Hyper-Local Discovery & Search (`HomePage`):**
  - Automatically fetches nearby branches based on the customer's GPS coordinates (`lat`/`lng`).
  - View real-time status badges (`Open Now` / `Closed`), estimated distances, delivery times, and active branch promotions.
  - Search and filter by cuisine, food category, or restaurant name.
- **Menu Exploration & Cart Checkout:**
  - Rich menu browsing categorized by items, add-ons, and pricing.
  - Frictionless cart management with promo code validation and clear pricing breakdowns.
- **Real-Time Order Tracking & Live Map (`OrderTrackingPage` & `OrderTrackingMapViewPage`):**
  - Real-time updates showing progress from kitchen preparation to dispatch and delivery.
  - Interactive Google Maps tracking showing branch location, customer delivery destination, and delivery progression.
- **Loyalty Rewards & Promotions:**
  - **Digital Stamp Cards (`RewardModule`):** Earn stamps on eligible branch orders and redeem them for free food or exclusive discounts.
  - **Promotions & Offers:** Banner carousels and promotional popups showcasing active merchant deals.

---

## 🏗️ Project Architecture & Tech Stack

This project follows **Feature-First Clean Architecture**:

```text
lib/
├── main.dart
├── src/
│   ├── core/                  # Shared utilities, themes, network clients, constants
│   │   ├── constants/
│   │   ├── network/
│   │   ├── theme/
│   │   └── utils/
│   └── featurs/               # Modular Feature Slices
│       ├── auth/              # Multi-step authentication, onboarding, role selection
│       ├── branch/            # Branch data models, repositories, and logic
│       ├── cart-checkout/     # Cart management, coupon application, checkout flow
│       ├── home/              # Customer feed & Merchant dashboard
│       ├── menu/              # Menu and category CRUD & listings
│       ├── navigation/        # Bottom navigation bars (Customer & Shop)
│       ├── order/             # Order placement, merchant management & live tracking
│       ├── profile-settings/  # Account settings, branch timings, Stripe Connect
│       ├── promotion/         # Marketing banners and discount campaigns
│       ├── restruant/         # Restaurant/branch details and profiles
│       ├── reward/            # Customer loyalty stamp rewards
│       └── support/           # Help center and customer support
```

### Key Libraries & Dependencies

- **State Management:** `flutter_bloc` & `bloc`
- **Routing:** `go_router` (declarative routing with deep links)
- **Dependency Injection:** `get_it`
- **Maps & Geolocation:** `google_maps_flutter`, `geolocator`
- **Networking:** `dio` / `http` with interceptors
- **Payment & Verification:** `pinput`, Stripe Connect integration
- **Styling & Assets:** `flutter_svg`, `cached_network_image`, `cupertino_icons`

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (>= 3.10.7)
- [Dart SDK](https://dart.dev/get-dart)
- Xcode (for iOS builds) / Android Studio (for Android builds)
- Google Maps API Key configured for both Android and iOS

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/moury12/grabby-app.git
   cd grabby_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Environment Keys:**
   - Add your Google Maps API key to:
     - Android: `android/app/src/main/AndroidManifest.xml`
     - iOS: `ios/Runner/AppDelegate.swift`

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 📋 App Store Review Information (Apple)

For App Store submission inquiries, please refer to the detailed role breakdown, business model description, and access credentials provided in App Store Connect Resolution Center.
