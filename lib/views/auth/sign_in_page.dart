import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import 'forgot_password_page.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE94C22),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80.0),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    "Sign In",
                    style: customTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  height(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                            color: const Color(0xffffffff).withOpacity(.70),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      width(8),
                      Container(
                        height: 7,
                        width: 24,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color(0xffffffff).withOpacity(.70)),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      width(8),
                      Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                            color: const Color(0xffffffff).withOpacity(.70),
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: Get.width * 0.9,
              height: Get.height * 0.015,
              decoration: BoxDecoration(
                  color: const Color(0xffffffff).withOpacity(.50),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
          ),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Enter your details below.",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff373A40)),
                          ),
                        ),
                        height(25),
                        Text(
                          "Email Address",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(6),
                        Container(
                          margin: const EdgeInsets.all(0),
                          width: Get.width,
                          child: TextFormField(
                            controller: signInController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelStyle: customTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorStyle:
                                  customTextStyle(color: Colors.redAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: signInController
                                          .emailError.value.isNotEmpty
                                      ? Colors.red
                                      : const Color(0xff8C8C8C),
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: signInController
                                          .emailError.value.isNotEmpty
                                      ? Colors.red
                                      : const Color(0xff8C8C8C),
                                  width: 2,
                                ),
                              ),
                              errorText:
                                  signInController.emailError.value.isNotEmpty
                                      ? signInController.emailError.value
                                      : null,
                              suffixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color(0xff909090),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        height(10),
                        Text(
                          "Password",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(6),
                        Container(
                          margin: const EdgeInsets.all(0),
                          width: Get.width,
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller:
                                      signInController.passwordController,
                                  obscureText:
                                      signInController.isPasswordVisible.value,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    labelStyle: customTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle: customTextStyle(
                                        color: Colors.redAccent),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: signInController
                                                .passwordError.value.isNotEmpty
                                            ? Colors.red
                                            : const Color(0xff8C8C8C),
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: signInController
                                                .passwordError.value.isNotEmpty
                                            ? Colors.red
                                            : const Color(0xff8C8C8C),
                                        width: 2,
                                      ),
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        signInController.isPasswordVisible
                                            .toggle();
                                      },
                                      child: Icon(
                                        signInController.isPasswordVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color(0xff909090),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters long';
                                    }
                                    if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                      return 'Password must contain at least one uppercase letter';
                                    }
                                    if (!RegExp(r'[a-z]').hasMatch(value)) {
                                      return 'Password must contain at least one lowercase letter';
                                    }
                                    if (!RegExp(r'\d').hasMatch(value)) {
                                      return 'Password must contain at least one digit';
                                    }
                                    return null;
                                  },
                                ),
                                if (signInController
                                    .passwordError.value.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      signInController.passwordError.value,
                                      style: customTextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: signInController.isRememberMe.value,
                              onChanged: (value) {
                                setState(() {
                                  signInController.isRememberMe.value =
                                      value ?? false;
                                });
                              },
                              activeColor: const Color(0xff9C9C9C),
                            ),
                            Text(
                              'Remember Me',
                              style: customTextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff686D76),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Get.to(() => const ForgotPasswordPage());
                              },
                              child: Text(
                                'Forgot Password?',
                                style: customTextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff686D76),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        height(30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: signInController.isLoading.value
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        signInController.loginUser();
                                      } else {
                                        log('[log] Form validation failed.');
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Obx(
                                () => signInController.isLoading.value
                                    ? const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CupertinoActivityIndicator(
                                              color: Colors.white),
                                          SizedBox(width: 10),
                                          Text(
                                            "Loading...",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Text(
                                        "Sign In",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              )),
                        ),
                        height(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account? ",
                              style: customTextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff686D76)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.off(() => const SignUpPage());
                              },
                              child: Text(
                                "Sign Up",
                                style: customTextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xffE94C22)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
