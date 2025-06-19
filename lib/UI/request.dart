import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart';
import 'donation.dart';
import 'home.dart';
import 'blood_bank_display.dart';
import 'blood_facts.dart';

class BloodRequestForm extends StatefulWidget {
  const BloodRequestForm({super.key});

  @override
  _BloodRequestFormState createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<BloodRequestForm> {
  final _formKey = GlobalKey<FormState>();

  String _patientName = '';
  String _age = '';
  String _gender = 'Male';
  String _patientID = '';
  String _bloodGroup = 'A+';
  String _physicianName = '';
  String _department = '';
  String _physicianContact = '';
  String _hospitalDetails = '';
  final List<String> _bloodComponents = [];
  int _quantity = 1;
  String _diagnosis = '';
  String _additionalDetails = '';
  bool _consent = false;
  String _comments = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), // Reduced height of the app bar
        child: AppBar(
          backgroundColor: Colors.red.shade900,
          centerTitle: true,
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
                  MaterialPageRoute(builder: (context) => const MyProfile()), // Navigate to BloodRequestForm page
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text('Blood Donation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Donate()), // Navigate to BloodRequestForm page
                ); // Navigate to donation.dart
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
                }
            ),
            ListTile(
              leading: const Icon(Icons.home), // Icon for Home Page
              title: const Text('Home Page'), // Text for Home Page
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()), // Navigate to BloodRequestForm page
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white70,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.red.shade900,
                      child: const Center(
                        child: Text(
                          'Blood Request Form',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField('Full Name', Icons.person, (value) => _patientName = value, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Full Name';
                      }
                      if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                        return 'Name must contain only letters';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildTextField('Age', Icons.calendar_today, (value) => _age = value, keyboardType: TextInputType.number, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Age';
                      }
                      if (!RegExp(r"^\d+$").hasMatch(value) || int.parse(value) <= 0) {
                        return 'Age must be a positive number';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildDropdown('Gender', Icons.wc, ['Male', 'Female', 'Other'], _gender, (value) => setState(() => _gender = value!)),
                    const SizedBox(height: 16),
                    _buildTextField('Patient ID', Icons.format_list_numbered, (value) => _patientID = value, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Patient ID';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildDropdown('Blood Group', Icons.opacity, ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], _bloodGroup, (value) => setState(() => _bloodGroup = value!)),
                    const SizedBox(height: 16),
                    _buildTextField('Physician Name', Icons.person_outline, (value) => _physicianName = value, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Physician Name';
                      }
                      if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                        return 'Name must contain only letters';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildTextField('Department', Icons.work, (value) => _department = value, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Department';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildTextField('Physician Contact', Icons.contact_phone, (value) => _physicianContact = value, keyboardType: TextInputType.phone, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Physician Contact';
                      }
                      if (!RegExp(r"^\d{10}$").hasMatch(value)) {
                        return 'Contact must be a 10-digit number';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildTextField('Hospital/Clinic Details', Icons.local_hospital, (value) => _hospitalDetails = value, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Hospital/Clinic Details';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildCheckboxList('Type of Blood Component', [
                      'Whole Blood',
                      'RBCs',
                      'Platelets',
                      'Plasma',
                      'Cryoprecipitate'
                    ]),
                    const SizedBox(height: 16),
                    _buildTextField('Quantity (in ml)', Icons.format_list_numbered, (value) => _quantity = int.tryParse(value) ?? 1, keyboardType: TextInputType.number, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Quantity';
                      }
                      if (!RegExp(r"^\d+$").hasMatch(value) || int.parse(value) <= 0) {
                        return 'Quantity must be a positive number';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildTextField('Diagnosis', Icons.local_hospital, (value) => _diagnosis = value, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Diagnosis';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16),
                    _buildTextField('Additional Details (e.g., Surgery, Transfusions, Special Requirements)', Icons.local_hospital, (value) => _additionalDetails = value),
                    const SizedBox(height: 16),
                    _buildConsentCheckbox(),
                    const SizedBox(height: 16),
                    _buildTextField('Comments', Icons.comment, (value) => _comments = value),
                    const SizedBox(height: 32), // Adjust the bottom padding to make space for the submit button
                    _buildSubmitButton(), // Add the submit button within the scrollable area
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData icon, Function(String) onChanged, {TextInputType keyboardType = TextInputType.text, FormFieldValidator<String>? validator}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Grey underline
        ),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildDropdown(String labelText, IconData icon, List<String> items, String value, ValueChanged<String?> onChanged) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Grey underline
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCheckboxList(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...options.map((option) => CheckboxListTile(
          title: Text(option),
          value: _bloodComponents.contains(option),
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _bloodComponents.add(option);
              } else {
                _bloodComponents.remove(option);
              }
            });
          },
        )),
      ],
    );
  }

  Widget _buildConsentCheckbox() {
    return CheckboxListTile(
      title: const Text('I confirm that I have obtained consent from the patient or their representative to collect and transfuse blood as necessary.'),
      value: _consent,
      onChanged: (bool? value) {
        setState(() {
          _consent = value ?? false;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        width: double.infinity, // Make the button wide
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade900, // Red background color
            foregroundColor: Colors.white, // White text color
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Make the button rectangular
            ),
            padding: const EdgeInsets.symmetric(vertical: 13.0), // Make the button a little longer
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (!_consent) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please confirm consent to proceed')),
                );
                return;
              }

              _fetchBloodBankData(_bloodGroup);
            }
          },
          child: const Text('Submit',style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  void _fetchBloodBankData(String bloodGroup) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('blood_data').get();

    final List<Map<String, dynamic>> bloodBanks = querySnapshot.docs.map((doc) {
      return {
        'name': doc.id,
        'data': doc.data() as Map<String, dynamic>,
      };
    }).toList();

    final List<Map<String, dynamic>> availableBloodBanks = bloodBanks.where((bloodBank) {
      return bloodBank['data'][bloodGroup] != null && bloodBank['data'][bloodGroup] >= _quantity;
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BloodBankDisplay(
          bloodGroup: bloodGroup,
          quantity: _quantity,
          availableBloodBanks: availableBloodBanks,
        ),
      ),
    );
  }
}
