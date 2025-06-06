// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:canary_app/data/model/request/auth/login_request_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canary_app/core/components/custom_text_field.dart';
import 'package:canary_app/core/components/spaces.dart';
import 'package:canary_app/core/core.dart';
import 'package:canary_app/presentation/auth/bloc/login_bloc.dart';

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

                  const SpaceHeight(25),
                  CustomTextField(
                  validator: 'Password tidak boleh kosong',
                  controller: passwordController,
                  label: 'Password',
                  obscureText: !isShowPassword,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    icon: Icon(
                      isShowPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SpaceHeight(30),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    } else if (state is LoginSuccess) {
                      final role = state.responseModel.user?.role
                          ?.toLowerCase();
                      if (role == "admin") {
                        context.pushAndRemoveUntil(
                          const AdminConfirmScreen(),
                          (route) => false,
                        );
                      } else if (role == "buyer") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.responseModel.message!)),
                        );
                        context.pushAndRemoveUntil(
                          const BuyerProfileScreen(),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Role tidak dikenali")),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return Button.filled(
                      onPressed: state is LoginLoading
                          ? null
                          : () {
                              if (_key.currentState?.validate() ?? false) {
                                final requestModel = LoginRequestModel(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                context.read<LoginBloc>().add(
                                  LoginRequested(requestModel: requestModel),
                                );
                              }
                            },
                      label: state is LoginLoading ? "Memuat..." : "Masuk",
                    );
                  },
                ),
                 const SpaceHeight(20),
                Text.rich(
                  TextSpan(
                    text: "Belum memiliki akun? Silahkan",
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                    children: [
                      TextSpan(
                        text: "Daftar Disini",
                        style: TextStyle(color: AppColors.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push(const RegisterScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ],    
            )
            )
        )
      )
    );
  }
}