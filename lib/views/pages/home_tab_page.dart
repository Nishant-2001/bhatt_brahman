import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../controller/verification_controller.dart';
import '../../model/login_response_model.dart';
import '../../widgets/banner_widget.dart';
import '../../widgets/categories_widget.dart';
import '../../widgets/custom_drawer_widget.dart';
import '../../widgets/find_matches_widget.dart';
import '../../widgets/heading_widget.dart';
import '../../widgets/recommended_for_you_widget.dart';
import 'create_profile_page.dart';
import 'notification_page.dart';
import 'recommended_for_you_page.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final VerificationController verificationController =
      Get.put(VerificationController());

  // bool _isRefreshing = false;

  // Future<void> handleRefresh() async {
  //   setState(() {
  //     _isRefreshing = true;
  //   });

  //   try {
  //     await Future.wait([
  //       signInController.getParentData(),
  //       recommendedController.fetchRecommendedPartners(),
  //       verificationController.fetchVerificationStatus(),
  //     ]);
  //     Get.snackbar("Success", "Data refreshed successfully.",
  //         backgroundColor: Colors.green, colorText: Colors.white);
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to refresh data.",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   } finally {
  //     setState(() {
  //       _isRefreshing = false;
  //     });
  //   }
  // }
  int viewedCount = 0;

  @override
  void initState() {
    super.initState();
    loadNotificationCount();
  }

  Future<void> loadNotificationCount() async {
    int count = await notificationController.fetchNotificationCount();
    setState(() {
      viewedCount = count;
    });
  }

  Future<void> handleVerificationStatus() async {
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
        Get.to(() => RecommendedForYouPage());
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      drawer: const CustomDrawerWidget(),
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: FutureBuilder<Parent?>(
          future: signInController.getParentData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                "Hii...",
                style: customTextStyle(
                  color: const Color(0xffFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              );
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Text(
                "Hii Guest!",
                style: customTextStyle(
                  color: const Color(0xffFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              );
            } else {
              final parent = snapshot.data!;
              return Text(
                "Hii ${parent.firstName}!",
                style: customTextStyle(
                  color: const Color(0xffFFFFFF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              );
            }
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              notificationController.removeNotificationBadge();
              Get.to(() => const NotificationPage());
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  size: 28,
                ),
                if (viewedCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: Get.width * 0.019,
                      height: Get.height * 0.019,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          width(Get.width * 0.040),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: Get.width * 0.9,
                    height: Get.height * 0.015,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff).withOpacity(.50),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
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
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          height(Get.height * 0.003),
                          const SizedBox(child: BannerWidget()),
                          height(12),
                          const CategoriesWidget(),
                          height(8),
                          HeadingWidget(
                            headingTitle: "Recommended for you",
                            buttonText: "View All",
                            onTap: () async {
                              await handleVerificationStatus();
                            },
                          ),
                          height(6),
                          RecommendedForYouWidget(),
                          height(10),
                          Text(
                            "Find Matches",
                            style: customTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          height(10),
                          FindMatchesWidget(
                            partners: [],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
