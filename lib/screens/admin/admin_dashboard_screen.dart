import 'package:flutter/material.dart';
import '../../theme.dart';
import 'manage_orders_screen.dart';
import 'manage_inventory_screen.dart';
import 'manage_products_screen.dart';
import '../login_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  Widget _buildAdminDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1E293B),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF0F172A)),
            accountName: Text('Store Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            accountEmail: Text('Manager Role', style: TextStyle(color: Colors.white70)),
            currentAccountPicture: CircleAvatar(backgroundColor: AppTheme.accentGreen, child: Icon(Icons.shield, color: Colors.white)),
          ),
          ListTile(leading: const Icon(Icons.dashboard, color: Colors.white), title: const Text('Dashboard', style: TextStyle(color: Colors.white)), onTap: () => Navigator.pop(context)),
          ListTile(leading: const Icon(Icons.add_box, color: Colors.white), title: const Text('Add Product', style: TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageProductsScreen())); }),
          ListTile(leading: const Icon(Icons.inventory_2, color: Colors.white), title: const Text('Inventory', style: TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageInventoryScreen())); }),
          ListTile(leading: const Icon(Icons.list_alt, color: Colors.white), title: const Text('Live Orders', style: TextStyle(color: Colors.white)), onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageOrdersScreen())); }),
          ListTile(leading: const Icon(Icons.people, color: Colors.white), title: const Text('Customers', style: TextStyle(color: Colors.white)), onTap: () {}),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Slightly darker background for Admin
      drawer: _buildAdminDrawer(context),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B), // Dark Slate AppBar
        title: const Text('Admin Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppTheme.offerRed),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
            tooltip: 'Log Out to Customer View',
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Store Metrics Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Today\'s Revenue', '\$4,120.50', Icons.attach_money, AppTheme.accentGreen)),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Active Orders', '14', Icons.local_shipping, const Color(0xFF3B82F6))), // Blue
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Out of Stock', '3 Items', Icons.warning_amber_rounded, AppTheme.offerRed)),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Avg. Delivery', '7m 42s', Icons.timer, const Color(0xFF8B5CF6))), // Purple
              ],
            ),
            const SizedBox(height: 32),
            const Text('Control Panel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 16),
            _buildActionTile(context, 'Live Fulfillment', 'Accept and pack current orders', Icons.assignment_outlined, const ManageOrdersScreen()),
            const SizedBox(height: 12),
            _buildActionTile(context, 'Inventory Management', 'Toggle stock status of products', Icons.inventory_2_outlined, const ManageInventoryScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, String title, String subtitle, IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: const Color(0xFF334155), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
