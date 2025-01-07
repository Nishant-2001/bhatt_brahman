import 'package:Bhatt_Brahman_Var_Vadhu/model/interest_accepted_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';

class AcceptedInterestDetailPage extends StatelessWidget {
  final InterestAcceptedModel item;

  const AcceptedInterestDetailPage({super.key, required this.item});

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
      backgroundColor: const Color(0xffE94C22),
      appBar: AppBar(
        backgroundColor: const Color(0xffE94C22),
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Text(
          "Profile",
          style: customTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xffffffff)),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: const Color(0xffffffff),
            offset: const Offset(0, kToolbarHeight),
            menuPadding: const EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'Block',
                  style: customTextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Text(
                  'Report',
                  style: customTextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
      body: Column(
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width,
                        height: Get.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            item.profileImg ??
                                (item.userType == 'groom'
                                    ? 'assets/groom.jpg'
                                    : 'assets/bride.jpg'),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                item.userType == 'groom'
                                    ? 'assets/bride.jpg'
                                    : 'assets/groom.jpg',
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ),
                      height(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item.firstName} ${item.lastName}",
                            style: customTextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      height(15),
                      const Divider(),
                      height(15),
                      if (item.requestStatus == 'Accept') ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
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
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      }
                                    } catch (e) {
                                      print('Error getting contact number: $e');
                                      Get.snackbar(
                                        "Error",
                                        "Failed to get contact number",
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: Get.height * 0.08,
                                    width: Get.width * 0.14,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff2A3171),
                                          Color(0xff4E5CD3)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.call_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.2,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String? contactNumber = item.parentContact;

                                    if (contactNumber != null) {
                                      String phoneNumber = contactNumber
                                          .replaceAll(RegExp(r'\D'), '');

                                      String whatsappUrl =
                                          "https://wa.me/+91$phoneNumber";
                                      if (await canLaunch(whatsappUrl)) {
                                        await launch(whatsappUrl);
                                      } else {
                                        Get.snackbar(
                                            "Error", "Unable to open WhatsApp");
                                      }
                                    } else {
                                      Get.snackbar(
                                          "Error", "Contact number not found");
                                    }
                                  },
                                  child: Container(
                                    height: Get.height * 0.08,
                                    width: Get.width * 0.14,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xff2A3171),
                                          Color(0xff4E5CD3)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(Get.width * 0.028),
                                      child: Image.asset(
                                        "assets/chat3.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height(Get.height * 0.01),
                            Text(
                              "Call or Chat to know more about ${item.firstName} ${item.lastName}.",
                              style: customTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xffEB4E25)),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ] else ...[
                        Text(
                            "${item.firstName} ${item.lastName} profile has Match with yours.")
                      ],
                      height(15),
                      Text(
                        "About :-",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171)),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            item.about ?? "No about information",
                            style: customTextStyle(
                                fontSize: 14, color: const Color(0xff686D76)),
                          ),
                        ),
                      ),
                      height(20),
                      Text(
                        "Basic Details :-",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171)),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 15),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(2.5),
                              1: FlexColumnWidth(2),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              buildRow("Phone No. :", item.contact ?? ""),
                              buildRow("Date of Birth :", item.dod ?? ""),
                              buildRow("Age (yrs) :", item.age ?? ""),
                              buildRow("Height (cm) :", item.height ?? ""),
                              buildRow("Weight (kg) :", item.weight ?? ""),
                              buildRow("Blood Group :", item.bloodgroup ?? ""),
                              buildRow("Body Type :", item.bodyType ?? ""),
                              buildRow("Skin Complexion :",
                                  item.skinComplexion ?? ""),
                              buildRow(
                                  "Marital Status :", item.maritalStatus ?? ""),
                              buildRow(
                                  "Native Place :", item.nativePlace ?? ""),
                              buildRow("Lives In :", item.livesIn ?? ""),
                              buildRow(
                                  "Profile Created by :", item.createdBy ?? ""),
                            ],
                          ),
                        ),
                      ),
                      height(20),
                      Text(
                        "Education & Professional Details :-",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171)),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 15),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(3),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              buildRow("Education :", item.education ?? ""),
                              buildRow("Profession :", item.profession ?? ""),
                              buildRow("Designation :", item.designation ?? ""),
                              buildRow("Income (LPA) :", item.income ?? ""),
                              buildRow("Working At :", item.workingAt ?? ""),
                              buildRow(
                                  "Work Location :", item.workLocation ?? ""),
                            ],
                          ),
                        ),
                      ),
                      height(20),
                      Text(
                        "Religion Status :-",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171)),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 15),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(3),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              buildRow("Gotra :", item.gotra ?? ""),
                              buildRow("Manglik :", item.manglik ?? ""),
                              buildRow("Star/Raasi :", item.raasi ?? ""),
                            ],
                          ),
                        ),
                      ),
                      height(20),
                      Text(
                        "About Family :-",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171)),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 15),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(2),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              buildRow(
                                  "Father’s Name :", item.fathersName ?? ""),
                              buildRow(
                                  "Mother’s Name :", item.mothersName ?? ""),
                              buildRow("Father’s Profession :",
                                  item.fathersProfession ?? ""),
                              buildRow("Mother’s Profession :",
                                  item.mothersProfession ?? ""),
                              buildRow(
                                  "No. of Siblings :", item.siblings ?? ""),
                            ],
                          ),
                        ),
                      ),
                      height(20),
                      Text(
                        "Preferences :-",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171)),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 15),
                          child: Table(
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(2),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              buildRow(
                                  "Preferred Age :",
                                  "${item.preferMinAge} - ${item.preferMaxAge}" ??
                                      ""),
                              buildRow(
                                  "Preferred Height :",
                                  "${item.preferMinHeight} - ${item.preferMaxHeight}" ??
                                      ""),
                              buildRow("Preferred Body Type :",
                                  item.preferBodyType ?? ""),
                              buildRow("Preferred Skin Complextion :",
                                  item.preferSkinComplexion ?? ""),
                              buildRow("Preferred Marital Status :",
                                  item.preferMaritalStatus ?? ""),
                              buildRow("Preferred Education :",
                                  item.preferEducation ?? ""),
                              buildRow("Preferred Profession :",
                                  item.preferProfession ?? ""),
                              buildRow("Preferred Location :",
                                  item.preferlivesIn ?? ""),
                            ],
                          ),
                        ),
                      ),
                      height(20),
                      if (item.requestStatus == 'Accept') ...[
                        Material(
                          child: Container(
                            width: Get.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff2A3171),
                                    Color(0xff4E5CD3)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(25)),
                            child: TextButton(
                                onPressed: () {
                                  shortlistController
                                      .sendShortlistRequest(item.userId);
                                },
                                child: Text(
                                  "Shortlist",
                                  style: GoogleFonts.sourceSans3(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Color(0xffffffff))),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                      ] else ...[
                        Material(
                          child: Container(
                            width: Get.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff2A3171),
                                    Color(0xff4E5CD3)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(25)),
                            child: TextButton(
                                onPressed: () {
                                  interestedPersonController
                                      .sendInterestRequest("${item.userId}");
                                },
                                child: Text(
                                  "Interested",
                                  style: GoogleFonts.sourceSans3(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Color(0xffffffff))),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                      ],
                      height(20),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

TableRow buildRow(String label, String value, {bool isHighlighted = false}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label,
                style: customTextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 10.0), // Added horizontal padding
        child: Text(
          value,
          style: customTextStyle(
            fontSize: 14.0,
            color: isHighlighted
                ? const Color(0xffE61825)
                : const Color(0xff686D76),
            fontWeight: isHighlighted ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
