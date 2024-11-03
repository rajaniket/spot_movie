# SpotMovie - SF Filming Locations 🎬

SpotMovie is an app that lets you discover where movies have been filmed in San Francisco since 1924. You can search for movies, explore their filming locations on Google Maps, and get details like titles, locations, directors, and more. SpotMovie supports both light and dark modes, includes real-time location tracking, and is optimized for fast loading with data caching.

**Platforms**:  
- Android, iOS (full support)  
- Web (partial, without map)

---

## 🎥 Demo Video

https://github.com/user-attachments/assets/526057c0-8d53-4c55-9c27-6adb66a48e23

---

## 🌟 Key Features

- **Autocomplete Search**: Quickly find SF movies based on title.
- **Map Integration**: View filming locations on Google Maps, with light/dark mode options.
- **Location Tracking**: Real-time tracking of your current location within the app.
- **Optimized Caching**: Data is cached locally and refreshed every hour for fast performance.
- **Clean Architecture**: Well-structured and organized for easy maintenance and scalability.

---

## 📁 Folder Structure

```plaintext
lib
├── core                                              # Core app utilities and shared components
│   ├── constants                                     # App-wide constant values
│   │   └── constants.dart
│   ├── di                                            # Dependency injection setup
│   │   ├── injection.config.dart
│   │   └── injection.dart
│   ├── services                                      # Services for logging, network, and storage
│   │   ├── logger_service
│   │   │   ├── logger_service.dart
│   │   │   └── logging_interceptor.dart
│   │   ├── network_service
│   │   │   └── network_service.dart
│   │   └── storage_service
│   │       └── storage_service.dart
│   ├── theme                                        # Theme colors and styles
│   │   ├── app_colors.dart
│   │   └── app_theme.dart
│   └── widgets                                      # Reusable UI components
│       └── app_dialog.dart
├── features                                         # Feature-specific code, organized by modules
│   └── movie                                
│       ├── data                                     # Handles fetching and managing movie data
│       │   ├── data_sources
│       │   │   ├── movie_local_data_source.dart
│       │   │   └── movie_remote_data_source.dart
│       │   ├── models
│       │   │   ├── movie_models.dart
│       │   │   └── movie_models.g.dart
│       │   └── repositories
│       │       └── movie_repository_impl.dart
│       ├── domain                                   # Business logic and use cases
│       │   ├── entities
│       │   │   └── movie_entity.dart
│       │   ├── repositories
│       │   │   └── movie_repository.dart
│       │   └── usecases
│       │       └── get_movies_use_case.dart
│       └── presentation                             # UI components and state management
│           ├── cubit
│           │   ├── movie_cubit.dart
│           │   └── movie_state.dart
│           ├── screens
│           │   └── movie_screen.dart
│           ├── ui_entity
│           │   ├── errors_enum.dart
│           │   └── map_marker.dart
│           └── widgets
│               ├── auto_complete_search_widget.dart
│               └── google_map_widget.dart
└── main.dart                                        # App entry point
```

---

## 🔧 Dependencies

Here's a list of all the packages used in this project, with brief descriptions of each:

```plaintext
dependencies:
  dio: ^5.7.0                        # For making HTTP requests to fetch movie data from API
  equatable: ^2.0.5                  # Simplifies object comparison, especially useful with Cubit states
  flutter_bloc: ^8.1.6               # State management with Bloc and Cubit for handling app states
  flutter_typeahead: ^5.2.0          # Provides autocomplete functionality for search feature
  geocoding: ^3.0.0                  # Converts addresses into geographical coordinates
  geolocator: ^13.0.1                # Provides location tracking and services for current user location
  get_it: ^8.0.2                     # Dependency injection tool for managing app dependencies
  google_fonts: ^6.2.1               # Custom fonts to enhance the UI design
  google_maps_flutter: ^2.9.0        # Integrates Google Maps to display movie filming locations
  injectable: ^2.5.0                 # Works with get_it for dependency injection
  logger: ^2.4.0                     # Logging tool to help with debugging
  mockito: ^5.4.4                    # Used for mocking dependencies in unit tests
  permission_handler: ^10.3.0        # Manages permissions for location tracking and other features
  shared_preferences: ^2.3.2         # Caches data locally to improve load times and data retrieval

dev_dependencies:
  build_runner: ^2.4.13              # Generates code for dependency injection and JSON serialization
  flutter_test:                      # Flutter's test framework for writing and running tests
    sdk: flutter
  injectable_generator: ^2.6.2       # Works with build_runner to generate injectable classes for DI
  json_serializable: ^6.8.0          # Simplifies JSON parsing with generated model classes
  very_good_analysis: ^6.0.0         # Code analysis tool to ensure best coding practices
```

---

## 🔑 Setup

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/rajaniket/spot_movie.git
   cd spot_movie
   ```

2. **Install Packages**:

   ```bash
   flutter pub get
   ```

3. **Google Maps API Key**:
   
   - Add your Google Maps API key to `AndroidManifest.xml` (Android) and `AppDelegate.swift` (iOS).
   - Enable Maps SDK, Geocoding API, and Geolocation API in the Google Cloud Console.

4. **Run the App**:

   ```bash
   flutter run
   ```

---

## 🔍 Future Scope

- **Additional Unit Tests**: Enhance test coverage for services, Cubits, and UI.
- **Web Compatibility**: Add Google Maps for Web support to show maps on the web platform.
