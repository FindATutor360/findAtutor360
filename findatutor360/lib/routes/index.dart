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
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'onboarding',
            builder: (BuildContext context, GoRouterState state) {
              return OnboardingView();
            },
          ),
          GoRoute(
            path: 'welcome',
            builder: (BuildContext context, GoRouterState state) {
              return const WelcomeView();
            },
          ),
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginView();
            },
          ),
          GoRoute(
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterView();
            },
          ),
          GoRoute(
            path: 'email_verify',
            builder: (BuildContext context, GoRouterState state) {
              return const VerifyEmailView();
            },
          ),
          GoRoute(
            path: 'email_success',
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
                routes: [
                  GoRoute(
                    path: 'home',
                    builder: (BuildContext context, GoRouterState state) {
                      return const HomeView();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _shopKey,
                routes: [
                  GoRoute(
                    path: 'shop',
                    builder: (BuildContext context, GoRouterState state) {
                      return const ShopView();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _messageKey,
                routes: [
                  GoRoute(
                    path: 'message',
                    builder: (BuildContext context, GoRouterState state) {
                      return const MessageView();
                    },
                    routes: [
                      GoRoute(
                        path: 'chat',
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
                routes: [
                  GoRoute(
                    path: 'cart',
                    builder: (BuildContext context, GoRouterState state) {
                      return const CartView();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                navigatorKey: _settingsKey,
                routes: [
                  GoRoute(
                    path: 'settings',
                    builder: (BuildContext context, GoRouterState state) {
                      return const SettingsView();
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'category',
            builder: (BuildContext context, GoRouterState state) {
              return const CategoryView();
            },
          ),
          GoRoute(
            path: 'recommended_tutors',
            builder: (BuildContext context, GoRouterState state) {
              return const RecommendedTutorsView();
            },
          ),
        ],
      ),
    ];
