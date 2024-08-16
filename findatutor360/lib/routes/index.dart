import 'package:findatutor360/views/auth/splash/splash_view.dart';
import 'package:findatutor360/views/main/home/category/category_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:findatutor360/views/main/home/recommeded_tutors/recommended_tutors_view.dart';
import 'package:findatutor360/views/main/message/chat_view.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:findatutor360/views/main/message/message_view.dart';
import 'package:findatutor360/views/main/cart/cart_view.dart';
import 'package:findatutor360/views/main/settings/settings_view.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:findatutor360/views/auth/signup/register_view.dart';
import 'package:findatutor360/views/auth/onboarding/onboarding_view.dart';
import 'package:findatutor360/views/auth/email/email_success/email_success_view.dart';
import 'package:findatutor360/views/auth/email/verify_email/verify_email_view.dart';
import 'package:findatutor360/views/auth/welcome/welcome_view.dart';
import 'package:findatutor360/views/parent_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _homeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shopKey = GlobalKey<NavigatorState>(debugLabel: 'shellCart');
final rootKey = GlobalKey<NavigatorState>(debugLabel: 'shellRoot');
final _messageKey = GlobalKey<NavigatorState>(debugLabel: 'shellReels');
final _settingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
final _cartKey = GlobalKey<NavigatorState>(debugLabel: 'shellNotification');

List<RouteBase> get routes => [
      GoRoute(
        path: SplashView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: OnboardingView.path,
        builder: (BuildContext context, GoRouterState state) {
          return OnboardingView();
        },
      ),
      GoRoute(
        path: WelcomeView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeView();
        },
      ),
      GoRoute(
        path: LoginView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: RegisterView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterView();
        },
      ),
      GoRoute(
        path: VerifyEmailView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const VerifyEmailView();
        },
      ),
      GoRoute(
        path: EmailSuccessView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const EmailSuccessView();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ParentView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeKey,
            initialLocation: HomeView.path,
            routes: [
              GoRoute(
                path: HomeView.path,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shopKey,
            initialLocation: ShopView.path,
            routes: [
              GoRoute(
                path: ShopView.path,
                builder: (BuildContext context, GoRouterState state) {
                  return const ShopView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _messageKey,
            initialLocation: MessageView.path,
            routes: [
              GoRoute(
                path: MessageView.path,
                builder: (BuildContext context, GoRouterState state) {
                  return const MessageView();
                },
                routes: [
                  GoRoute(
                    path: ChatView.path,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ChatView();
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _cartKey,
            initialLocation: CartView.path,
            routes: [
              GoRoute(
                path: CartView.path,
                builder: (BuildContext context, GoRouterState state) {
                  return const CartView();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsKey,
            initialLocation: SettingsView.path,
            routes: [
              GoRoute(
                path: SettingsView.path,
                builder: (BuildContext context, GoRouterState state) {
                  return const SettingsView();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: CategoryView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const CategoryView();
        },
      ),
      GoRoute(
        path: RecommendedTutorsView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const RecommendedTutorsView();
        },
      ),
    ];
