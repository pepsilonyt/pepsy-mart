import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle),
                  child: const Icon(Icons.person, size: 40, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                const Text('Siddharth', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                const Text('+1 9876543210', style: TextStyle(color: AppTheme.textLight, fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSettingsTile(Icons.location_on_outlined, 'My Addresses', 'Manage delivery locations'),
          _buildSettingsTile(Icons.payment_outlined, 'Payment Methods', 'Credit cards, wallets'),
          _buildSettingsTile(Icons.local_offer_outlined, 'Offers & Promos', 'View available discounts'),
          _buildSettingsTile(Icons.support_agent_outlined, 'Help Center', 'Chat with support'),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.offerRed.withOpacity(0.5)),
            ),
            child: const Center(
              child: Text('LOG OUT', style: TextStyle(color: AppTheme.offerRed, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accentGreen),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.textLight)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textLight),
      ),
    );
  }
}
