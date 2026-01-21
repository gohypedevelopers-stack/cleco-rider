import 'package:cleclo_rider/features/auth/view/auth_welcome_screen.dart';
import 'package:cleclo_rider/features/auth/view/login_screen.dart';
import 'package:cleclo_rider/features/auth/view/register_screen.dart';
import 'package:cleclo_rider/features/auth/view/verification_pending_screen.dart';
import 'package:cleclo_rider/features/earnings/view/earnings_screen.dart';
import 'package:cleclo_rider/features/home/view/active_orders_screen.dart';
import 'package:cleclo_rider/features/home/view/available_orders_screen.dart';
import 'package:cleclo_rider/features/home/view/home_screen.dart';
import 'package:cleclo_rider/features/home/view/order_details_screen.dart';
import 'package:cleclo_rider/features/location/view/order_delivery_screen.dart';
import 'package:cleclo_rider/features/location/view/order_pickup_screen.dart';
import 'package:cleclo_rider/features/location/view/pickup_verification_screen.dart';
import 'package:cleclo_rider/features/onboarding/view/onboarding_screen.dart';
import 'package:cleclo_rider/features/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cleclo_rider/routes/route_constants.dart';

// Placeholder Screens
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)), body: Center(child: Text(title)));
}

class RouteConfig {
  static final GoRouter router = GoRouter(
    initialLocation: RouteConstants.onboardingScreen,
    routes: [
      // Onboarding
      GoRoute(
        path: RouteConstants.onboardingScreen,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Auth
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

      // Home & Dashboard
      GoRoute(
        path: RouteConstants.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteConstants.availableOrdersScreen,
        builder: (context, state) => const AvailableOrdersScreen(),
      ),
      GoRoute(
        path: RouteConstants.activeOrdersScreen,
        builder: (context, state) => const ActiveOrdersScreen(),
      ),

      // Orders
      GoRoute(
        path: RouteConstants.orderDetailsScreen,
        builder: (context, state) => const OrderDetailsScreen(),
      ),
      GoRoute(
        path: RouteConstants.orderPickupScreen,
        builder: (context, state) => const OrderPickupScreen(),
      ),
      GoRoute(
        path: RouteConstants.pickupVerificationScreen,
        builder: (context, state) => const PickupVerificationScreen(),
      ),
      GoRoute(
        path: RouteConstants.orderDeliveryScreen,
        builder: (context, state) => const OrderDeliveryScreen(),
      ),

      // Profile
      GoRoute(
        path: RouteConstants.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),

      // Earnings
      GoRoute(
        path: RouteConstants.earningsScreen,
        builder: (context, state) => const EarningsScreen(),
      ),
    ],
  );
}
