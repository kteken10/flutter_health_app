// lib/Card.dart
import 'package:flutter/material.dart';
class CustomCard extends StatelessWidget {
  const CustomCard({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'predict a disease using the patient\'s clinical data.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/chemestry.png',
                    width: 180,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/robot.png',
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
