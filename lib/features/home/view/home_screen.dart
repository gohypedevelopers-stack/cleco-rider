import 'package:cleclo_rider/components/custom_appbar.dart';
import 'package:cleclo_rider/routes/route_constants.dart';
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
      appBar: CustomAppBar(
        logo: false, // Or true if you want logo
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
             backgroundColor: AppColors.primary,
             child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        title: 'Hi, Ravindra',
        showBackButton: false,
        actions: [
          Switch(
            value: isOnline,
            onChanged: (val) {
              setState(() {
                isOnline = val;
              });
            },
            activeColor: AppColors.riderGreen,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isOnline ? AppColors.riderGreen.withOpacity(0.1) : AppColors.gray200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isOnline ? AppColors.riderGreen : AppColors.gray400,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isOnline ? Icons.check_circle : Icons.offline_bolt,
                    color: isOnline ? AppColors.riderGreen : AppColors.gray500,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isOnline ? 'You are Online' : 'You are Offline',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isOnline ? AppColors.riderGreen : AppColors.gray600,
                    ),
                  ),
                  const Spacer(),
                  if (isOnline)
                    const Text(
                      'Waiting for orders...',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: AppColors.gray500,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Row
            Row(
              children: [
                _buildStatCard('Orders', '12', Icons.shopping_bag_outlined, Colors.blue),
                const SizedBox(width: 16),
                _buildStatCard('Earnings', '₹850', Icons.attach_money, Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                 _buildStatCard('Distance', '45 km', Icons.directions_bike, Colors.orange),
                 const SizedBox(width: 16),
                 _buildStatCard('Rating', '4.8', Icons.star, Colors.amber),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Available Orders Button (Functionality Placeholder)
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                   context.push(RouteConstants.availableOrdersScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text('View Available Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.gray500,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) context.push(RouteConstants.activeOrdersScreen);
          if (index == 2) context.push(RouteConstants.profileScreen);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(0.05),
               blurRadius: 10,
               offset: const Offset(0, 4),
             ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
