import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';
import '../../controller/prefferences_controller.dart';
import '../../controller/user_profile_controller.dart';
import '../../model/prefferences_model.dart';
import '../../model/profile_response_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController scrollController = ScrollController();
  final ProfileController profileController = Get.put(ProfileController());
  final PrefferencesController _controller = PrefferencesController();
  PrefferencesModel? preferencesData;
  bool isLoading = true;

  final String deleteUrl =
      "https://bhattbrahmanvarvadhu.com/delete_data_account.php";

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    profileController.fetchProfileData();
    fetchPreferences();
  }

  Future<void> fetchPreferences() async {
    setState(() {
      isLoading = true;
    });
    final data = await _controller.fetchUserPreferences();
    setState(() {
      preferencesData = data;
      isLoading = false;
    });
  }

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
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Text(
            "Profile",
            style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xffffffff)),
          ),
        ),
        centerTitle: true,
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
                      FutureBuilder<ProfileResponseModel>(
                        future: profileController.fetchProfileData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final profile = snapshot.data!.data;

                            return Column(
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
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${profile.firstName} ${profile.lastName}",
                                      style: customTextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
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
                                      border: Border.all(
                                          color: const Color(0xff9C9C9C)),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      profile.about ?? "No about information",
                                      style: customTextStyle(
                                          fontSize: 14,
                                          color: const Color(0xff686D76)),
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
                                      border: Border.all(
                                          color: const Color(0xff9C9C9C)),
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
                                        buildRow("Phone No. :",
                                            profile.contact ?? ""),
                                        buildRow("Date of Birth :",
                                            profile.dob ?? ""),
                                        buildRow("Age (in yrs) :",
                                            profile.age.toString()),
                                        buildRow("Birth Time :",
                                            "${profile.birthTime}"),
                                        buildRow("Birth Place :",
                                            "${profile.birthPlace}"),
                                        buildRow("Height (in cm) :",
                                            profile.height ?? ""),
                                        buildRow("Weight (in kg) :",
                                            profile.weight ?? ""),
                                        buildRow("Blood Group :",
                                            profile.bloodGroup ?? ""),
                                        buildRow("Body Type :",
                                            profile.bodyType ?? ""),
                                        buildRow("Skin Complexion :",
                                            profile.skinComplextion ?? ""),
                                        buildRow("Marital Status :",
                                            profile.maritalStatus ?? ""),
                                        buildRow("Native Place :",
                                            profile.nativePlace ?? ""),
                                        buildRow("Lives In :",
                                            profile.livesIn ?? ""),
                                        buildRow("Profile Created by :",
                                            profile.createBy ?? ""),
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
                                      border: Border.all(
                                          color: const Color(0xff9C9C9C)),
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
                                        buildRow("Education :",
                                            profile.education ?? ""),
                                        buildRow("Profession :",
                                            profile.profession ?? ""),
                                        buildRow("Designation :",
                                            profile.designation ?? ""),
                                        buildRow("Income (LPA) :",
                                            profile.income ?? ""),
                                        buildRow("Working At :",
                                            profile.workingAt ?? ""),
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
                                      border: Border.all(
                                          color: const Color(0xff9C9C9C)),
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
                                            "Gotra :", profile.gotra ?? ""),
                                        buildRow(
                                            "Manglik :", profile.manglik ?? ""),
                                        buildRow("Star/Raasi :",
                                            profile.rassi ?? ""),
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
                                      border: Border.all(
                                          color: const Color(0xff9C9C9C)),
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
                                            profile.fathersName ?? ""),
                                        buildRow("Mother’s Name :",
                                            profile.mothersName ?? ""),
                                        buildRow("Father’s Profession :",
                                            profile.fathersProfession ?? "N/A"),
                                        buildRow("Mother’s Profession :",
                                            profile.mothersProfession ?? ""),
                                        buildRow("No. of Siblings :",
                                            profile.numberOfSiblings ?? ""),
                                      ],
                                    ),
                                  ),
                                ),
                                height(15),
                              ],
                            );
                          } else {
                            return const Center(
                                child: Text('No data available'));
                          }
                        },
                      ),
                      Text(
                        "My Preferences :-",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2A3171)),
                      ),
                      height(15),
                      isLoading
                          ? const Center(child: Text(""))
                          : preferencesData == null
                              ? const Center(child: Text('No data available'))
                              : Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff9C9C9C)),
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
                                        buildRow("Preferred Groom’s Age :",
                                            '${preferencesData?.minAge} - ${preferencesData?.maxAge}'),
                                        buildRow("Preferred Groom’s Height :",
                                            "${preferencesData?.minHeight} - ${preferencesData?.maxHeight}"),
                                        buildRow("Preferred Body Type :",
                                            preferencesData?.bodyType ?? ''),
                                        buildRow(
                                            "Preferred Skin Complextion :",
                                            preferencesData?.skinComplexion ??
                                                ''),
                                        buildRow(
                                            "Preferred Marital Status :",
                                            preferencesData?.maritalStatus ??
                                                ''),
                                        buildRow("Preferred Education :",
                                            preferencesData?.education ?? ''),
                                        buildRow("Preferred Profession :",
                                            preferencesData?.profession ?? ''),
                                        buildRow("Preferred Location :",
                                            preferencesData?.livesIn ?? ''),
                                      ],
                                    ),
                                  ),
                                ),
                      height(20),
                      Material(
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await _launchURL(deleteUrl);
                            } catch (e) {
                              Get.snackbar(
                                "Failed",
                                "Failed to open the URL",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP,
                              );
                            }
                          },
                          child: Container(
                            width: Get.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffE8461C),
                                    Color(0xffE8461C)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Text(
                                "Delete Account",
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
                      height(10)
                    ],
                  )),
                ),
              ),
            ),
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
