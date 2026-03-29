import 'package:flutter/material.dart';
import '../../theme.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  State<ManageOrdersScreen> createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  // Mock states just to make the UI look alive when clicking buttons
  final List<Map<String, dynamic>> _mockLiveOrders = [
    {'id': '8942A', 'items': 4, 'total': 12.50, 'status': 'Pending', 'time': '1m ago', 'address': 'B-62, Sector 14'},
    {'id': '8943B', 'items': 1, 'total': 2.10, 'status': 'Pending', 'time': '3m ago', 'address': 'C-10, Rosewood'},
    {'id': '8939X', 'items': 12, 'total': 48.00, 'status': 'Packed', 'time': '6m ago', 'address': 'A-1, Silver City'},
  ];

  void _dispatchOrder(int index) {
    setState(() {
      _mockLiveOrders[index]['status'] = 'Dispatched';
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order dispatched to Rider!'), backgroundColor: AppTheme.accentGreen));
  }

  void _packOrder(int index) {
    setState(() {
      _mockLiveOrders[index]['status'] = 'Packed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Live Fulfillment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _mockLiveOrders.length,
        itemBuilder: (context, index) {
          final order = _mockLiveOrders[index];
          final isPending = order['status'] == 'Pending';
          final isPacked = order['status'] == 'Packed';
          final isDispatched = order['status'] == 'Dispatched';

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order #${order['id']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPending ? Colors.orange.withOpacity(0.1) : (isPacked ? Colors.blue.withOpacity(0.1) : Colors.green.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(
                          color: isPending ? Colors.orange : (isPacked ? Colors.blue : Colors.green),
                          fontWeight: FontWeight.bold, fontSize: 12
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('${order['items']} items • \$${order['total'].toStringAsFixed(2)}', style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.black54),
                    const SizedBox(width: 4),
                    Text('${order['address']}', style: const TextStyle(color: Colors.black54, fontSize: 13)),
                    const Spacer(),
                    Text('${order['time']}', style: const TextStyle(color: Colors.black38, fontSize: 12)),
                  ],
                ),
                const Divider(height: 32),
                
                // State Machine Buttons
                if (isDispatched) 
                  const Center(child: Text('On the way to customer 🏍️', style: TextStyle(color: AppTheme.accentGreen, fontWeight: FontWeight.bold)))
                else if (isPending)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      onPressed: () => _packOrder(index),
                      child: const Text('Accept & Pack Order', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                else if (isPacked)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      onPressed: () => _dispatchOrder(index),
                      child: const Text('Hand to Rider', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
