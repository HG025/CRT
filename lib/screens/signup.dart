import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crp/screens/customValidations.dart';
import 'package:crp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_auth/email_auth.dart';

import 'package:email_otp/email_otp.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    super.initState();
    emailOTP = EmailOTP();
  }

  late EmailOTP emailOTP;
  bool submitValid = false;
  late EmailAuth emailAuth;
  void sendOTP() async {
    String email = UserEmailController.text;

    bool result = await EmailOTP.sendOTP(
      email: email,
      // otpLength: 5,
      // otpType: OTPType.numeric, // You can change it to alphanumeric if needed
    );

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("OTP sent to $email"),
      ));
      print("OTP SENT");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to send OTP"),
      ));
      print("OTP NOT SENT");
    }
  }

  void verifyOTP() {
    var isValid = emailAuth.validateOtp(
        recipientMail: UserEmailController.value.text,
        userOtp: UserOTPController.value.text);

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("OTP Verified"),
      ));
      print("OTP VERIFIED");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid OTP"),
      ));
      print("Invalid OTP");
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController UserNameController = TextEditingController();
  final TextEditingController UserEmailController = TextEditingController();
  final TextEditingController UserOTPController = TextEditingController();
  final TextEditingController UserPasswordController = TextEditingController();
  final TextEditingController UserConfirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    UserNameController.dispose();
    UserEmailController.dispose();
    UserOTPController.dispose();
    UserPasswordController.dispose();
    UserConfirmPasswordController.dispose();
    super.dispose();
  }

  void signed() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final String username = UserNameController.text;
    final String email = UserEmailController.text;
    final String otp = UserOTPController.text;
    final String password = UserPasswordController.text;
    final String ConfPass = UserConfirmPasswordController.text;

    if (_formKey.currentState!.validate()) {
    } else {
      print("error");
    }

    try {
      UserNameController.clear();
      UserEmailController.clear();
      UserPasswordController.clear();
      UserOTPController.clear();
      UserConfirmPasswordController.clear();
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user != null;
      await db
          .collection("Users")
          .doc(user.user?.uid)
          .set({"username": username, "email": email, "password": password});

      print("Registered Data + Username " +
          username +
          password +
          ConfPass +
          email);
      Fluttertoast.showToast(msg: "User Register Successfully", fontSize: 15);
    } catch (e) {
      print("error while register user");
      Fluttertoast.showToast(msg: "User Register Failed", fontSize: 15);
    }
  }

  // String? _verificationId;
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _otpController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _login(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Image.asset(
          'lib/assets/CRT-logo.png', // Make sure the path is correct
          width: 100,
          height: 100,
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: UserNameController,
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: const Color.fromARGB(255, 199, 190, 190),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
          validator: validateUsername,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: UserEmailController,
                decoration: InputDecoration(
                  hintText: 'abc@gmail.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: const Color.fromARGB(255, 199, 190, 190),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
            ),
            TextButton(
              onPressed: sendOTP,
              child: const Text(
                "Send OTP",
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: UserOTPController,
                decoration: InputDecoration(
                  hintText: "OTP ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: const Color.fromARGB(255, 199, 190, 190),
                  filled: true,
                  prefixIcon: const Icon(Icons.message),
                ),
                validator: validateOTP,
              ),
            ),
            TextButton(
              onPressed: () => verifyOTP,
              child: const Text(
                "Verify OTP",
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: UserPasswordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 199, 190, 190),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          validator: validatePassword,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: UserConfirmPasswordController,
          decoration: InputDecoration(
            hintText: "Confirm Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 199, 190, 190),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          validator: (value) {
            if (value != UserPasswordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: signed,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 1, 34, 3),
          ),
          child: const Text(
            "Register",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _login(context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Color.fromARGB(255, 1, 34, 3),
                ),
              ),
            ),
          ],
        ));
  }
}
