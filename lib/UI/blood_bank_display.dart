import 'package:flutter/material.dart';
import 'home.dart';

class BloodBankDisplay extends StatelessWidget {
  final String bloodGroup;
  final int quantity;
  final List<Map<String, dynamic>> availableBloodBanks;

  const BloodBankDisplay({
    super.key,
    required this.bloodGroup,
    required this.quantity,
    required this.availableBloodBanks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        iconTheme: const IconThemeData(color: Colors.white), // Set the back button color to white
      ),
      body: Column(
        children: [
          const SizedBox(height: 16), // Add space between the AppBar and the Container
          Container(
            width: double.infinity,
            color: Colors.red.shade900,
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: Text(
                'Available Blood Banks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: availableBloodBanks.length,
                itemBuilder: (context, index) {
                  final bloodBank = availableBloodBanks[index];
                  final bloodBankName = bloodBank['name'];
                  final bloodBankData = bloodBank['data'];
                  final bloodAvailable = bloodBankData[bloodGroup];
                  final bloodBankPhoneNumber = bloodBankData['phone_number'].toString(); // Convert to String

                  return Card(
                    child: ListTile(
                      title: Text(
                        bloodBankName,
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Available units of $bloodGroup: $bloodAvailable'),
                          const SizedBox(height: 4), // Add a little spacing
                          Row(
                            children: [
                              const Text('Contact: '),
                              SelectableText(
                                bloodBankPhoneNumber,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                toolbarOptions: const ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()), // Navigate to BloodRequestForm page
                  );
                }, // Navigate back to the previous page or HomePage
              child: const Text('Back to Home'),
            ),
          ),
        ],
      ),
    );
  }
}
