import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration_form/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.logout, color: Colors.black),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ),
          Center(
            child: Text(
              "Welcome to the Home Page",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      )
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         SizedBox(width: 20),
      //         Center(
      //           child: Text(
      //             "Welcome to the Home Page",
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontStyle: FontStyle.italic,
      //               fontWeight: FontWeight.bold,
      //               letterSpacing: 2,
      //             ),
      //           ),
      //         ),
      //          IconButton(
      //           onPressed: () async {
      //             await FirebaseAuth.instance.signOut();
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(builder: (context) => Login()),
      //             );
      //           },
      //           icon: Icon(Icons.logout, color: Colors.black),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
