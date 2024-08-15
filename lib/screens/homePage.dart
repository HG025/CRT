import 'dart:async';
import 'dart:io';
import 'package:crp/screens/customValidations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool? isConnected;
  late Timer _timer;

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('huzaifa.com');
      if (response.isNotEmpty) {
        setState(() {
          isConnected = true;
        });
      }
    } on SocketException catch (err) {
      setState(() {
        isConnected = false;
      });
      if (kDebugMode) {
        print(err);
      }
    }

    try {
      if (isConnected == true) {
        _timer = Timer(const Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const Login())));
        });
      } else {
        const NoInternetDialog();
      }
    } catch (e) {
      const NoInternetDialog();
    }

    try {
      if (isConnected == true) {
        setState(() {
          const Login();
        });
      }
    } catch (e) {
      const Text("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/CRT-logo.png', // Make sure the path is correct
              width: 100,
              height: 100,
            ),
            SizedBox(height: 90),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Loading, please wait...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
