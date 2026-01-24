import 'package:cleclo_rider/components/scaffold_with_navbar.dart';
import 'package:cleclo_rider/features/splash/view/splash_screen.dart';
import 'package:cleclo_rider/features/auth/view/auth_welcome_screen.dart';
import 'package:cleclo_rider/features/auth/view/login_screen.dart';
import 'package:cleclo_rider/features/auth/view/register_screen.dart';
import 'package:cleclo_rider/features/auth/view/verification_pending_screen.dart';
import 'package:cleclo_rider/features/earnings/view/earnings_screen.dart';
import 'package:cleclo_rider/features/home/view/active_orders_screen.dart';
import 'package:cleclo_rider/features/home/view/available_orders_screen.dart';
import 'package:cleclo_rider/features/history/view/order_history_screen.dart';
import 'package:cleclo_rider/features/history/view/order_history_screen.dart';
import 'package:cleclo_rider/features/support/view/help_support_screen.dart';
import 'package:cleclo_rider/features/support/view/faq_screen.dart';
import 'package:cleclo_rider/features/support/view/live_chat_screen.dart';
import 'package:cleclo_rider/features/home/view/home_screen.dart';
import 'package:cleclo_rider/features/home/view/order_details_screen.dart';
import 'package:cleclo_rider/features/location/view/order_delivery_screen.dart';
import 'package:cleclo_rider/features/location/view/order_pickup_screen.dart';
import 'package:cleclo_rider/features/location/view/pickup_verification_screen.dart';
import 'package:cleclo_rider/features/onboarding/view/onboarding_screen.dart';
import 'package:cleclo_rider/features/auth/view/otp_verification_screen.dart';
import 'package:cleclo_rider/features/profile/view/profile_screen.dart';
import 'package:cleclo_rider/features/profile/view/vehicle_details_screen.dart';
import 'package:cleclo_rider/features/profile/view/documents_screen.dart';
import 'package:cleclo_rider/features/profile/view/documents_screen.dart';
import 'package:cleclo_rider/features/profile/view/bank_details_screen.dart';
import 'package:cleclo_rider/features/profile/view/personal_information_screen.dart';
import 'package:cleclo_rider/features/profile/view/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cleclo_rider/routes/route_constants.dart';

// Key for the root navigator (covers the entire screen for auth, splash etc.)
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
// Key for the shell navigator (the part inside the tab bar)
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class RouteConfig {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteConstants.splashScreen,
    routes: [
      // Splash - Full Screen
      GoRoute(
        path: RouteConstants.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding - Full Screen
      GoRoute(
        path: RouteConstants.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Auth - Full Screen
      GoRoute(
        path: RouteConstants.authWelcomeScreen,
        builder: (context, state) => const AuthWelcomeScreen(),
      ),
      GoRoute(
        path: RouteConstants.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteConstants.verificationPendingScreen,
        builder: (context, state) => const VerificationPendingScreen(),
      ),
      GoRoute(
        path: RouteConstants.verifyOtpScreen,
        builder: (context, state) {
          final phone = state.extra as String;
          return OtpVerificationScreen(phoneNumber: phone);
        },
      ),

      // SHELL ROUTE FOR PERSISTENT BOTTOM NAV
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConstants.homeScreen,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Branch 2: Active Orders / Orders Tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConstants.activeOrdersScreen,
                builder: (context, state) => const ActiveOrdersScreen(),
              ),
            ],
          ),

          // Branch 3: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteConstants.profileScreen,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      
      // Standalone Routes (Full Screen, outside Shell but accessed from within)
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.availableOrdersScreen,
        builder: (context, state) => const AvailableOrdersScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.orderHistoryScreen,
        builder: (context, state) => const OrderHistoryScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.helpSupportScreen,
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.faqScreen,
        builder: (context, state) => const FaqScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.liveChatScreen,
        builder: (context, state) => const LiveChatScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.orderDetailsScreen,
        builder: (context, state) => const OrderDetailsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.earningsScreen,
        builder: (context, state) => const EarningsScreen(),
      ),
      
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.orderPickupScreen,
        builder: (context, state) => const OrderPickupScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.pickupVerificationScreen,
        builder: (context, state) => const PickupVerificationScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.orderDeliveryScreen,
        builder: (context, state) => const OrderDeliveryScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.vehicleDetailsScreen,
        builder: (context, state) => const VehicleDetailsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.documentsScreen,
        builder: (context, state) => const DocumentsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.bankDetailsScreen,
        builder: (context, state) => const BankDetailsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.personalInfoScreen,
        builder: (context, state) => const PersonalInformationScreen(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: RouteConstants.settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
