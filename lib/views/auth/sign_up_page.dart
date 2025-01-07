
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 80.0),
            child: Column(
              children: [
                Text(
                  "Sign Up",
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
                      width: 24,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffffffff).withOpacity(.70)),
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
                    width(8),
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                          color: const Color(0xffffffff).withOpacity(.70),
                          shape: BoxShape.circle),
                    )
                  ],
                )
              ],
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
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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
                            textAlign: TextAlign.center,
                          ),
                        ),
                        height(30),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "First Name",
                                    style: customTextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff686D76),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  height(6),
                                  TextFormField(
                                    controller:
                                        signUpController.firstNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter First Name';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            width(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Last Name",
                                    style: customTextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff686D76),
                                    ),
                                  ),
                                  height(6),
                                  TextFormField(
                                    controller:
                                        signUpController.lastNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Last Name';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        height(15),
                        Text(
                          "Mobile Number",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(6),
                        TextFormField(
                          controller: signUpController.contactController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7)),
                            suffixIcon: const Icon(Icons.phone_outlined),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.length > 10) {
                              signUpController.contactController.text =
                                  value.substring(0, 10);
                              signUpController.contactController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: signUpController
                                        .contactController.text.length),
                              );
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Mobile Number';
                            }
                            if (value.length < 10) {
                              return 'Mobile Number Must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        height(15),
                        Text(
                          "Email Address",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(6),
                        TextFormField(
                          controller: signUpController.emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email ';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                        height(15),
                        Text(
                          "Password",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(6),
                        TextFormField(
                          controller: signUpController.passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
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
                            // if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                            //     .hasMatch(value)) {
                            //   return 'Password must contain at least\n one special character';
                            // }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Confirm Password",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(6),
                        TextFormField(
                          controller:
                              signUpController.confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(), 
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                                child: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                )),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value !=
                                signUpController.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        height(30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: signUpController.isLoading.value
                                  ? null
                                  : () async {
                                      if (formKey.currentState!.validate()) {
                                        await signUpController.signUpForm();
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
                                () => signUpController.isLoading.value
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
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              )),
                        ),
                        height(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: customTextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff686D76)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.off(() => const SignInPage());
                              },
                              child: Text(
                                "Sign In",
                                style: customTextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppConstant.appMainColor),
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
          ),
        ],
      ),
    );
  }
}
