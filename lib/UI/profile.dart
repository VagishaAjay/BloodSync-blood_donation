import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_profile.dart'; // Import the EditPage

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String _name = '';
  String _phoneNumber = '';
  String _location = '';
  String _dob = '';
  double _age = 0;
  double _weight = 0;
  String _bloodGroup = '';

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('profile').doc(user.uid).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        setState(() {
          _name = data['name'] ?? '';
          _phoneNumber = data['phone_number'] ?? '';
          _location = data['location'] ?? '';
          _dob = data['date_of_birth'] ?? '';
          _age = (data['age'] ?? 0).toDouble();
          _weight = (data['weight'] ?? 0).toDouble();
          _bloodGroup = data['blood_group'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Change back icon color
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black), // Change edit icon color
            onPressed: () async {
              // Navigate to the EditPage and wait for result
              final Map<String, dynamic>? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPage(
                    name: _name,
                    phoneNumber: _phoneNumber,
                    location: _location,
                    dob: _dob,
                    age: _age,
                    weight: _weight,
                    bloodGroup: _bloodGroup,
                  ),
                ),
              );

              // Update state with edited data if result is not null
              if (result != null) {
                setState(() {
                  _name = result['name'];
                  _phoneNumber = result['phoneNumber'];
                  _location = result['location'];
                  _dob = result['dob'];
                  _age = result['age'];
                  _weight = result['weight'];
                  _bloodGroup = result['bloodGroup'];
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity, // Make the container wide
            color: Colors.red.shade900, // Red box color
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust vertical padding
            child: const Center(
              child: Text(
                'Profile',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/intro.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0), // Reduce outer padding
                  child: Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40, // Reduce avatar size
                          backgroundImage: const AssetImage('assets/profile_icon.png'),
                        ),
                      ),
                      const SizedBox(height: 8), // Reduce space between avatar and name
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6), // Reduce padding
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _name.isNotEmpty ? _name : 'Loading...',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8), // Reduce space between name and info box
                      Container(
                        padding: const EdgeInsets.all(12.0), // Reduce inner padding
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow(Icons.phone, _phoneNumber.isNotEmpty ? _phoneNumber : 'Loading...'),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.location_on, _location.isNotEmpty ? _location : 'Loading...'),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.calendar_today, _dob.isNotEmpty ? _dob : 'Loading...'),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.cake, 'Age: ${_age > 0 ? _age.toString() : 'Loading...'}'),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.monitor_weight, 'Weight: ${_weight > 0 ? _weight.toString() : 'Loading...'} kg'),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.bloodtype, 'Blood Group: ${_bloodGroup.isNotEmpty ? _bloodGroup : 'Loading...'}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.black87, fontSize: 16), // Adjust font size
              ),
            ),
          ],
        ),
        const SizedBox(height: 4), // Reduce spacing after info row
        Container(
          height: 1,
          color: Colors.grey[300],
        ),
      ],
    );
  }
}
