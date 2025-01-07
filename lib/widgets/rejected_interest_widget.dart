import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/text_style.dart';
import '../controller/interest_rejected_controller.dart';

class RejectedInterestWidget extends StatelessWidget {
  RejectedInterestWidget({super.key}) {
    controller.fetchInterestRejectedList();
  }

  final InterestRejectedController controller =
      Get.put(InterestRejectedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.interestRejectedList.isEmpty) {
            return const Center(
              child: Text(
                "No Rejected interests found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.interestRejectedList.length,
            itemBuilder: (context, index) {
              final item = controller.interestRejectedList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff9C9C9C)),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${item.age} Yrs | ${item.height} cm",
                              style: customTextStyle(
                                  fontSize: 12, color: const Color(0xff686D76)),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.work_outline,
                                  size: 16,
                                  color: Color(0xffE8461C),
                                ),
                                Text(
                                  item.professionName ?? '',
                                  style: customTextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff686D76)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Color(0xffE8461C),
                                ),
                                Text(
                                  item.livesInName ?? '',
                                  style: customTextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff686D76)),
                                )
                              ],
                            ),
                          ],
                        ),
                        height(6),
                        Text(
                          "Your request has been rejected by ${item.firstName} ${item.lastName}.",
                          style: customTextStyle(
                              fontSize: 10,
                              color: const Color(0xffEB4E25),
                              fontWeight: FontWeight.w500),
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
