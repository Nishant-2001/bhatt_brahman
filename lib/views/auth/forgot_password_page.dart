import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import 'otp_verification_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE94C22),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        backgroundColor: const Color(0xFFE94C22),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Center(
              child: Text(
                "Forgot Password",
                style: customTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffffffff)),
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
              width: Get.width,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                    height(40),
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
                        controller: forgotPasswordController.emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorStyle: customTextStyle(color: Colors.redAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  color: Color(0xff8C8C8C), width: 2)),
                          suffixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xff909090),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    height(40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          forgotPasswordController.sendOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          "Continue",
                          style: customTextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
