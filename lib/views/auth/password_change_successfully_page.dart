
import 'package:bhatt_brahman_var_vadhu/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/text_style.dart';
import 'sign_in_page.dart';

class PasswordChangeSuccessfullyPage extends StatelessWidget {
  const PasswordChangeSuccessfullyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE94C22),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/change-password.png",
                width: 285,
                height: 291,
              ),
            ),
            height(40),
            Text(
              "Password changed \nsuccessfully",
              style: customTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffffffff)),
              textAlign: TextAlign.center,
            ),
            height(40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Get.to(() => const PasswordChangeSuccessfullyPage());
                  Get.offAll(() => const SignInPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "Continue",
                  style: customTextStyle(
                    fontSize: 20,
                    color: const Color(0xff29306E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
