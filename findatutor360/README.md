# FindaTutor 360

_\*AI Tools App works on ios, Android and web._

## Bringing the Power of Open Source AI to Your Fingertips

# ARCHITECTURE - FEATURE BASED IMPLEMENTATION

lib/

    -main.dart \\ App root
    -parent_view.dart \\ App bottom navigationbar

    -routes/
            -index.dart
            -routes_notifier.dart


    -core/

          -models/
                    -auth/
                         -app_model.dart


                    -main/
                         -app_model.dart



          -services/
                     -auth/
                            -app_services.dart
                     -main/
                            -app_service.dart

          -view_models/
                       -auth/
                             -app_controller.dart
                       -auth/
                             -app_controller.dart


    -custom_widgets/
                    -buttons/
                             -primary_button.dart


    -provider/
               -app_provider.dart \\ App providers

    -theme/
            -index.dart  \\ app colors


    -utils/
            - api_services.dart
            - shared_preferences.dart
            - base_provider.dart
            - injection_container.dart
            - no_white_space.dart




    -views/
         -auth/
                \\ App Authenticate UIs and logic


         -main/
               \\ App main UIs and User interactions

pubspec.yaml \\ App packages and Dev dependencies

## BRANCHING STRATEGY

- Feature -> dev -> Main
- Branch out from dev using name of feature as name of the branch
- File PR into dev after completing working and request reviews
- FVM Flutter Version Management; For managing flutter and dart versions
- Use fvm flutter pub get to get packages
- Use fvm install 3.22.2 to install flutter SDK version
