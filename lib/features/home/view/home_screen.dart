import 'package:cleclo_rider/components/order_card.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
import 'package:cleclo_rider/utils/images/images.dart';
import 'package:cleclo_rider/utils/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Premium Header
            _buildHeader(context),

            // 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Earnings Goal Card
                    _buildEarningsGoalCard(),
                    const SizedBox(height: 24),

                    // Smart Action Zone
                    _buildActionZone(context),
                    const SizedBox(height: 24),

                    // Stats Grid
                    const Text(
                      'Overview',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildStatCard(
                          icon: Icons.check_circle_outline,
                          label: 'Completed',
                          value: '12',
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          icon: Icons.directions_bike,
                          label: 'Distance',
                          value: '45 km',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 12),
                        _buildStatCard(
                          icon: Icons.star_border,
                          label: 'Rating',
                          value: '4.8',
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Recent Activity / Quick Actions
                    const Text(
                      'Quick Actions',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActionTile(
                      icon: Icons.history,
                      title: 'Order History',
                      subtitle: 'View your completed deliveries',
                      onTap: () {
                        context.push(RouteConstants.orderHistoryScreen);
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildQuickActionTile(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      subtitle: 'Get assistance with ongoing orders',
                      onTap: () {
                        context.push(RouteConstants.helpSupportScreen);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  // --- Header ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.gray200,
            backgroundImage: const AssetImage(Images.profilePhoto),
            onBackgroundImageError: (_, __) {}, // Handle missing asset gracefully
            child: const Icon(Icons.person, color: AppColors.gray500),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back,',
                  style: TextStyle(fontSize: 12, color: AppColors.gray500),
                ),
                Text(
                  'Ravindra Kumar',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          // Status switch
          GestureDetector(
            onTap: () => setState(() => isOnline = !isOnline),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isOnline ? AppColors.riderGreen : AppColors.gray300,
                borderRadius: BorderRadius.circular(30),
                boxShadow: isOnline
                    ? [
                        BoxShadow(
                          color: AppColors.riderGreen.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isOnline ? 'ONLINE' : 'OFFLINE',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Earnings Goal Card ---
  Widget _buildEarningsGoalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)], // Deep Blue to Bright Blue
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Today\'s Earnings',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Target: ₹1500',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '₹ 850.00',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.56, // 850/1500
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You are ₹650 away from your daily goal!',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // --- Smart Action Zone ---
  Widget _buildActionZone(BuildContext context) {
    if (!isOnline) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Column(
          children: [
            const Icon(Icons.power_settings_new_rounded, size: 48, color: AppColors.gray400),
            const SizedBox(height: 12),
            const Text(
              'You are currently offline',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.gray600),
            ),
            const SizedBox(height: 4),
            const Text(
              'Go online to start receiving delivery requests.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: AppColors.gray500),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => isOnline = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('Go Online', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      );
    }

    // Online State - List of New Orders
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'New Orders (2)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => context.push(RouteConstants.availableOrdersScreen),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 290, // Increased height to prevent overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                width: 300, // Card width
                margin: const EdgeInsets.only(right: 16, bottom: 10), // Added bottom margin for shadow
                child: RiderOrderCard(
                  orderId: 'ORD-#${20234 + index}',
                  pickupAddress: index == 0 ? 'Home 12, Saket' : 'Office 4, Nehru Place',
                  deliveryAddress: 'Laundry Hub, Sector 18',
                  distance: '${2.5 + index} km',
                  earnings: '₹${65 + (index * 10)}',
                  serviceType: index == 0 ? 'Wash & Fold' : 'Dry Clean',
                  onAccept: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order Accepted! Redirecting...')),
                    );
                    // Navigate to Active Orders or similar
                    context.go(RouteConstants.activeOrdersScreen);
                  },
                  onDecline: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order Ignored')),
                    );
                  },
                  onTap: () {
                     context.push(RouteConstants.availableOrdersScreen);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- Stat Card ---
  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.gray500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // --- Quick Action Tile ---
  Widget _buildQuickActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gray200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.gray700, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.gray500),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}

