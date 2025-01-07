import 'package:Bhatt_Brahman_Var_Vadhu/constants/instance.dart';
import 'package:Bhatt_Brahman_Var_Vadhu/model/Shortlisted_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';

class FavouritesDetailPage extends StatelessWidget {
  final ShortlistedModel profile;
  const FavouritesDetailPage({super.key, required this.profile});

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
                            profile.profileImg ??
                                (profile.userType == 'groom'
                                    ? 'assets/groom.jpg'
                                    : 'assets/bride.jpg'),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                profile.userType == 'groom'
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
                            "${profile.firstName} ${profile.lastName}",
                            style: customTextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
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
                                        profile.parentContact;
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
                                  child: Icon(
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
                                  String? contactNumber = profile.parentContact;

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
                                    padding: EdgeInsets.all(Get.width * 0.028),
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
                            "Call or Chat to know more about ${profile.firstName} ${profile.lastName}.",
                            style: customTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffEB4E25)),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
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
                            profile.about ?? "No about information",
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
                              buildRow("Phone No. :", profile.contact ?? ""),
                              buildRow("Date of Birth :", profile.dob ?? ""),
                              buildRow("Age (yrs) :", profile.age ?? ""),
                              buildRow("Height (cm) :", profile.height ?? ""),
                              buildRow("Weight (kg) :", profile.weight ?? ""),
                              buildRow(
                                  "Blood Group :", profile.bloodGroup ?? ""),
                              buildRow("Body Type :", profile.bodyType ?? ""),
                              buildRow("Skin Complexion :",
                                  profile.skinComplexion ?? ""),
                              buildRow("Marital Status :",
                                  profile.maritalStatus ?? ""),
                              buildRow(
                                  "Native Place :", profile.nativePlace ?? ""),
                              buildRow("Lives In :", profile.livesIn ?? ""),
                              buildRow("Profile Created by :",
                                  profile.createdBy ?? ""),
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
                              buildRow("Education :", profile.education ?? ""),
                              buildRow(
                                  "Profession :", profile.profession ?? ""),
                              buildRow(
                                  "Designation :", profile.designation ?? ""),
                              buildRow("Income (LPA) :", profile.income ?? ""),
                              buildRow("Working At :", profile.workingAt ?? ""),
                              buildRow("Work Location :",
                                  profile.workLocation ?? ""),
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
                              buildRow("Gotra :", profile.gotra ?? ""),
                              buildRow("Manglik :", profile.manglik ?? ""),
                              buildRow("Star/Raasi :", profile.rassi ?? ""),
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
                                  "Father’s Name :", profile.fatherName ?? ""),
                              buildRow(
                                  "Mother’s Name :", profile.motherName ?? ""),
                              buildRow("Father’s Profession :",
                                  profile.fatherProfession ?? ""),
                              buildRow("Mother’s Profession :",
                                  profile.motherProfession ?? ""),
                              buildRow(
                                  "No. of Siblings :", profile.siblings ?? ""),
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
                                  "${profile.preferMinAge} - ${profile.preferMaxAge}" ??
                                      ""),
                              buildRow(
                                  "Preferred Height :",
                                  "${profile.preferMinHeight} - ${profile.preferMaxHeight}" ??
                                      ""),
                              buildRow("Preferred Body Type :",
                                  profile.preferBodyType ?? ""),
                              buildRow("Preferred Skin Complextion :",
                                  profile.preferSkinComplexion ?? ""),
                              buildRow("Preferred Marital Status :",
                                  profile.preferMaritalStatus ?? ""),
                              buildRow("Preferred Education :",
                                  profile.preferEducation ?? ""),
                              buildRow("Preferred Profession :",
                                  profile.preferProfession ?? ""),
                              buildRow("Preferred Location :",
                                  profile.preferLivesIn ?? ""),
                            ],
                          ),
                        ),
                      ),
                      height(20),
                      Material(
                        child: GestureDetector(
                          onTap: () {
                            shortlistController.removeShortlistedProfile(
                                profile.interestedPersonId);
                          },
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Remove",
                                style: GoogleFonts.sourceSans3(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Color(0xffffffff))),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
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
