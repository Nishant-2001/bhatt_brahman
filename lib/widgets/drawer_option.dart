import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/text_style.dart';
import '../views/pages/create_new_password_page.dart';
import '../views/pages/about_us_page.dart';
import '../views/pages/blocked_profile_page.dart';
import '../views/pages/committee_info_page.dart';
import '../views/pages/edit_preferrences_page.dart';
import '../views/pages/privacy_policy_page.dart';
import '../views/pages/support_page.dart';
import '../views/pages/terms_condition_page.dart';

List<Widget> drawerOptions(BuildContext context) {
  final List<Map<String, dynamic>> options = [
    {
      "icon": "assets/edit-pre.png",
      "title": "Edit Preferrences",
      "onTap": () {
        Navigator.pop(context);
        Get.to(() => const EditPreferrencesPage());
      },
    },
    {
      "icon": "assets/blocked-profile.png",
      "title": "Blocked Profile",
      // "onTap": () {
      //   Navigator.pop(context);
      //   Get.to(() => const BlockedProfilePage());
      // },
    },
    {
      "icon": "assets/password.png",
      "title": "Change Password",
      "onTap": () {
        Navigator.pop(context);
        Get.to(() => CreateNewPasswordPage());
      }
    },
    {
      "icon": "assets/committee.png",
      "title": "Managing Committee",
      "onTap": () {
        Navigator.pop(context);
        Get.to(() => const CommitteeInfoPage());
      },
    },
    {
      "icon": "assets/about-us.png",
      "title": "About Us",
      "onTap": () {
        Navigator.pop(context);
        Get.to(() => const AboutUsPage());
      },
    },
    {
      "icon": "assets/Terms.png",
      "title": "Terms & Conditions",
      "onTap": () {
        Navigator.pop(context);
        Get.to(() => const TermsConditionPage());
      }
    },
    {
      "icon": "assets/Privacy.png",
      "title": "Privacy Policy",
      "onTap": () {
        Navigator.pop(context);
        Get.to(() => const PrivacyPolicyPage());
      }
    },
    {
      "icon": "assets/Support.png",
      "title": "Support",
      "onTap": () {
        Navigator.pop(context);
        Get.to(() => const SupportPage());
      },
    },
  ];

  return options
      .map(
        (option) => GestureDetector(
          onTap: option['onTap'],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.asset(
                option['icon'],
                height: Get.height * 0.03,
                width: Get.width * 0.06,
              ),
              title: Text(
                option['title'],
                style: customTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xffffffff)),
              ),
            ),
          ),
        ),
      )
      .toList();
}
