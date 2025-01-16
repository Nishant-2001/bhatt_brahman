import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../model/viewed_profile_model.dart';
import 'notification_page.dart';
import 'viewed_profile_detail_page.dart';

class ViewedProfilePage extends StatefulWidget {
  const ViewedProfilePage({super.key});

  @override
  State<ViewedProfilePage> createState() => _ViewedProfilePageState();
}

class _ViewedProfilePageState extends State<ViewedProfilePage> {
  late Future<ViewedProfileResponse> profileResponse;

  @override
  void initState() {
    super.initState();

    profileResponse = viewProfileController.fetchProfiles();
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
            "Viewed Profile",
            style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xffffffff)),
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Image.asset(
          //     'assets/Vector.png',
          //     height: 24,
          //     width: 24,
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Get.to(() => const NotificationPage());
            },
            child: const Icon(
              Icons.notifications_outlined,
              size: 28,
            ),
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
                    child: FutureBuilder<ViewedProfileResponse>(
                        future: profileResponse,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: customTextStyle(fontSize: 14),
                              ),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.data.isNotEmpty) {
                            final profiles = snapshot.data!.data;
                            return ListView.builder(
                                padding: const EdgeInsets.all(16.0),
                                itemCount: profiles.length,
                                itemBuilder: (context, index) {
                                  final profile = profiles[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => ViewedProfileDetailPage(
                                            profile: profile));
                                      },
                                      child: Container(
                                        width: Get.width,
                                        height: Get.height * 0.09,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff9C9C9C)),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        child: Center(
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  const Color(0xffffffff),
                                              child: ClipOval(
                                                child: Image.network(
                                                  profile.profileImg,
                                                  fit: BoxFit.cover,
                                                  width: 60,
                                                  height: 60,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      profile.userType ==
                                                              "Bride"
                                                          ? 'assets/bride.jpg'
                                                          : 'assets/groom.jpg',
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              "${profile.firstName} ${profile.lastName}",
                                              style: customTextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${profile.age} yrs | ${profile.height} cm",
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
                                                      profile.professionName
                                                          .split(" ")
                                                          .first,
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
                                                      profile.workLocationName
                                                          .split(" ")
                                                          .first,
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
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            return Center(
                              child: Text(
                                'No profiles found.',
                                style: customTextStyle(fontSize: 14),
                              ),
                            );
                          }
                        })))
          ],
        ),
      ),
    );
  }
}
