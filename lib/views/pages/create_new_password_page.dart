import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';

class CreateNewPasswordPage extends StatelessWidget {
  CreateNewPasswordPage({super.key});

  final formKey = GlobalKey<FormState>();

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
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                "Change Password",
                style: customTextStyle(
                    fontSize: 16,
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
                      height(30),
                      Text(
                        "Current Password",
                        style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                      ),
                      height(6),
                      Container(
                        margin: const EdgeInsets.all(0),
                        width: Get.width,
                        child: Obx(
                          () => TextFormField(
                            controller: changePasswordController
                                .currentPasswordController,
                            obscureText: changePasswordController
                                .isNewPasswordVisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              errorStyle:
                                  customTextStyle(color: Colors.redAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xff8C8C8C), width: 2),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  changePasswordController.isNewPasswordVisible
                                      .toggle();
                                },
                                child: Icon(
                                  changePasswordController
                                          .isNewPasswordVisible.value
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
                        ),
                      ),
                      height(20),
                      const Divider(),
                      height(20),
                      Text(
                        "New Password",
                        style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                      ),
                      height(6),
                      Container(
                        margin: const EdgeInsets.all(0),
                        width: Get.width,
                        child: Obx(
                          () => TextFormField(
                            controller:
                                changePasswordController.newPasswordController,
                            obscureText: changePasswordController
                                .isNewPasswordVisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              errorStyle:
                                  customTextStyle(color: Colors.redAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xff8C8C8C), width: 2),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  changePasswordController.isNewPasswordVisible
                                      .toggle();
                                },
                                child: Icon(
                                  changePasswordController
                                          .isNewPasswordVisible.value
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
                        ),
                      ),
                      height(30),
                      Text(
                        "Confirm New Password",
                        style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                      ),
                      height(6),
                      Container(
                        margin: const EdgeInsets.all(0),
                        width: Get.width,
                        child: Obx(
                          () => TextFormField(
                            controller: changePasswordController
                                .confirmPasswordController,
                            obscureText: changePasswordController
                                .isConfirmPasswordVisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              errorStyle:
                                  customTextStyle(color: Colors.redAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xff8C8C8C), width: 2),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  changePasswordController
                                      .isConfirmPasswordVisible
                                      .toggle();
                                },
                                child: Icon(
                                  changePasswordController
                                          .isConfirmPasswordVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xff909090),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value !=
                                  changePasswordController
                                      .newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      height(40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              changePasswordController.changePassword();
                            }
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
            ),
          )
        ],
      ),
    );
  }
}
