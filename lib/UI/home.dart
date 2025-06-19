import 'package:flutter/material.dart';
import 'donation.dart';
import 'request.dart'; // Import the request.dart file
import 'profile.dart'; // Import the profile.dart file where ProfilePage is defined
import 'blood_facts.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key}); // GlobalKey for accessing Scaffold

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign GlobalKey to Scaffold
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
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()), // Navigate to ProfilePage
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.favorite),
              title:const  Text('Blood Donation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Donate()), // Navigate to Donate page
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text('Blood Request'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BloodRequestForm()), // Navigate to BloodRequestForm page
                );
              },
            ),
            ListTile(
                leading:const  Icon(Icons.fact_check),
                title: const Text('Blood Facts'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BloodFactsPage()), // Navigate to BloodRequestForm page
                  );
                }
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/home_2.png', // Ensure you have the background image in the assets directory
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () => _scaffoldKey.currentState?.openDrawer(), // Toggle the drawer
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyProfile()), // Navigate to ProfilePage
                        );
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_icon.png'), // Replace with your profile image asset
                        radius: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        side:const  BorderSide(color: Colors.white, width: 1), // White outline
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        textStyle: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Donate()), // Navigate to Donate page
                        );
                      },
                      icon: const Icon(Icons.favorite, color: Colors.white),
                      label: const Text('Blood Donation', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade900,
                        shape:const  RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        side: const BorderSide(color: Colors.white, width: 1), // White outline
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        textStyle: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BloodRequestForm()), // Navigate to BloodRequestForm page
                        );
                      },
                      icon: const Icon(Icons.bloodtype, color: Colors.white),
                      label: const Text('Blood Request', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
