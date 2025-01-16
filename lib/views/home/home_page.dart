import 'package:bhatt_brahman_var_vadhu/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/instance.dart';
import '../pages/create_profile_page.dart';
import '../pages/favourites_page.dart';
import '../pages/home_tab_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_macthes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Future<void> handleVerificationStatus(int index) async {
    final verificationStatus =
        await verificationController.fetchVerificationStatus();

    if (verificationStatus != null) {
      if (verificationStatus == 'Incomplete') {
        Get.to(() => const EditProfilePage());
      } else if (verificationStatus == 'Pending') {
        Get.dialog(
          AlertDialog(
            title: const Text("Verification Pending"),
            content: const Text("Your verification status is pending."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else if (verificationStatus == 'Active') {
        setState(() {
          _currentIndex = index;
        });
      } else if (verificationStatus == 'Rejected') {
        Get.dialog(
          AlertDialog(
            title: const Text("Verification Rejected"),
            content: const Text("Your verification status is Rejected."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else if (verificationStatus == 'Blocked') {
        Get.dialog(
          AlertDialog(
            title: const Text("Verification Blocked"),
            content: const Text("Your verification status is Blocked."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _currentIndex = index;
        });
      }
    }
  }

  Future<void> handleVerification(int index) async {
    final verificationStatus =
        await verificationController.fetchVerificationStatus();

    if (verificationStatus != null) {
      if (verificationStatus == 'Incomplete') {
        Get.to(() => const EditProfilePage());
      } else {
        setState(() {
          _currentIndex = index;
        });
      }
    }
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const HomeTabPage();
      case 1:
        return const SearchMacthesPage();
      case 2:
        return const FavouritesPage();
      case 3:
        return const ProfilePage();
      default:
        return const HomeTabPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(_currentIndex),
      bottomNavigationBar: Container(
        height: Get.height * 0.065,
        decoration: const BoxDecoration(
          color: Color(0xffE4E4E4),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('Home', Icons.home_outlined, 0),
            _buildNavItem('Search', Icons.search_outlined, 1),
            _buildNavItem('Shortlisted', Icons.favorite_outline, 2),
            _buildNavItem('Profile', Icons.person_outline, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, int index) {
    return GestureDetector(
      onTap: () async {
        if (index == 0) {
          setState(() {
            _currentIndex = index;
          });
        } else if (index == 3) {
          await handleVerification(index);
        } else {
          await handleVerificationStatus(index);
        }
      },
      child: SizedBox(
        width: Get.width * 0.22,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: Get.height * 0.008),
                Icon(
                  icon,
                  size: Get.width * 0.065,
                  color: const Color(0xff2A3171),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: Get.width * 0.028,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2A3171),
                  ),
                ),
                height(Get.height * 0.008)
              ],
            ),
            if (_currentIndex == index)
              Positioned(
                bottom: 0,
                child: Container(
                  height: Get.height * 0.005,
                  width: Get.width * 0.1,
                  decoration: const BoxDecoration(
                    color: Color(0xff2A3171),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
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
