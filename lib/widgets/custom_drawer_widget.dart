import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constant.dart';
import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../views/auth/sign_in_page.dart';
import '../views/pages/create_profile_page.dart';
import 'drawer_option.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({super.key});

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  Map<String, dynamic>? parentData;
  String? verificationStatus;

  @override
  void initState() {
    super.initState();
    loadParentData();
    fetchVerificationStatus();
  }

  Future<void> loadParentData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? parentJson = prefs.getString('parent');

    if (parentJson != null) {
      setState(() {
        parentData = jsonDecode(parentJson);
      });
    } else {
      log("No parent data found in SharedPreferences");
    }
  }

  Future<void> fetchVerificationStatus() async {
    try {
      final status = await verificationController.fetchVerificationStatus();
      if (mounted) {
        setState(() {
          verificationStatus = status;
        });
      }
    } catch (e) {
      log("Error fetching verification status: $e");
      Get.snackbar("Error", "Unable to fetch verification status.");
    }
  }

  Future<void> logoutUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Get remember me preferences before clearing
      final rememberedEmail = prefs.getString('remembered_email');
      final rememberedPassword = prefs.getString('remembered_password');
      final wasRemembered = prefs.getBool('was_remembered');

      // Clear all preferences
      await prefs.clear();

      // If remember me was enabled, restore those preferences
      if (wasRemembered == true) {
        await prefs.setString('remembered_email', rememberedEmail!);
        await prefs.setString('remembered_password', rememberedPassword!);
        await prefs.setBool('was_remembered', true);
      }

      log('[log] User logged out successfully');
      Get.offAll(() => const SignInPage());
    } catch (e) {
      log('Error during logout: $e');
      Get.snackbar('Error', 'Failed to log out. Please try again.');
    }
  }

  Future<void> showLogoutConfirmation() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Logout",
                  style: customTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2A3171),
                  ),
                ),
                height(15),
                Text(
                  "Are you sure you want to logout?",
                  style: customTextStyle(
                    fontSize: 16,
                    color: const Color(0xff686D76),
                  ),
                ),
                height(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: customTextStyle(
                          fontSize: 16,
                          color: const Color(0xff686D76),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        logoutUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.appMainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        "Logout",
                        style: customTextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.9,
      backgroundColor: AppConstant.appMainColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height(8),
                ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: parentData != null
                            ? const AssetImage('assets/groom.jpg')
                            : const AssetImage('assets/bride.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    parentData != null
                        ? '${parentData!['first_name']} '
                        : 'Loading...',
                    style: customTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                  subtitle: Text(
                    parentData?['email'] ?? 'Loading...',
                    style: customTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffFFCB60),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                height(10),
                const Divider(),
                height(10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => const EditProfilePage());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                        leading: const Icon(
                          Icons.edit_outlined,
                          color: Color(0xff9C9C9C),
                        ),
                        title: Text(
                          // verificationStatus == null
                          //     ? "Loading..."
                          (verificationStatus == 'Incomplete'
                              ? "Create Profile"
                              : "Edit Profile"),
                          style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                height(10),
                ...drawerOptions(context),
                height(15),
                const Divider(),
                height(15),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      showLogoutConfirmation();
                    },
                    leading: Image.asset(
                      "assets/Logout.png",
                      height: Get.height * 0.034,
                    ),
                    title: Text(
                      "Log Out",
                      style: customTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
