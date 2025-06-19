import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'request.dart';
import 'blood_facts.dart';
import 'profile.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  final _formKey = GlobalKey<FormState>();
  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedBloodGroup;
  String? selectedGender;
  DateTime? selectedDate;
  DateTime? lastDonationDate;
  String? selectedBloodBank;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bpController = TextEditingController();
  final TextEditingController _pulseController = TextEditingController();
  final TextEditingController _haemoglobinController = TextEditingController();
  final TextEditingController _lastDonationDateController = TextEditingController();

  // Checkboxes
  Map<String, bool> recentHistory = {
    'Surgery': false,
    'Tattoo': false,
    'Blood Transfusion': false,
  };

  Map<String, bool> ailments = {
    'Diabetes': false,
    'Hypertension': false,
    'Heart Disease': false,
    'Asthma': false,
    'Cancer': false,
    'Epilepsy': false,
    'HIV/AIDS': false,
    'Hepatitis': false,
  };

  List<String> bloodBanks = [
    'Red Cross Blood Bank',
    'City Hospital Blood Bank',
    'Community Blood Center',
    'Unity Blood Services',
    'Hope Blood Bank',
    'Angel Blood Bank',
    'Lifeblood Center',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), // Reduced height of the app bar
        child: AppBar(
          backgroundColor: Colors.red.shade900,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
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
                  MaterialPageRoute(builder: (context) => const MyProfile()), // Navigate to MyProfile page
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text('Blood Donation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Donate()), // Navigate to Donate page
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.request_page), // Icon for Blood Request
              title: const Text('Blood Request'), // Text for Blood Request
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BloodRequestForm()), // Navigate to BloodRequestForm page
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.fact_check),
              title: const Text('Blood Facts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BloodFactsPage()), // Navigate to BloodRequestForm page
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home), // Icon for Home Page
              title: const Text('Home Page'), // Text for Home Page
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white70, // Slightly lighter red background
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.red.shade900,
                        child: const Center(
                          child: Text(
                            'Donation Form',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontFamily: 'roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextFieldWithIcon('Name', Icons.person, _nameController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      }),
                      const SizedBox(height: 16),
                      _buildTextFieldWithIcon('Age', Icons.cake, _ageController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        if (!RegExp(r'^[1-9][0-9]?$|^150$').hasMatch(value)) {
                          return 'Please enter a valid age (1-150)';
                        }
                        return null;
                      }),
                      const SizedBox(height: 16),
                      _buildTextFieldWithIcon('Phone no', Icons.phone, _phoneController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      }),
                      const SizedBox(height: 16),
                      _buildTextFieldWithIcon('Location', Icons.location_on, _locationController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your location';
                        }
                        return null;
                      }),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedBloodGroup,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBloodGroup = newValue;
                          });
                        },
                        items: bloodGroups.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Blood Group',
                          labelStyle: TextStyle(color: Colors.red.shade900),
                          border: const UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your blood group';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 17),
                      Column(
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 16,
                            ),
                          ),
                          Column(
                            children: [
                              RadioListTile<String>(
                                title: const Text('Male', style: TextStyle(fontSize: 14)),
                                value: 'Male',
                                groupValue: selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Female', style: TextStyle(fontSize: 14)),
                                value: 'Female',
                                groupValue: selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('Other', style: TextStyle(fontSize: 14)),
                                value: 'Other',
                                groupValue: selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextFieldWithIcon('Weight (kg)', Icons.monitor_weight, _weightController, (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your weight';
                              }
                              if (!RegExp(r'^[1-9][0-9]?$|^100$').hasMatch(value)) {
                                return 'Please enter a valid weight (1-100 kg)';
                              }
                              return null;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextFieldWithIcon('BP (mmHg)', Icons.favorite, _bpController, (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your blood pressure';
                              }
                              if (!RegExp(r'^\d{2,3}\/\d{2,3}$').hasMatch(value)) {
                                return 'Please enter a valid blood pressure (e.g., 120/80)';
                              }
                              return null;
                            }),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextFieldWithIcon('Pulse', Icons.monitor_heart, _pulseController, (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your pulse rate';
                              }
                              if (!RegExp(r'^[1-9][0-9]?$|^150$').hasMatch(value)) {
                                return 'Please enter a valid pulse rate (1-150)';
                              }
                              return null;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildTextFieldWithIcon('Haemoglobin (g/dL)', Icons.opacity, _haemoglobinController, (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your haemoglobin level';
                        }
                        if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
                          return 'Please enter a valid haemoglobin level (e.g., 12.5)';
                        }
                        return null;
                      }),
                      const SizedBox(height: 16),
                      _buildDateTextField('Last Donation Date', _lastDonationDateController, (value) {
                        // No need to validate here
                        return null;
                      }),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'In the last six months,have you had ?',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red.shade900),
                        ),
                      ),
                     // Text('In the last six months,have you had ?', style: TextStyle(fontSize: 16, color:Colors.red.shade900)), // Added text before recentHistory list
                      Column(
                        children: recentHistory.keys.map((String key) {
                          return CheckboxListTile(
                            title: Text(key),
                            value: recentHistory[key],
                            onChanged: (bool? value) {
                              setState(() {
                                recentHistory[key] = value ?? false;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Do You suffer from any Ailments?',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red.shade900),
                        ),
                      ),
                     // Text('Do You suffer from any Ailments?', style: TextStyle(fontSize: 16, color:Colors.red.shade900)), // Added text before ailments list
                      Column(
                        children: ailments.keys.map((String key) {
                          return CheckboxListTile(
                            title: Text(key),
                            value: ailments[key],
                            onChanged: (bool? value) {
                              setState(() {
                                ailments[key] = value ?? false;
                              });
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedBloodBank,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBloodBank = newValue;
                          });
                        },
                        items: bloodBanks.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Blood Bank',
                          labelStyle: TextStyle(color: Colors.red.shade900),
                          border: const UnderlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a blood bank';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            if (_validateDonationCriteria()) {
                              _submitForm();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Your donation details have been Accepted !')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Your donation details do not meet the criteria.')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900, // Background color
                          foregroundColor: Colors.white, // Text color
                          padding: EdgeInsets.zero, // Remove padding
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Make the button rectangular
                          ),
                        ),
                        child: Container(
                          height: 55,
                          alignment: Alignment.center,
                          child: const Text('SUBMIT', style: TextStyle(fontSize: 18)), // Adjust text style if needed
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithIcon(String label, IconData icon, TextEditingController controller, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.red.shade900),
        border: const UnderlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildDateTextField(String label, TextEditingController controller, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(controller),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.calendar_today, color: Colors.red.shade900),
        border: const UnderlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = '${picked.day}/${picked.month}/${picked.year}';
        if (controller == _lastDonationDateController) {
          lastDonationDate = picked;
        }
      });
    }
  }

  bool _validateDonationCriteria() {
    final int age = int.tryParse(_ageController.text) ?? 0;
    final int weight = int.tryParse(_weightController.text) ?? 0;
    final double haemoglobin = double.tryParse(_haemoglobinController.text) ?? 0;
    final bool hasRecentHistory = recentHistory.values.any((value) => value);
    final bool hasAilments = ailments.values.any((value) => value);

    final DateTime today = DateTime.now();
    final int daysSinceLastDonation = lastDonationDate != null ? today.difference(lastDonationDate!).inDays : 0;

    return age >= 18 && age <= 65 &&
        weight >= 50 &&
        haemoglobin >= 12.5 &&
        !hasRecentHistory &&
        !hasAilments &&
        (lastDonationDate == null || daysSinceLastDonation >= 90);
  }

  void _submitForm() {
    final donorData = {
      'name': _nameController.text,
      'age': int.tryParse(_ageController.text),
      'phone': _phoneController.text,
      'location': _locationController.text,
      'bloodGroup': selectedBloodGroup,
      'gender': selectedGender,
      'weight': int.tryParse(_weightController.text),
      'bp': _bpController.text,
      'pulse': _pulseController.text,
      'haemoglobin': _haemoglobinController.text,
      'lastDonationDate': lastDonationDate?.toIso8601String(),
      'recentHistory': recentHistory,
      'ailments': ailments,
      'bloodBank': selectedBloodBank,
    };

    String bloodBankCollection = '';
    if (selectedBloodBank == 'Red Cross Blood Bank') {
      bloodBankCollection = 'red_cross_donors';
    } else if (selectedBloodBank == 'City Hospital Blood Bank') {
      bloodBankCollection = 'city_hospital_donors';
    } else if (selectedBloodBank == 'Community Blood Center') {
      bloodBankCollection = 'community_blood_center_donors';
    } else if (selectedBloodBank == 'Unity Blood Services') {
      bloodBankCollection = 'unity_blood_services_donors';
    } else if (selectedBloodBank == 'Hope Blood Bank') {
      bloodBankCollection = 'hope_blood_bank_donors';
    } else if (selectedBloodBank == 'Angel Blood Bank') {
      bloodBankCollection = 'angel_blood_bank_donors';
    } else if (selectedBloodBank == 'Lifeblood Center') {
      bloodBankCollection = 'lifeblood_center_donors';
    }

    // Send donor data to the main donations collection
    FirebaseFirestore.instance.collection('donations').add(donorData).then((value) {
      // Send donor data to the specific blood bank collection
      if (bloodBankCollection.isNotEmpty) {
        FirebaseFirestore.instance.collection(bloodBankCollection).add(donorData).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Donation data submitted successfully to $selectedBloodBank')),
          );
          _formKey.currentState!.reset();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit donation data to blood bank: $error')),
          );
        });
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit donation data: $error')),
      );
    });
  }

}
