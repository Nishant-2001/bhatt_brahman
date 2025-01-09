import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../model/Shortlisted_model.dart';
import 'block_profile_detail_page.dart';

class BlockedProfilePage extends StatefulWidget {
  const BlockedProfilePage({super.key});

  @override
  State<BlockedProfilePage> createState() => _BlockedProfilePageState();
}

class _BlockedProfilePageState extends State<BlockedProfilePage> {
  late Future<List<ShortlistedModel>> blockedFuture;

  @override
  void initState() {
    super.initState();
    blockedFuture = blockProfileController.fetchBlockedProfileData();
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
            "Blocked Profiles",
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
                  child: FutureBuilder<List<ShortlistedModel>>(
                      future: blockedFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              "No Blocked profiles found.",
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
                                    Get.to(() => BlockProfileDetailPage(profile: profile));
                                  },
                                  child: Container(
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff9C9C9C)),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              NetworkImage(profile.profileImg),
                                        ),
                                        title: Text(
                                          "${profile.firstName} ${profile.lastName}",
                                          style: customTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        subtitle: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${profile.age} Yrs | ${profile.height} cm",
                                                  style: customTextStyle(
                                                      color: const Color(
                                                          0xff686D76)),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .work_outline_outlined,
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
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .location_on_outlined,
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
                                            height(7),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Material(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      blockProfileController
                                                          .removeBlockedRequest(
                                                              profile
                                                                  .blockPersonId);
                                                      setState(() {
                                                        blockedFuture =
                                                            blockProfileController
                                                                .fetchBlockedProfileData();
                                                      });
                                                    },
                                                    child: Container(
                                                      width: Get.width * 0.3,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffffffff),
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xffFF0000)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      25)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 7.0),
                                                        child: Text(
                                                          "Unblock",
                                                          style: GoogleFonts.sourceSans3(
                                                              textStyle: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0xffFF0000))),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
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



// 
