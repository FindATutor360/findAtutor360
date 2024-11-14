import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/views/auth/change_password/change_password.dart';
import 'package:findatutor360/views/auth/forget_password/forget_password.dart';
import 'package:findatutor360/views/auth/forget_password/password_confirmation_screen.dart';
import 'package:findatutor360/views/auth/splash/splash_view.dart';
import 'package:findatutor360/views/main/cart/check_out_view.dart';
import 'package:findatutor360/views/main/cart/edit_address_view.dart';
import 'package:findatutor360/views/main/cart/payment_success_view.dart';
import 'package:findatutor360/views/main/cart/payment_view.dart';
import 'package:findatutor360/views/main/cart/wishlist_view.dart';
import 'package:findatutor360/views/main/home/active_courses/active_courses.dart';
import 'package:findatutor360/views/main/home/category/category_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:findatutor360/views/main/home/recommeded_tutors/recommended_tutors_view.dart';
import 'package:findatutor360/views/main/home/trending_books/trending_book.dart';
import 'package:findatutor360/views/main/message/chat.dart';
import 'package:findatutor360/views/main/settings/add_book_basic.dart';
import 'package:findatutor360/views/main/settings/add_book_image.dart';
import 'package:findatutor360/views/main/settings/add_book_publish.dart';
import 'package:findatutor360/views/main/settings/add_book_success.dart';
import 'package:findatutor360/views/main/settings/add_course_general.dart';
import 'package:findatutor360/views/main/settings/add_course_pricing.dart';
import 'package:findatutor360/views/main/settings/add_course_success.dart';
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
import 'package:findatutor360/views/main/settings/report_dispute_success_view.dart';
import 'package:findatutor360/views/main/settings/report_dispute_view.dart';
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

import '../core/models/main/course_model.dart';

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
      GoRoute(
        path: ForgetPasswordView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgetPasswordView();
        },
      ),
      GoRoute(
        path: ResetPasswordConfirmationView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const ResetPasswordConfirmationView();
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
                    path: 'booksCategory/:header/:bookQuery',
                    builder: (BuildContext context, GoRouterState state) {
                      final String header =
                          state.pathParameters['header'] ?? '';
                      final String bookQuery =
                          state.pathParameters['bookQuery'] ?? '';
                      return BooksCategorView(
                        header: header,
                        bookQuery: bookQuery,
                      );
                    },
                  ),
                  GoRoute(
                    path: ActiveCourse.path,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ActiveCourse();
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
                      final user = state.extra as Users;
                      return ChatViews(
                        key: state.pageKey,
                        // messages: message,
                        user: user,
                        tutorEmail: 'asanteadarkwa.usman@gmail.com',
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
                  // final String image = state.pathParameters['image'] ?? '';
                  // final String title = state.pathParameters['title'] ?? '';
                  // final String author = state.pathParameters['author'] ?? '';
                  return const CartView(
                      // image: Uri.decodeComponent(image),
                      // title: Uri.decodeComponent(title),
                      // author: Uri.decodeComponent(author),
                      );
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
          final book = state.extra! as Book;
          // final bookData = {
          //   'title': book.title,
          //   'author': book.author,
          // };
          return BookDetails(
            books: book,
          );
        },
      ),
      GoRoute(
        path: CourseDetails.path,
        builder: (BuildContext context, GoRouterState state) {
          final course = state.extra! as Course;
          return CourseDetails(
            course: course,
          );
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
        path: AddBookImageView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddBookImageView();
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
        path: ReportDisputeView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const ReportDisputeView();
        },
      ),
      GoRoute(
        path: ReportDisputeSuccessView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const ReportDisputeSuccessView();
        },
      ),
      GoRoute(
        path: InviteFriendView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const InviteFriendView();
        },
      ),
      GoRoute(
        path: AddCourseGeneralView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddCourseGeneralView();
        },
      ),
      GoRoute(
        path: AddCoursePricingView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddCoursePricingView();
        },
      ),
      GoRoute(
        path: AddCourseSuccessView.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AddCourseSuccessView();
        },
      ),
    ];
