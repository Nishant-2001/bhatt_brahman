import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../controller/interest_accepted_controller.dart';
import 'accepted_interest_detail_page.dart';

class AcceptedInterestWidget extends StatelessWidget {
  AcceptedInterestWidget({super.key}) {
    controller.fetchInterestAcceptList();
  }

  final InterestAcceptedController controller =
      Get.put(InterestAcceptedController());

  void _launchPhoneDialer(String phoneNumber) async {
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s()\-]'), '');

    if (cleanNumber.contains('(') || cleanNumber.contains(')')) {
      cleanNumber = cleanNumber.replaceAll(RegExp(r'[()]'), '');
    }

    if (!cleanNumber.startsWith('+')) {
      cleanNumber = '+91$cleanNumber';
    }

    final Uri telUri = Uri.parse('tel:$cleanNumber');

    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(
          telUri,
          mode: LaunchMode.platformDefault,
        );
      } else {
        print('Cannot launch URL: $telUri');
        Get.snackbar(
          "Error",
          "Unable to open phone dialer",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error launching phone dialer: $e');
      Get.snackbar(
        "Error",
        "Failed to launch phone dialer",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.interestAcceptList.isEmpty) {
            return const Center(
              child: Text(
                "No Accepted interests found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchInterestAcceptList();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: controller.interestAcceptList.length,
              itemBuilder: (context, index) {
                final item = controller.interestAcceptList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => AcceptedInterestDetailPage(item: item));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9C9C9C)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(item.profileImg ?? ''),
                        ),
                        title: Text(
                          "${item.firstName} ${item.lastName}",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff383838)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item.age} Yrs | ${item.height} cm",
                                    style: customTextStyle(
                                        fontSize: 12,
                                        color: const Color(0xff686D76)),
                                  ),
                                  width(10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.work_outline,
                                        size: 16,
                                        color: Color(0xffE8461C),
                                      ),
                                      width(5),
                                      Text(
                                        "${item.professionName?.split(" ").first}..." ??
                                            '',
                                        style: customTextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff686D76)),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                  width(10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                        color: Color(0xffE8461C),
                                      ),
                                      width(5),
                                      Text(
                                        "${item.livesInName?.split(" ").first}..." ??
                                            '',
                                        style: customTextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff686D76)),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            height(6),
                            Text(
                              "${item.firstName} ${item.lastName} has accepted your request.",
                              style: customTextStyle(
                                  fontSize: 10,
                                  color: const Color(0xff29306E),
                                  fontWeight: FontWeight.w500),
                            ),
                            height(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Material(
                                  child: Container(
                                    width: Get.width * 0.28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff29306E)),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          String? contactNumber =
                                              item.parentContact;
                                          if (contactNumber != null &&
                                              contactNumber.isNotEmpty) {
                                            _launchPhoneDialer(contactNumber);
                                          } else {
                                            Get.snackbar(
                                              "Error",
                                              "Contact number not found",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                            );
                                          }
                                        } catch (e) {
                                          print(
                                              'Error getting contact number: $e');
                                          Get.snackbar(
                                            "Error",
                                            "Failed to get contact number",
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.007),
                                        child: Text(
                                          "Call Now",
                                          style: GoogleFonts.sourceSans3(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: Get.width * 0.025,
                                                  color:
                                                      const Color(0xff29306E))),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  child: Container(
                                    width: Get.width * 0.29,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff29306E),
                                      border: Border.all(
                                          color: const Color(0xff29306E)),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        String? contactNumber =
                                            item.parentContact;

                                        if (contactNumber != null) {
                                          String phoneNumber = contactNumber
                                              .replaceAll(RegExp(r'\D'), '');

                                          String whatsappUrl =
                                              "https://wa.me/+91$phoneNumber";
                                          if (await canLaunch(whatsappUrl)) {
                                            await launch(whatsappUrl);
                                          } else {
                                            Get.snackbar("Error",
                                                "Unable to open WhatsApp");
                                          }
                                        } else {
                                          Get.snackbar("Error",
                                              "Contact number not found");
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.007),
                                        child: Text(
                                          "Chat on WhatsApp",
                                          style: GoogleFonts.sourceSans3(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: Get.width * 0.025,
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
