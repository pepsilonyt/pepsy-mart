import 'package:flutter/material.dart';
import '../theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Text('Delivered', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold, fontSize: 10)),
                    ),
                    Text('Order #${28940 + index}', style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Farm Fresh Eggs, Toned Milk, Maggi + 4 items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Oct 24, 2023 at 10:42 AM', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
                    Text('\$14.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.black12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Text('Rate Order', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                        child: const Text('Reorder', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
