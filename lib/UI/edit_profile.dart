import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditPage extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String location;
  final String dob;
  final double age;
  final double weight;
  final String bloodGroup;

  const EditPage({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.location,
    required this.dob,
    required this.age,
    required this.weight,
    required this.bloodGroup,
  });

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _dobController;

  late double age;
  late double weight;
  late String bloodGroup;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phoneNumber);
    _locationController = TextEditingController(text: widget.location);
    _dobController = TextEditingController(text: widget.dob);

    age = widget.age;
    weight = widget.weight;
    bloodGroup = widget.bloodGroup;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('profile').doc(user.uid).update({
          'name': _nameController.text,
          'phone_number': _phoneController.text,
          'location': _locationController.text,
          'date_of_birth': _dobController.text,
          'age': age,
          'weight': weight,
          'blood_group': bloodGroup,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pop(context, {
          'name': _nameController.text,
          'phoneNumber': _phoneController.text,
          'location': _locationController.text,
          'dob': _dobController.text,
          'age': age,
          'weight': weight,
          'bloodGroup': bloodGroup,
        }); // Pop the edit page after successful update and pass updated data back
      } catch (e) {
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.red.shade900,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white, // Set the background color of the body to white
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.red.shade900),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.red.shade900),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Colors.red.shade900),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Colors.red.shade900),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600), // Grey line
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Age',
                  style: TextStyle(color: Colors.black54),
                ),
                Slider(
                  value: age,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: age.round().toString(),
                  activeColor: Colors.red.shade900,
                  inactiveColor: Colors.red.shade100,
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
                Text(
                  'Selected Age: ${age.round()}',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Weight',
                  style: TextStyle(color: Colors.black54),
                ),
                Slider(
                  value: weight,
                  min: 0,
                  max: 200,
                  divisions: 200,
                  label: weight.round().toString(),
                  activeColor: Colors.red.shade900,
                  inactiveColor: Colors.red.shade100,
                  onChanged: (value) {
                    setState(() {
                      weight = value;
                    });
                  },
                ),
                Text(
                  'Selected Weight: ${weight.round()} kg',
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Blood Group',
                  style: TextStyle(color: Colors.black54),
                ),
                Wrap(
                  spacing: 8.0,
                  children: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                      .map((group) => ChoiceChip(
                    label: Text(group),
                    labelStyle: TextStyle(
                      color: bloodGroup == group
                          ? Colors.white
                          : Colors.red.shade900,
                    ),
                    selectedColor: Colors.red.shade900,
                    backgroundColor: Colors.white,
                    selected: bloodGroup == group,
                    onSelected: (selected) {
                      setState(() {
                        bloodGroup = group;
                      });
                    },
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.zero,
          color: Colors.red.shade900,
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero, // No padding
                backgroundColor: Colors.red.shade900,
                shape: const RoundedRectangleBorder(),
                fixedSize: Size.fromHeight(50),
              ),
              onPressed: _updateProfile,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
