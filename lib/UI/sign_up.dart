import 'package:flutter/material.dart';
import 'intro.dart';
import 'sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  String _username = '';

  String? _validateEmail(String? value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    const pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long\nand include at least one letter, one number,\nand one special character';
    }
    return null;
  }

  String? _validateName(String? value) {
    const pattern = r'^[A-Z][a-zA-Z ]*$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Name must contain only alphabets\nand start with a capital letter';
    }
    return null;
  }

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print(userCredentials);

      // Navigate to intro page and pass the username
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IntroPage(username: _username),
        ),
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email is already in use'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sign_up.png"), // Ensure you have the background image in the assets directory
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(17.0, 40.0, 17.0, 40.0), // Adjusted padding here
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Back button
                    IconButton(
                      iconSize: 30, // Enlarge the icon size
                      icon: const Icon(Icons.arrow_back, color: Colors.white70),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 200),
                    // Name input field
                    TextFormField(
                      controller: _nameController,
                      onChanged: (value) {
                        _username = value; // Update username as user types
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.grey.shade700),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: _validateName,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    // Email input field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey.shade700),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: _validateEmail,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    // Password input field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey.shade700),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: _validatePassword,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20),
                    // Confirm Password input field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.grey.shade700),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade700),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    const SizedBox(height: 30),
                    // Sign Up button
                    Center(
                      child: SizedBox(
                        width: double.infinity, // Make button take full width
                        height: 60, // Increase height of the button
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20, fontFamily: 'Lexend'), // Apply Lexend font
                            foregroundColor: Colors.white, // Text color
                            backgroundColor: Colors.redAccent.shade700, // Background color
                          ),
                          onPressed: _submit,
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Bottom text
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // Navigate to the sign-in page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Already have an account? Log in',
                          style: TextStyle(color: Colors.redAccent.shade700, fontSize: 12, fontFamily: 'Lexend'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
