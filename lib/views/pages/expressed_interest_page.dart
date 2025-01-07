import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../controller/expressed_interest_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../model/login_response_model.dart';
import 'expressed_interest_detail_page.dart';

class ExpressedInterestPage extends StatelessWidget {
  ExpressedInterestPage({super.key}) {
    controller.fetchExpressedInterestList();
  }

  final ExpressedInterestController controller =
      Get.put(ExpressedInterestController());

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
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Text(
            "Expressed Interest",
            style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xffffffff)),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/Vector.png',
              height: 24,
              width: 24,
            ),
          ),
          const Icon(
            Icons.notifications_outlined,
            size: 28,
          ),
          width(15),
        ],
      ),
      body: Padding(
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
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.interestExpressedList.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Expressed interests found.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: controller.interestExpressedList.length,
                      itemBuilder: (context, index) {
                        final item = controller.interestExpressedList[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: GestureDetector(
                            onTap: () {
                              viewProfileController
                                  .openProfilePage(item.userId);
                              Get.to(() =>
                                  ExpressedInterestDetailPage(item: item));
                            },
                            child: Container(
                              width: Get.width,
                              // height: Get.height * 0.37,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff9C9C9C)),
                                  borderRadius: BorderRadius.circular(7)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: Get.height * 0.18,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Image.network(
                                      item.profileImg ??
                                          "   https://freedesignfile.com/upload/2017/01/Handsome-man-HD-picture-05.jpg",
                                      width: Get.width,
                                      height: Get.height,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "${item.firstName} ${item.lastName}",
                                      style: customTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${item.age} Yrs | ${item.height} cm",
                                          style: customTextStyle(
                                              color: const Color(0xff686D76)),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.work_outline_outlined,
                                              color: Color(0xffE8461C),
                                              size: 18,
                                            ),
                                            width(4),
                                            Text(
                                              "${item.professionName}",
                                              style: customTextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xff686D76)),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              color: Color(0xffE8461C),
                                              size: 18,
                                            ),
                                            width(4),
                                            Text(
                                              "${item.livesInName}",
                                              style: customTextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xff686D76)),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (item.requestStatus == "Pending") ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Text(
                                        "${item.firstName} ${item.lastName} has shown interest in your profile.",
                                        style: customTextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff2C3377)),
                                      ),
                                    ),
                                    height(6),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Text(
                                        "Accept her interest to initiate further communication.",
                                        style: customTextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff686D76)),
                                      ),
                                    ),
                                  ] else if (item.requestStatus ==
                                      "Accept") ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 10),
                                      child: Text(
                                        "Call or Chat to know more about ${item.firstName} ${item.lastName}",
                                        style: customTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff2C3376)),
                                      ),
                                    ),
                                  ],
                                  height(12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (item.requestStatus ==
                                            "Pending") ...[
                                          Material(
                                            child: GestureDetector(
                                              onTap: () {
                                                notInterestedPersonController
                                                    .sendRejectRequest(item.userId);
                                              },
                                              child: Container(
                                                width: Get.width * 0.4,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffffffff),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffFF0000)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  child: Text(
                                                    "Decline Request",
                                                    style: GoogleFonts.sourceSans3(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xffFF0000))),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Material(
                                            child: GestureDetector(
                                              onTap: () {
                                                acceptRequestController
                                                    .sendAcceptRequest(
                                                        item.userId);
                                              },
                                              child: Container(
                                                width: Get.width * 0.4,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xff2A3171),
                                                        Color(0xff4E5CD3)
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  child: Text(
                                                    "Accept Request",
                                                    style: GoogleFonts.sourceSans3(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xffFFFFFF))),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ] else if (item.requestStatus ==
                                            "Accept") ...[
                                          Material(
                                            child: GestureDetector(
                                              onTap: () async {
                                                try {
                                                  String? contactNumber =
                                                      item.parentContact;
                                                  if (contactNumber != null &&
                                                      contactNumber
                                                          .isNotEmpty) {
                                                    _launchPhoneDialer(
                                                        contactNumber);
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
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: Get.width * 0.4,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffffffff),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xff2A3171)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  child: Text(
                                                    "Call Now",
                                                    style: GoogleFonts.sourceSans3(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff2A3171))),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          width(7),
                                          Material(
                                            child: GestureDetector(
                                              onTap: () async {
                                                String? contactNumber =
                                                    item.parentContact;

                                                if (contactNumber != null) {
                                                  String phoneNumber =
                                                      contactNumber.replaceAll(
                                                          RegExp(r'\D'), '');

                                                  String whatsappUrl =
                                                      "https://wa.me/+91$phoneNumber";
                                                  if (await canLaunch(
                                                      whatsappUrl)) {
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
                                              child: Container(
                                                width: Get.width * 0.4,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xff2A3171),
                                                        Color(0xff4E5CD3)
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  child: Text(
                                                    "Chat on WhatsApp",
                                                    style: GoogleFonts.sourceSans3(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xffFFFFFF))),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                      ],
                                    ),
                                  ),
                                  height(20)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
