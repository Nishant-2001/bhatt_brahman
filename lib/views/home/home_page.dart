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
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffE4E4E4),
          selectedItemColor: const Color(0xff2A3171),
          unselectedItemColor: const Color(0xff2A3171),
          selectedLabelStyle: TextStyle(
            fontFamily: "Work Sans",
            fontSize: Get.width * 0.03,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Work Sans",
            fontSize: Get.width * 0.03,
            fontWeight: FontWeight.w600,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          onTap: (index) async {
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
          items: [
            _buildBottomNavigationBarItem('Home', Icons.home_outlined, 0),
            _buildBottomNavigationBarItem('Search', Icons.search_outlined, 1),
            _buildBottomNavigationBarItem(
                'Shortlisted', Icons.favorite_outline, 2),
            _buildBottomNavigationBarItem('Profile', Icons.person_outline, 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      String label, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: Get.width * 0.065,
            color: _currentIndex == index
                ? const Color(0xff2A3171)
                : const Color(0xff2A3171),
          ),
          SizedBox(height: Get.height * 0.005),
          Text(
            label,
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: Get.width * 0.028,
              fontWeight: FontWeight.w600,
              color: _currentIndex == index
                  ? const Color(0xff2A3171)
                  : const Color(0xff2A3171),
            ),
          ),
          SizedBox(height: Get.height * 0.005),
          _currentIndex == index
              ? Container(
                  height: Get.height * 0.01,
                  width: Get.width * 0.1,
                  decoration: BoxDecoration(
                    color: const Color(0xff2A3171),
                    borderRadius: BorderRadius.circular(2),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      label: '',
    );
  }
}
