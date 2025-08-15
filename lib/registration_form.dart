import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:registration_form/login.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController eMail = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool see = true;
  bool see1 = true;

  @override
  void dispose() {
    fullName.dispose();
    eMail.dispose();
    userName.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (password.text.trim() != confirmPassword.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Passwrods do not match",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: eMail.text.trim(),
            password: password.text.trim(),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Registration Successful",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.green,
        ),
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
            'fullName': fullName.text.trim(),
            'email': eMail.text.trim(),
            'username': userName.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.message}", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Register Here",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontSize: 30,
              letterSpacing: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: Divider(color: Colors.black, thickness: 3),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2,
                fontStyle: FontStyle.normal,
              ),
              cursorColor: Colors.black,
              controller: fullName,
              decoration: InputDecoration(
                labelText: "Enter Your Name",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 63, 62, 62),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2,
                fontStyle: FontStyle.normal,
              ),
              cursorColor: Colors.black,
              controller: eMail,
              decoration: InputDecoration(
                labelText: "E-Mail",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 63, 62, 62),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: TextField(
              controller: userName,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2,
                fontStyle: FontStyle.normal,
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 63, 62, 62),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: TextField(
              obscureText: see,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2,
                fontStyle: FontStyle.normal,
              ),
              cursorColor: Colors.black,
              controller: password,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 63, 62, 62),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    see ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      see = !see;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: TextField(
              obscureText: see1,
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 2,
                fontStyle: FontStyle.normal,
              ),
              cursorColor: Colors.black,
              controller: confirmPassword,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 63, 62, 62),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    see1 ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      see1 = !see1;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              _register();
            },
            child: Text("Register", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text(
              "Already have an account? Login",
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
