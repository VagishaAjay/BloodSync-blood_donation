import 'package:flutter/material.dart';

class BloodFactsPage extends StatelessWidget {
  const BloodFactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blood Facts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.red.shade900,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              factWidget(1, 'Your blood makes up about 8% of your body weight.'),
              factWidget(2, 'The rarest blood type in the world is Rh-null, also known as "golden blood."'),
              factWidget(3, 'The human body contains about 5 liters (8 pints) of blood.'),
              factWidget(4, 'A single donation can save up to three lives.'),
              factWidget(5, 'People with O-negative blood are universal donors.'),
              factWidget(6, 'Blood is made up of four main components: red blood cells, white blood cells, plasma, and platelets.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget factWidget(int number, String fact) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.red.shade900,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              fact,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                height: 1.4, // Reduce the line height to decrease line spacing
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
