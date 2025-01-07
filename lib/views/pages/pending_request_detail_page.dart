import 'package:Bhatt_Brahman_Var_Vadhu/model/interest_pending_model.dart';
import 'package:Bhatt_Brahman_Var_Vadhu/model/partner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';

class PendingRequestDetailPage extends StatefulWidget {
  InterestPendingModel item;

  PendingRequestDetailPage({
    super.key,
    required this.item,
  });

  @override
  State<PendingRequestDetailPage> createState() =>
      _PendingRequestDetailPageState();
}

class _PendingRequestDetailPageState extends State<PendingRequestDetailPage> {
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
                            widget.item.profileImg ??
                                (widget.item.userType == 'groom'
                                    ? 'assets/groom.jpg'
                                    : 'assets/bride.jpg'),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                widget.item.userType == 'groom'
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
                            "${widget.item.firstName} ${widget.item.lastName}",
                            style: customTextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      height(15),
                      const Divider(),
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
                            widget.item.about ?? "No about information",
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
                              buildRow(
                                  "Phone No. :", widget.item.contact ?? ""),
                              buildRow(
                                  "Date of Birth :", widget.item.dob ?? ""),
                              buildRow("Age (yrs) :", widget.item.age ?? ""),
                              buildRow(
                                  "Height (in cm) :", widget.item.height ?? ""),
                              buildRow(
                                  "Weight (in kg) :", widget.item.weight ?? ""),
                              buildRow("Blood Group :",
                                  widget.item.bloodGroup ?? ""),
                              buildRow(
                                  "Body Type :", widget.item.bodyType ?? ""),
                              buildRow("Skin Complexion :",
                                  widget.item.skinComplexion ?? ""),
                              buildRow("Marital Status :",
                                  widget.item.maritalStatus ?? ""),
                              buildRow("Native Place :",
                                  widget.item.nativePlace ?? ""),
                              buildRow("Lives In :", widget.item.livesIn ?? ""),
                              buildRow("Profile Created by :",
                                  widget.item.profileCreatedBy ?? ""),
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
                              buildRow(
                                  "Education :", widget.item.education ?? ""),
                              buildRow(
                                  "Profession :", widget.item.profession ?? ""),
                              buildRow("Designation :",
                                  widget.item.designation ?? ""),
                              buildRow(
                                  "Income (LPA) :", widget.item.income ?? ""),
                              buildRow(
                                  "Working At :", widget.item.workingAt ?? ""),
                              buildRow("Work Location :",
                                  widget.item.workLocation ?? ""),
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
                              buildRow("Gotra :", widget.item.gotra ?? ""),
                              buildRow("Manglik :", widget.item.manglik ?? ""),
                              buildRow("Star/Raasi :", widget.item.raasi ?? ""),
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
                              buildRow("Father’s Name :",
                                  widget.item.fatherName ?? ""),
                              buildRow("Mother’s Name :",
                                  widget.item.motherName ?? ""),
                              buildRow("Father’s Profession :",
                                  widget.item.fatherProfession ?? ""),
                              buildRow("Mother’s Profession :",
                                  widget.item.motherProfession ?? ""),
                              buildRow("No. of Siblings :",
                                  widget.item.siblings ?? ""),
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
                                  "${widget.item.preferMinAge} - ${widget.item.preferMaxAge}" ??
                                      ""),
                              buildRow(
                                  "Preferred Height :",
                                  "${widget.item.preferMinHeight} - ${widget.item.preferMaxHeight}" ??
                                      ""),
                              buildRow("Preferred Body Type :",
                                  widget.item.preferedBodyType ?? ""),
                              buildRow("Preferred Skin Complextion :",
                                  widget.item.preferComplexion ?? ""),
                              buildRow("Preferred Marital Status :",
                                  widget.item.preferMaritalStatus ?? ""),
                              buildRow("Preferred Education :",
                                  widget.item.preferEducation ?? ""),
                              buildRow("Preferred Profession :",
                                  widget.item.preferProfession ?? ""),
                              buildRow("Preferred Location :",
                                  widget.item.preferLivesIn ?? ""),
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
                                cancelRequestController
                                    .sendCancelRequest(widget.item.id);
                              },
                              child: Text(
                                "Unsend Request",
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
