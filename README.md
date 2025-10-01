# Carbon_Learning_System

A modern Flutter application for educational management, student tracking, smart assistant chat, entertainment, and more.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Main Packages Used](#main-packages-used)
- [Running the App](#running-the-app)
- [Building for Production](#building-for-production)
- [Assets & Theming](#assets--theming)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **Authentication**: Secure login and registration.
- **Profile Management**: Create, edit, and manage user and child profiles, including health data.
- **AI Chat**: Smart assistant for Q&A, file analysis, and image description.
- **Curricula**: Browse and download curriculum files (PDF, DOC, etc.).
- **Costs & Installments**: Track fees, expenses, and payment status.
- **Schedule**: View and request meetings with teachers.
- **Exam Results**: Display student exam results.
- **Tracking**: Real-time student location tracking with route history.
- **Entertainment**: Watch educational and cartoon videos.
- **Advertisements**: Browse and subscribe to offers and ads.
- **Theming**: Custom light theme with support for Arabic fonts and RTL layout.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart (comes with Flutter)
- Android Studio/Xcode/VS Code (recommended)
- For web: Chrome or compatible browser

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Carbon-startUP/Carbon_Learning_System_Flutter
   cd pasos
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

```
lib/
  core/           # Core utilities, navigation, API, constants
  features/       # Main app features (auth, profile, ai_chat, curricula, etc.)
  shared/         # Shared theme, widgets, and resources
  main.dart       # App entry point
assets/           # Images and other static assets
test/             # Unit and widget tests
```

- **Navigation**: Managed via [`AppRouter`](lib/core/navigation/app_router.dart)
- **Theming**: See [`AppTheme`](lib/shared/theme/app_theme.dart)
- **State Management**: Uses [flutter_bloc](https://pub.dev/packages/flutter_bloc)

## Main Packages Used

- `flutter_bloc` - State management
- `equatable` - Value equality
- `latlong2` - Geolocation
- `url_launcher` - Open links/files
- `dio` - Networking (see [`dio_client.dart`](lib/core/api/dio_client.dart))
- `material` - UI components

## Running the App

- **Android/iOS**:  
  `flutter run`
- **Web**:  
  `flutter run -d chrome`
- **Desktop** (Windows/Mac/Linux):  
  `flutter run -d windows` (or `macos`/`linux`)

## Building for Production

- **Android APK**:  
  `flutter build apk`
- **iOS**:  
  `flutter build ios`
- **Web**:  
  `flutter build web`
- **Windows/Mac/Linux**:  
  `flutter build windows` (or `macos`/`linux`)

## Assets & Theming

- **Images**: Located in `assets/images/` and referenced in `pubspec.yaml`
- **Fonts**: Custom Arabic (`RPT`) and English (`NEXA`) fonts configured in `pubspec.yaml`
- **Theme**: All colors and text styles are defined in [`app_colors.dart`](lib/shared/theme/app_colors.dart) and [`app_text_styles.dart`](lib/shared/theme/app_text_styles.dart)

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License.

---

