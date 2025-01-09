import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../model/Shortlisted_model.dart';
import 'favourites_detail_page.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late Future<List<ShortlistedModel>> shortlistFuture;

  @override
  void initState() {
    super.initState();
    shortlistFuture = shortlistController.fetchShortlistData();
  }

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
            "Shortlisted",
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
                  child: FutureBuilder<List<ShortlistedModel>>(
                    future: shortlistFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error fetching data",
                            style: customTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        );
                      }

                      final List<ShortlistedModel>? data = snapshot.data;

                      if (data == null || data.isEmpty) {
                        return Center(
                          child: Text(
                            "No shortlisted profiles found.",
                            style: customTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        );
                      }

                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final ShortlistedModel profile = data[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                      FavouritesDetailPage(profile: profile));
                                },
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff9C9C9C)),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Get.width,
                                        height: Get.height * 0.18,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Image.network(
                                          profile.profileImg,
                                          width: Get.width,
                                          height: Get.height,
                                        ),
                                      ),
                                      ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${profile.firstName} ${profile.lastName}",
                                              style: customTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                shortlistController
                                                    .removeShortlistedProfile(
                                                        profile
                                                            .interestedPersonId);
                                                setState(() {
                                                  shortlistFuture =
                                                      shortlistController
                                                          .fetchShortlistData();
                                                });
                                              },
                                              child: const Text(
                                                "Remove",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffff00000),
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      Color(0xffff00000),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              "${profile.age} Yrs | ${profile.height} cm",
                                              style: customTextStyle(
                                                  color:
                                                      const Color(0xff686D76)),
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.08,
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
                                                  "${profile.profession.split(" ").first}...",
                                                  style: customTextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xff686D76)),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.08,
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
                                                  "${profile.livesIn.split(" ").first}...",
                                                  style: customTextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xff686D76)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0),
                                        child: Text(
                                          "Avni Rai profile has an ${profile.matchPercentage} with yours.",
                                          style: customTextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff2C3377)),
                                        ),
                                      ),
                                      height(12),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 12),
                                        child: Row(
                                          children: [
                                            Material(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  try {
                                                    String? contactNumber =
                                                        profile.parentContact;
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
                                                            SnackPosition
                                                                .BOTTOM,
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
                                                  height: Get.height * 0.043,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffffffff),
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
                                                      textAlign:
                                                          TextAlign.center,
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
                                                      profile.parentContact;

                                                  if (contactNumber != null) {
                                                    String phoneNumber =
                                                        contactNumber
                                                            .replaceAll(
                                                                RegExp(r'\D'),
                                                                '');

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
                                                  height: Get.height * 0.043,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Color(0xff2A3171),
                                                          Color(0xff4E5CD3)
                                                        ],
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
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

//
