import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:registration_form/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String fullName = "";
  String eMail = "";
  String userName = "";
  var loginAt = "";
  bool loading = true;


  Future<void> _loginDetails() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      DocumentSnapshot loginDoc = await FirebaseFirestore.instance
          .collection('loginDetails')
          .doc(uid)
          .get();

      setState(() {
        // Either show their value or a placeholder
        fullName = (userDoc.exists && userDoc.data() != null)
            ? (userDoc['fullName'] ?? "No Name")
            : "No Name";
        eMail = (userDoc.exists && userDoc.data() != null)
            ? (userDoc['email'] ?? "No Email")
            : "No Email";
        userName = (userDoc.exists && userDoc.data() != null)
            ? (userDoc['username'] ?? "No Username")
            : "No Username";
        loginAt = (loginDoc.exists && loginDoc.data() != null)
            ? (loginDoc['loggedInAt']?.toDate().toString() ?? "No Login Time")
            : "No Login Time";
      });
      // Debug prints
      print("User data: ${userDoc.data()}");
      print("Login data: ${loginDoc.data()}");
    } on FirebaseAuth catch (e) {
      setState(() {
        fullName = "Error";
        eMail = "Error";
        userName = "Error";
        loginAt = "Error";
      });
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _loginDetails();
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to the Home Page",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: Divider(color: Colors.black, thickness: 2),
                ),
                SizedBox(height: 20),
                Text(
                  "Full Name: $fullName",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Email: $eMail",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Username: $userName",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Last Login At: $loginAt",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
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
