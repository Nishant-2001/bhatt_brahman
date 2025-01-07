import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../model/partner_model.dart';

class FindMatchProfilePage extends StatefulWidget {
  final PartnerModel partner;
  const FindMatchProfilePage({super.key, required this.partner});

  @override
  State<FindMatchProfilePage> createState() => _FindMatchProfilePageState();
}

class _FindMatchProfilePageState extends State<FindMatchProfilePage> {
  late PartnerModel partner;
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    } else {
      log("ScrollController not attached to any scrollable widget.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final partner = widget.partner;
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: scrollToTop,
      //   shape: const CircleBorder(),
      //   backgroundColor: const Color(0xffE8461C),
      //   child: const Icon(
      //     Icons.arrow_upward,
      //     color: Color(0xffffffff),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Text(
            "${partner.firstName}'s Profile",
            style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xffffffff)),
          ),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          height: Get.height * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: partner.profileImg != null
                                ? Image.network(
                                    partner.profileImg!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    "https://freedesignfile.com/upload/2017/01/Handsome-man-HD-picture-05.jpg",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        height(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${partner.firstName} ${partner.lastName}",
                              style: customTextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        height(15),
                        const Divider(),
                        height(15),
                        Text(
                          "${partner.firstName} ${partner.lastName} profile has an ${partner.matchPercentage} with yours.",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffEB4E25)),
                        ),
                        height(20),
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
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "${partner.about}",
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
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 15),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                              },
                              children: [
                                buildRow("Phone No. :", partner.contact,
                                    isHighlighted: true),
                                buildRow("Date of Birth :", partner.dob),
                                buildRow("Age (yrs) :",
                                    "${partner.age ?? 'Not available'} ${partner.age != null ? '' : ''}"),
                                buildRow(
                                    "Height (cm) :", "${partner.height}"),
                                buildRow(
                                    "Weight (kg) :", "${partner.weight}"),
                                buildRow(
                                    "Blood Group :", "${partner.bloodGroup} "),
                                buildRow("Body Type :", partner.bodyType ?? ""),
                                buildRow("Skin Complexion :",
                                    partner.skinComplexion ?? ""),
                                buildRow("Marital Status :",
                                    partner.maritalStatus ?? ""),
                                buildRow("Lives In :", partner.livesIn ?? ""),
                                buildRow("Profile Created by :",
                                    partner.profileCreatedBy ?? ""),
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
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 15),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(3),
                              },
                              children: [
                                buildRow(
                                    "Education :", partner.education ?? ""),
                                buildRow(
                                    "Profession :", partner.profession ?? ""),
                                buildRow(
                                    "Designation :", partner.designation ?? ""),
                                buildRow(
                                    "Income (LPA) :", partner.income ?? ""),
                                buildRow(
                                    "Working At :", partner.workingAt ?? ""),
                                buildRow("Work Location :",
                                    partner.workLocation ?? ""),
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
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 15),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(3),
                              },
                              children: [
                                buildRow("Gotra :", partner.gotra ?? ""),
                                buildRow("Manglik :", partner.manglik ?? ""),
                                buildRow("Star/Raasi :", partner.raasi ?? ""),
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
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 15),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                              },
                              children: [
                                buildRow("Father’s Name :",
                                    partner.fatherName ?? ""),
                                buildRow("Mother’s Name :",
                                    partner.motherName ?? ""),
                                buildRow("Father’s Profession :",
                                    partner.fatherProfession ?? ""),
                                buildRow("Mother’s Profession :",
                                    partner.motherProfession ?? ""),
                                buildRow("No. of Siblings :",
                                    partner.siblings ?? ""),
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
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 15),
                            child: Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(2),
                              },
                              children: [
                                buildRow(
                                  "Preferred Age :",
                                  "${partner.preferMinAge} - ${partner.preferMaxAge} yrs" ??
                                      "",
                                ),
                                buildRow(
                                    "Preferred Height :",
                                    "${partner.preferMinHeight} - ${partner.preferMaxHeight}" ??
                                        ""),
                                buildRow("Preferred Body Type :",
                                    "${partner.preferedBodyType}" ?? ""),
                                buildRow("Preferred Skin Complextion :",
                                    "${partner.preferComplexion}" ?? ""),
                                buildRow("Preferred Marital Status :",
                                    "${partner.preferMaritalStatus}" ?? ""),
                                buildRow("Preferred Education :",
                                    "${partner.preferEducation}" ?? ""),
                                buildRow("Preferred Profession :",
                                    "${partner.preferProfession}" ?? ""),
                                buildRow("Preferred Location :",
                                    "${partner.preferLivesIn}" ?? ""),
                              ],
                            ),
                          ),
                        ),
                        height(20),
                        Material(
                          child: GestureDetector(
                            onTap: () {
                              interestedPersonController
                                  .sendInterestRequest(partner.id);
                            },
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.05,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
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
                                    const EdgeInsets.symmetric(vertical: 7.0),
                                child: Text(
                                  "Interested",
                                  style: GoogleFonts.sourceSans3(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: Color(0xffFFFFFF))),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        height(20),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

TableRow buildRow(String label, String value, {bool isHighlighted = false}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          label,
          style: customTextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
