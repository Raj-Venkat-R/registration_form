import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:registration_form/home.dart';
import 'package:registration_form/registration_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController eMail = TextEditingController();
  TextEditingController password = TextEditingController();
  bool see = true;

  @override
  void dispose() {
    eMail.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: eMail.text.trim(),
        password: password.text.trim(),
      );
      FirebaseFirestore.instance
          .collection('loginDetails')
          .doc(credential.user!.uid)
          .set({
            'email': eMail.text.trim(),
            'loggedInAt': FieldValue.serverTimestamp(),
          });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Login Successful",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Login Here",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
              letterSpacing: 3,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Divider(color: Colors.black, thickness: 2),
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
              controller: eMail,
              decoration: InputDecoration(
                labelText: "Enter Your Email",
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
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
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
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              _login();
            },
            child: Text("Login", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistrationForm()),
              );
            },
            child: Text(
              "Don't have an account? Register here",
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
