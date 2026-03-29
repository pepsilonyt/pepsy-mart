import 'package:flutter/material.dart';
import '../../models.dart';
import '../../theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ManageInventoryScreen extends StatefulWidget {
  const ManageInventoryScreen({super.key});

  @override
  State<ManageInventoryScreen> createState() => _ManageInventoryScreenState();
}

class _ManageInventoryScreenState extends State<ManageInventoryScreen> {
  // This physically tracks our mock database out-of-stock items for the demo
  final Set<String> _outOfStockIds = {};

  void _toggleStock(String id) {
    setState(() {
      if (_outOfStockIds.contains(id)) {
        _outOfStockIds.remove(id);
      } else {
        _outOfStockIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Combine both mock lists just for a huge inventory viewer
    final allProducts = [...mockBestsellers, ...mockSnacks];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text('Inventory DB', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allProducts.length,
        itemBuilder: (context, index) {
          final p = allProducts[index];
          final isOOS = _outOfStockIds.contains(p.id);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isOOS ? Colors.red.withOpacity(0.05) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isOOS ? AppTheme.offerRed.withOpacity(0.3) : Colors.transparent),
            ),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: CachedNetworkImageProvider(p.imageUrl), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isOOS ? Colors.black54 : Colors.black87)),
                      const SizedBox(height: 4),
                      Text('Retail: \$${p.price.toStringAsFixed(2)}  •  ID: ${p.id}', style: const TextStyle(color: Colors.black54, fontSize: 12)),
                      if (isOOS)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text('OUT OF STOCK', style: TextStyle(color: AppTheme.offerRed, fontWeight: FontWeight.bold, fontSize: 10)),
                        )
                    ],
                  ),
                ),
                Switch(
                  value: !isOOS,
                  activeColor: AppTheme.accentGreen,
                  onChanged: (val) => _toggleStock(p.id),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
