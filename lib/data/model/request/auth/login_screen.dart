import 'package:canary_app/core/components/custom_text_field.dart';
import 'package:canary_app/core/components/spaces.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(170),
                Text(
                  "SELAMAT DATANG KEMBALI",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  const SpaceHeight(30),
                  CustomTextField(
                    validator:'email tidak boleh kosong',
                    controller: emailController,
                    label: 'Email',
                    prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.email),
                  ),
                  ),
              ],
            ),
            )
        )
      )
    );
  }
}