import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/text_style.dart';
import '../auth/sign_in_page.dart';
import '../auth/sign_up_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedButton = "Sign In".obs;

    void updateSelectedButton(String button) {
      selectedButton.value = button;
    }

    return Scaffold(
      backgroundColor: const Color(0xffE94C22),
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height * 0.09,
            bottom: Get.height * 0.18,
            left: 16,
            right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top image
            Image.asset(
              "assets/var-vadhu.png",
              height: 270,
              width: 270,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: customTextStyle(
                      fontSize: 24,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600),
                ),
                Center(
                  child: Text(
                    "Unlock the door to your future—discover the one meant for you!",
                    style: customTextStyle(
                        fontSize: 14, color: const Color(0xffffffff)),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),

            // Buttons Section
            Column(
              children: [
                Obx(() {
                  return Container(
                    width: Get.width * 0.911,
                    height: Get.height * 0.070,
                    decoration: BoxDecoration(
                      color: selectedButton.value == "Sign In"
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        updateSelectedButton("Sign In");
                        // Add navigation logic here
                        Get.off(() => const SignInPage());
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: selectedButton.value == "Sign In"
                              ? const Color(0xff29306E)
                              : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Obx(() {
                  return Container(
                    width: Get.width * 0.911,
                    height: Get.height * 0.070,
                    decoration: BoxDecoration(
                      color: selectedButton.value == "Sign Up"
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        updateSelectedButton("Sign Up");
                        // Add navigation logic here
                        Get.to(() => const SignUpPage());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: selectedButton.value == "Sign Up"
                              ? const Color(0xff29306E)
                              : Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
