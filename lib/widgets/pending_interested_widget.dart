import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/text_style.dart';
import '../../constants/dimensions.dart';
import '../../controller/interest_pending_controller.dart';
import '../constants/instance.dart';
import '../views/pages/pending_request_detail_page.dart';

class PendingInterestedWidget extends StatelessWidget {
  PendingInterestedWidget({super.key}) {
    controller.fetchInterestPendingList();
  }

  final InterestPendingController controller =
      Get.put(InterestPendingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.interestPendingList.isEmpty) {
            return const Center(
              child: Text(
                "No pending interests found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.interestPendingList.length,
            itemBuilder: (context, index) {
              final item = controller.interestPendingList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => PendingRequestDetailPage(item: item));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff9C9C9C)),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(item.profileImg ?? ''),
                    ),
                    title: Text(
                      "${item.firstName} ${item.lastName}",
                      style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff383838)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 24,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "${item.age} Yrs | ${item.height} cm",
                                  style: customTextStyle(
                                    fontSize: 12,
                                    color: const Color(0xff686D76),
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.work_outline,
                                      size: 16,
                                      color: Color(0xffE8461C),
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        item.profession ?? '',
                                        style: customTextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff686D76),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      size: 16,
                                      color: Color(0xffE8461C),
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        item.livesIn ?? '',
                                        style: customTextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff686D76),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        height(6),
                        Text(
                          "Your request is still pending from ${item.firstName}'s end.",
                          style: customTextStyle(
                              fontSize: 10,
                              color: const Color(0xffEB4E25),
                              fontWeight: FontWeight.w500),
                        ),
                        height(8),
                        Material(
                          child: Container(
                            width: Get.width * 0.35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xffFF0000)),
                                borderRadius: BorderRadius.circular(25)),
                            child: GestureDetector(
                              onTap: () {
                                cancelRequestController
                                    .sendCancelRequest(item.id);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  "Unsend Request",
                                  style: GoogleFonts.sourceSans3(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Color(0xffFF0000))),
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
              );
            },
          );
        },
      ),
    );
  }
}
