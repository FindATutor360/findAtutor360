import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/views/auth/change_password/change_password.dart';
import 'package:findatutor360/views/auth/splash/splash_view.dart';
import 'package:findatutor360/views/main/cart/check_out_view.dart';
import 'package:findatutor360/views/main/cart/edit_address_view.dart';
import 'package:findatutor360/views/main/cart/payment_success_view.dart';
import 'package:findatutor360/views/main/cart/payment_view.dart';
import 'package:findatutor360/views/main/cart/wishlist_view.dart';
import 'package:findatutor360/views/main/home/category/category_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:findatutor360/views/main/home/recommeded_tutors/recommended_tutors_view.dart';
import 'package:findatutor360/views/main/home/trending_books/trending_book.dart';
import 'package:findatutor360/views/main/message/chat.dart';
import 'package:findatutor360/views/main/settings/add_book_basic.dart';
import 'package:findatutor360/views/main/settings/add_book_condition.dart';
import 'package:findatutor360/views/main/settings/add_book_publish.dart';
import 'package:findatutor360/views/main/settings/add_book_success.dart';
import 'package:findatutor360/views/main/settings/edit_personal_profile_view.dart';
import 'package:findatutor360/views/main/settings/edit_profile_contact_view.dart';
import 'package:findatutor360/views/main/settings/edit_profile_education_view.dart';
import 'package:findatutor360/views/main/settings/edit_profile_success_view.dart';
import 'package:findatutor360/views/main/settings/feed_back_success_view.dart';
import 'package:findatutor360/views/main/settings/feed_back_view.dart';
import 'package:findatutor360/views/main/settings/invite_friend_view.dart';
import 'package:findatutor360/views/main/settings/my_books_view.dart';
import 'package:findatutor360/views/main/settings/my_courses_view.dart';
import 'package:findatutor360/views/main/settings/notification_empty.dart';
import 'package:findatutor360/views/main/settings/notification_not_setup.dart';
import 'package:findatutor360/views/main/settings/notification_view.dart';
import 'package:findatutor360/views/main/settings/payment_card_view.dart';
import 'package:findatutor360/views/main/settings/payment_history_view.dart';
import 'package:findatutor360/views/main/settings/personal_profile_view.dart';
import 'package:findatutor360/views/main/settings/purchase_tracking.dart';
import 'package:findatutor360/views/main/settings/purchase_view.dart';
import 'package:findatutor360/views/main/settings/schedules_view.dart';
import 'package:findatutor360/views/main/settings/settings_notification.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:findatutor360/views/main/shop/book_shop_course.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:findatutor360/views/main/shop/reviews_view.dart';
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
final _shopKey = GlobalKey<NavigatorState>(debugLabel: 'shellShop');
final rootKey = GlobalKey<NavigatorState>(debugLabel: 'shellRoot');
final _messageKey = GlobalKey<NavigatorState>(debugLabel: 'shellMessage');
final _settingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
final _cartKey = GlobalKey<NavigatorState>(debugLabel: 'shellCarts');

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
      GoRoute(
        path: ChangePasswordView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const ChangePasswordView();
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
                routes: [
                  GoRoute(
                    path: RecommendedTutorsView.path,
                    builder: (BuildContext context, GoRouterState state) {
                      return const RecommendedTutorsView();
                    },
                  ),
                  GoRoute(
                    path: TrendingBooksView.path,
                    builder: (BuildContext context, GoRouterState state) {
                      return const TrendingBooksView();
                    },
                  ),
                ],
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
                routes: [
                  GoRoute(
                    path: BookShopView.path,
                    builder: (BuildContext context, GoRouterState state) {
                      return const BookShopView();
                    },
                  ),
                ],
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
                    path: ChatViews.path,
                    builder: (BuildContext context, GoRouterState state) {
                      final message = state.extra as Messages;
                      return ChatViews(
                        key: state.pageKey,
                        messages: message,
                      );
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
                routes: [
                  GoRoute(
                    path: SettingsNotification.path,
                    builder: (BuildContext context, GoRouterState state) {
                      return const SettingsNotification();
                    },
                  ),
                ],
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
        path: BookDetails.path,
        builder: (BuildContext context, GoRouterState state) {
          return const BookDetails();
        },
      ),
      GoRoute(
        path: CourseDetails.path,
        builder: (BuildContext context, GoRouterState state) {
          return const CourseDetails();
        },
      ),
      GoRoute(
        path: Reviews.path,
        builder: (BuildContext context, GoRouterState state) {
          return const Reviews();
        },
      ),
      GoRoute(
        path: CheckOutView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const CheckOutView();
        },
      ),
      GoRoute(
        path: PaymentView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentView();
        },
      ),
      GoRoute(
        path: PaymentSuccessView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentSuccessView();
        },
      ),
      GoRoute(
        path: EditAddressView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const EditAddressView();
        },
      ),
      GoRoute(
        path: PaymentHistoryView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentHistoryView();
        },
      ),
      GoRoute(
        path: PaymentCardView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentCardView();
        },
      ),
      GoRoute(
        path: NotificationNotSetup.path,
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationNotSetup();
        },
      ),
      GoRoute(
        path: NotificationView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationView();
        },
      ),
      GoRoute(
        path: NotificationEmpty.path,
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationEmpty();
        },
      ),
      GoRoute(
        path: PersonalProfileView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const PersonalProfileView();
        },
      ),
      GoRoute(
        path: EditPersonalProfileView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const EditPersonalProfileView();
        },
      ),
      GoRoute(
        path: EditProfileContactView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const EditProfileContactView();
        },
      ),
      GoRoute(
        path: EditProfileEducationView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const EditProfileEducationView();
        },
      ),
      GoRoute(
        path: EditProfileSuccessView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const EditProfileSuccessView();
        },
      ),
      GoRoute(
        path: AddBookBasicView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddBookBasicView();
        },
      ),
      GoRoute(
        path: AddBookPublishView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddBookPublishView();
        },
      ),
      GoRoute(
        path: AddBookConditionView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddBookConditionView();
        },
      ),
      GoRoute(
        path: AddBookSuccessView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddBookSuccessView();
        },
      ),
      GoRoute(
        path: WishlistView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const WishlistView();
        },
      ),
      GoRoute(
        path: MyBooksView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const MyBooksView();
        },
      ),
      GoRoute(
        path: MyCoursesView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const MyCoursesView();
        },
      ),
      GoRoute(
        path: PurchaseView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const PurchaseView();
        },
      ),
      GoRoute(
        path: PurchaseTracking.path,
        builder: (BuildContext context, GoRouterState state) {
          return const PurchaseTracking();
        },
      ),
      GoRoute(
        path: SchedulesView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const SchedulesView();
        },
      ),
      GoRoute(
        path: FeedBackView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const FeedBackView();
        },
      ),
      GoRoute(
        path: FeedBackSuccessView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const FeedBackSuccessView();
        },
      ),
      GoRoute(
        path: InviteFriendView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const InviteFriendView();
        },
      ),
    ];
