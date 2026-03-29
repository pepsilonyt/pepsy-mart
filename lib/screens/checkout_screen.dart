import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/bouncy_scale.dart';
import 'home_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressController = TextEditingController(text: 'B-62, Sector 14, New Delhi');
  bool _isPlacingOrder = false;

  void _placeOrder() {
    setState(() => _isPlacingOrder = true);
    
    // Hard simulate instant network checkout success 
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      _showSuccessSheet();
    });
  }

  void _showSuccessSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: 400,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppTheme.accentGreen.withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_outline, color: AppTheme.accentGreen, size: 80),
            ),
            const SizedBox(height: 24),
            const Text('Order Placed Successfully!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 8),
            const Text('Arriving in 8 minutes', style: TextStyle(color: AppTheme.textLight, fontSize: 16)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentGreen, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomeScreen()), (r) => false);
                },
                child: const Text('Back to Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppTheme.textDark),
        centerTitle: true,
      ),
      body: _isPlacingOrder
        ? const Center(child: CircularProgressIndicator(color: AppTheme.accentGreen))
        : ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              const Text('Delivery Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black12)),
                child: TextField(
                  controller: _addressController,
                  maxLines: 2,
                  decoration: const InputDecoration(border: InputBorder.none, icon: Icon(Icons.location_on, color: AppTheme.accentGreen)),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.accentGreen.withOpacity(0.5))),
                child: RadioListTile(
                  value: true,
                  groupValue: true, // Default to true
                  onChanged: (val) {},
                  activeColor: AppTheme.accentGreen,
                  title: const Text('Cash / UPI on Delivery', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Pay instantly when the rider arrives', style: TextStyle(fontSize: 12)),
                  secondary: const Icon(Icons.money, color: AppTheme.accentGreen),
                ),
              ),
            ],
          ),
      bottomNavigationBar: _isPlacingOrder ? null : SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
          child: BouncyScale(
            onTap: _placeOrder,
            child: Container(
              height: 56,
              decoration: BoxDecoration(color: AppTheme.accentGreen, borderRadius: BorderRadius.circular(16)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text('Confirm Order', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
