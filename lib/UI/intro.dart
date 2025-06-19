import 'package:flutter/material.dart';
import 'home.dart';
import 'details_page.dart';
import 'donation.dart';
import 'request.dart'; // Import the request.dart file
import 'profile.dart'; // Import the details page

class IntroPage extends StatelessWidget {
  final String username; // Declare username variable

  // Constructor to receive username
  const IntroPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),backgroundColor: Colors.grey,// Set app bar title
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red.shade900,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to ProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()  ),
                );// Close drawer
              },
            ),
            ListTile(
              leading:const  Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to ProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Blood Need'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to Donate page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Donate()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text('Blood Request'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to BloodRequestForm page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BloodRequestForm()),
                );
              },
            ),
            ListTile(
              leading:const  Icon(Icons.fact_check),
              title:const Text('Blood Facts'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to Blood Facts page
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/intro.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome,',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Lexend', // Lexend font
                ),
              ),
              const  SizedBox(height: 10), // Adjust spacing as needed
              Text(
                username,
                style:const  TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Lexend', // Lexend font
                ),
              ),
              const  SizedBox(height: 10), // Adjust spacing as needed
              const Text(
                "Now let's get started with your profile",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Lexend', // Lexend font
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to the details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailsPage()),
                  );
                },
                child: Container(
                  padding:const  EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade700, // Red color for arrow background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:const  Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // White color for arrow icon
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
