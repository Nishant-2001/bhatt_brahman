import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../controller/recommended_controller.dart';
import 'notification_page.dart';
import 'recommended_for_you_detail_page.dart';

class RecommendedForYouPage extends StatelessWidget {
  final RecommendedController controller = Get.put(RecommendedController());

  RecommendedForYouPage({super.key});

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
            "Recommended for you",
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
          //     height: 22,
          //     width: 22,
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.partners.isEmpty) {
                      return const Center(
                        child: Text('No recommendations found'),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: controller.partners.map((partner) {
                          final age = controller.calculateAge(partner.dob);

                          return GestureDetector(
                            onTap: () {
                              viewProfileController.openProfilePage(partner.id);
                              Get.to(() => RecommendedForYouDetailPage(
                                  partner: partner));
                            },
                            child: Container(
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 20),
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
                                    child: partner.profileImg != null
                                        ? Image.network(
                                            partner.profileImg!,
                                            height: Get.height,
                                            width: Get.width,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.person,
                                                        size: 50),
                                          )
                                        : const Icon(Icons.person, size: 50),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "${partner.firstName} ${partner.lastName}",
                                      style: customTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // ignore: unnecessary_null_comparison
                                          "${age.isNotEmpty ? '$age Yrs' : ''} ${partner.height != null ? '| ${partner.height} cm' : ''}",
                                          style: customTextStyle(
                                              color: const Color(0xff686D76)),
                                        ),
                                        if (partner.profession != null)
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.work_outline_outlined,
                                                color: Color(0xffE8461C),
                                                size: 18,
                                              ),
                                              Text(
                                                partner.profession!,
                                                style: customTextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(
                                                        0xff686D76)),
                                              )
                                            ],
                                          ),
                                        if (partner.livesIn != null)
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                color: Color(0xffE8461C),
                                                size: 18,
                                              ),
                                              Text(
                                                partner.livesIn != null &&
                                                        partner
                                                            .livesIn!.isNotEmpty
                                                    ? "${partner.livesIn!.split(" ").first}..."
                                                    : "",
                                                style: customTextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(
                                                        0xff686D76)),
                                                overflow: TextOverflow.ellipsis,
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
                                      "${partner.firstName} profile has an ${partner.matchPercentage} with yours.",
                                      style: customTextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff2C3377)),
                                    ),
                                  ),
                                  height(8),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Material(
                                          child: Container(
                                            width: Get.width * 0.38,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffFF0000)),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: TextButton(
                                                onPressed: () {
                                                  cancelRequestController
                                                      .sendCancelRequest(
                                                          partner.id);
                                                },
                                                child: Text(
                                                  "Not Interested",
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
                                                )),
                                          ),
                                        ),
                                        // width(7),
                                        Material(
                                          child: Container(
                                            width: Get.width * 0.38,
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
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: TextButton(
                                                onPressed: () {
                                                  interestedPersonController
                                                      .sendInterestRequest(
                                                          partner.id);
                                                },
                                                child: Text(
                                                  "Interested",
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
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
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
