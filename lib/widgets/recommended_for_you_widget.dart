import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../controller/recommended_controller.dart';
import '../views/pages/create_profile_page.dart';
import 'recommended_widget_detail_page.dart';

class RecommendedForYouWidget extends StatefulWidget {
  RecommendedForYouWidget({super.key});

  @override
  State<RecommendedForYouWidget> createState() =>
      _RecommendedForYouWidgetState();
}

class _RecommendedForYouWidgetState extends State<RecommendedForYouWidget> {
  final RecommendedController controller = Get.put(RecommendedController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final partnersToShow = controller.partners.take(3).toList();

      return SizedBox(
        height: screenHeight * 0.2,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: partnersToShow.length,
          itemBuilder: (context, index) {
            final partner = partnersToShow[index];
            final age = controller.calculateAge(partner.dob);

            return Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.03),
              child: GestureDetector(
                onTap: () async {
                  // Future<void> handleVerificationStatus(int index) async {
                  final verificationStatus =
                      await verificationController.fetchVerificationStatus();

                  if (verificationStatus != null) {
                    if (verificationStatus == 'Incomplete') {
                      Get.to(() => const EditProfilePage());
                    } else if (verificationStatus == 'Pending') {
                      Get.dialog(
                        AlertDialog(
                          title: const Text("Verification Pending"),
                          content: const Text(
                              "Your verification status is pending."),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else if (verificationStatus == 'Active') {
                      viewProfileController.openProfilePage(partner.id);
                      Get.to(
                          () => RecommendedWidgetDetailPage(partner: partner));
                    } else if (verificationStatus == 'Rejected') {
                      Get.dialog(
                        AlertDialog(
                          title: const Text("Verification Rejected"),
                          content: const Text(
                              "Your verification status is Rejected."),
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
                          content: const Text(
                              "Your verification status is Blocked."),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      setState(() {});
                    }
                  }
                  // }
                },
                child: Container(
                  width: screenWidth * 0.43,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: const Color(0xffDFE9FF)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenHeight * 0.12,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: CachedNetworkImage(
                            imageUrl: "${partner.profileImg}",
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.02,
                          top: screenHeight * 0.01,
                        ),
                        child: Text(
                          "${partner.firstName} ${partner.lastName}",
                          style: customTextStyle(
                            fontSize: screenWidth * 0.032,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${age.isNotEmpty ? '$age Yrs' : ''} | ${partner.height} cm",
                              style: customTextStyle(
                                fontSize: screenWidth * 0.028,
                                color: const Color(0xff686D76),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xffE8461C),
                                  size: 15,
                                ),
                                Text(
                                  "${partner.livesIn?.split(" ").first}...",
                                  style: customTextStyle(
                                    fontSize: screenWidth * 0.025,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff686D76),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
