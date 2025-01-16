import 'package:bhatt_brahman_var_vadhu/model/partner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';
import '../constants/app_constant.dart';
import '../constants/instance.dart';

class RecommendedWidgetDetailPage extends StatelessWidget {
  final PartnerModel partner;

  const RecommendedWidgetDetailPage({
    super.key,
    required this.partner,
  });

  Future<void> showConfirmation(context) async {
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
                  "Are you sure you want to report?",
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
                        "No",
                        style: customTextStyle(
                          fontSize: 16,
                          color: const Color(0xff686D76),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        reportController.sendReportRequest(partner.id);
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
                        "Yes",
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

  void showReportDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xffffffff),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: Get.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Report",
                      style: customTextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    height(Get.height * 0.03),
                    TextFormField(
                      controller: reportController.descriptionController,
                      decoration: InputDecoration(
                          hintText: "Enter Description...",
                          hintStyle: customTextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter report description";
                        }
                        return null;
                      },
                    ),
                    height(Get.height * 0.03),
                    Material(
                      child: GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                            showConfirmation(context);
                          }
                        },
                        child: Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              gradient: const LinearGradient(
                                colors: [Color(0xff2A3171), Color(0xff4E5CD3)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.0),
                            child: Text(
                              "Submit",
                              style: GoogleFonts.sourceSans3(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
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
        );
      },
    );
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
                onTap: () {
                  blockProfileController.sendBlockRequest(partner.id);
                },
              ),
              PopupMenuItem(
                child: Text(
                  'Report',
                  style: customTextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  showReportDialog(context);
                },
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
                            partner.profileImg ??
                                (partner.userType == 'groom'
                                    ? 'assets/groom.jpg'
                                    : 'assets/bride.jpg'),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                partner.userType == 'groom'
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
                            partner.about ?? "No about information",
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
                              buildRow("Phone No. :", partner.contact),
                              buildRow("Date of Birth :", partner.dob),
                              buildRow("Age (yrs) :", partner.age ?? ""),
                              buildRow("Birth Time :", partner.birthTime ?? ""),
                              buildRow("Birth Place :", partner.birthPlace ?? ""),
                              buildRow("Height (cm) :", partner.height),
                              buildRow("Weight (kg) :", partner.weight ?? ""),
                              buildRow(
                                  "Blood Group :", partner.bloodGroup ?? ""),
                              buildRow("Body Type :", partner.bodyType ?? ""),
                              buildRow("Skin Complexion :",
                                  partner.skinComplexion ?? ""),
                              buildRow("Marital Status :",
                                  partner.maritalStatus ?? ""),
                              buildRow(
                                  "Native Place :", partner.nativePlace ?? ""),
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
                              buildRow("Education :", partner.education ?? ""),
                              buildRow(
                                  "Profession :", partner.profession ?? ""),
                              buildRow(
                                  "Designation :", partner.designation ?? ""),
                              buildRow("Income (LPA) :", partner.income ?? ""),
                              buildRow("Working At :", partner.workingAt ?? ""),
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
                                  "Father’s Name :", partner.fatherName ?? ""),
                              buildRow(
                                  "Mother’s Name :", partner.motherName ?? ""),
                              buildRow("Father’s Profession :",
                                  partner.fatherProfession ?? ""),
                              buildRow("Mother’s Profession :",
                                  partner.motherProfession ?? ""),
                              buildRow(
                                  "No. of Siblings :", partner.siblings ?? ""),
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
                                  "${partner.preferMinAge} - ${partner.preferMaxAge}"),
                              buildRow(
                                  "Preferred Height :",
                                  "${partner.preferMinHeight} - ${partner.preferMaxHeight}"),
                              buildRow("Preferred Body Type :",
                                  partner.preferedBodyType ?? ""),
                              buildRow("Preferred Skin Complextion :",
                                  partner.preferComplexion ?? ""),
                              buildRow("Preferred Marital Status :",
                                  partner.preferMaritalStatus ?? ""),
                              buildRow("Preferred Education :",
                                  partner.preferEducation ?? ""),
                              buildRow("Preferred Profession :",
                                  partner.preferProfession ?? ""),
                              buildRow("Preferred Location :",
                                  partner.preferLivesIn ?? ""),
                            ],
                          ),
                        ),
                      ),
                      height(20),
                      Material(
                        child: Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              gradient: const LinearGradient(
                                colors: [Color(0xff2A3171), Color(0xff4E5CD3)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(25)),
                          child: TextButton(
                              onPressed: () {
                                interestedPersonController
                                    .sendInterestRequest(partner.id);
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
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
