# FindaTutor 360

_\*App works on ios, Android and web._

## Bringing the Power of Open Source AI to Your Fingertips

# ARCHITECTURE - FEATURE BASED IMPLEMENTATION

- The project follows a feature-based architecture to ensure scalability and maintainability. 
- Below is the structure of the project directory:

lib/
    ├── main.dart                    // App root
    ├── parent_view.dart             // App bottom navigation bar

    ├── routes/
    │      ├── index.dart
    │      └── routes_notifier.dart

    ├── core/
    │      ├── models/
    │      │      ├── auth/
    │      │      │       └── app_model.dart
    │      │      └── main/
    │      │              └── app_model.dart
    │      ├── services/
    │      │      ├── auth/
    │      │      │       └── app_services.dart
    │      │      └── main/
    │      │              └── app_service.dart
    │      └── view_models/
    │              ├── auth/
    │              │       └── app_controller.dart
    │              └── main/
    │                      └── app_controller.dart

    ├── custom_widgets/
    │        └── buttons/
    │                 └── primary_button.dart

    ├── provider/
    │        └── app_provider.dart   // App providers

    ├── theme/
    │       └── index.dart           // App colors

    ├── utils/
    │      ├── api_services.dart
    │      ├── shared_preferences.dart
    │      ├── base_provider.dart
    │      ├── injection_container.dart
    │      └── no_white_space.dart

    ├── views/
           ├── auth/                 // App Authenticate UIs and logic
           └── main/                 // App main UIs and User interactions

pubspec.yaml                         // App packages and dev dependencies


## BRANCHING STRATEGY

To maintain a smooth development workflow, the following branching strategy is used:

1. Feature -> dev -> main
- All new features branch out from dev.
- Name branches according to the feature being implemented.
- Submit a Pull Request (PR) to dev for review once the feature is complete.

2. FVM (Flutter Version Management):
- Ensures consistent Flutter and Dart versions across the team.
- Run fvm flutter pub get to fetch the required packages.
- Use fvm install 3.22.2 to install the specific Flutter SDK version.

## Features
- Cross-platform compatibility: Works on iOS, Android, and Web.
- Feature-based architecture: Organized for scalability and maintainability.
- AI Integration: Leverages open-source AI tools to enhance user experience.
- Theming support: Customizable themes for consistent styling.
- Reusable widgets: Centralized custom components for seamless design.

## Usage
1. Clone the repository:
 ```git clone https://github.com/your-username/findaTutorApp.git```

2. Navigate to the project directory:
cd findaTutorApp

3. Install dependencies using FVM:
```fvm flutter pub get```

4. Run the app on your desired platform
```fvm flutter run```


## Tools and Dependencies
The app makes use of the following essential tools and dependencies defined in pubspec.yaml:

- State Management: Provider
- API Services: Custom API integrations
- Shared Preferences: Local storage and persistence
- Dependency Injection: Using injection containers for service management

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for details.
