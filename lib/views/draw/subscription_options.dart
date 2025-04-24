import 'package:flutter/material.dart';

class SubscriptionOptions extends StatefulWidget {
  const SubscriptionOptions({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SubscriptionOptionsState createState() => _SubscriptionOptionsState();
}

class _SubscriptionOptionsState extends State<SubscriptionOptions> {
  int selectedIndex = -1;

  List<Map<String, dynamic>> plans = [
    {
      'image': 'assets/icon/crownb.png',
      'label': 'Weekly',
      'price': 'Rs 330.00',
    },
    {
      'image': 'assets/icon/crownw.png',
      'label': 'Monthly',
      'price': 'Rs 330.00',
    },
    {'image': 'assets/icon/crowno.png', 'label': 'Year', 'price': 'Rs 330.00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(plans.length, (index) {
        bool isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 2,
                color: isSelected ? Colors.grey.shade300 : Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(plans[index]['image'], height: 50),
                Text(
                  plans[index]['label'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Rs 330.00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
