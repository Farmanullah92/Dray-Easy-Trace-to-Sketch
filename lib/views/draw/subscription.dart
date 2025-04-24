import 'package:draw_easy/views/draw/subscription_options.dart';
import 'package:draw_easy/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade100, Colors.amber.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      'assets/icon/crowno.png',
                      height: 90,
                      color: Colors.amber.shade800,
                    ),
                    Text(
                      'Go Premium',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.7),
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: 20,
                      height: 24,
                      child: Icon(Icons.check, color: Colors.orange),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          'Access Premium Category',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: 20,
                      height: 24,
                      child: Icon(Icons.check, color: Colors.orange),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          'Access Advanced level enhancer',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: 20,
                      height: 24,
                      child: Icon(Icons.check, color: Colors.orange),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          'Ad-free experience',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: 20,
                      height: 24,
                      child: Icon(Icons.check, color: Colors.orange),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          'Remove watermark',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            SubscriptionOptions(),

            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () {},
                leading: Image.asset('assets/icon/crowno.png', height: 30),
                title: Text(
                  'Lifetime',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  'RS 3,250.00',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 17),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () {},
                backgroundColor: Colors.black54,
                elevation: 10,
                child: Text('Subscribe Now', style: TextStyle(fontSize: 20)),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Restore Purchase',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),

            Column(
              children: [
                const Text(
                  'Subscription will auto-renew. You can manage or cancel it anytime from your Google Play account settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle privacy policy
                      },
                      child: const Text(
                        'Politica de privacidade',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                    const Text(
                      ' | ',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle Google Play subscriptions info
                      },
                      child: const Text(
                        'Google Play Subscriptions',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
