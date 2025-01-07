import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';
import 'executive_member_info_page.dart';
import 'founder_member_info_page.dart';
import 'guardian_member_info_page.dart';

class CommitteeInfoPage extends StatelessWidget {
  const CommitteeInfoPage({super.key});

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8461C),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        backgroundColor: const Color(0xffE8461C),
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            "Managing Committee",
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
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const FounderMemberInfoPage());
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: const Color(0xff9C9C9C)),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/brahmanlogo.png",
                                height: Get.height * 0.15,
                                width: Get.width,
                              ),
                              height(5),
                              Text(
                                "संस्थापक मंडल",
                                style: customTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff383838)),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _launchURL(
                          //     'https://mboxindia.com/bbvv/guardianmembers.php');
                          Get.to(() => const GuardianMemberInfoPage());
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: const Color(0xff9C9C9C)),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/brahmanlogo.png",
                                height: Get.height * 0.15,
                                width: Get.width,
                              ),
                              height(5),
                              Text(
                                "संरक्षक मंडल",
                                style: customTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff383838)),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // _launchURL(
                          //     'https://mboxindia.com/bbvv/foundermembers.php');
                          Get.to(() => const ExecutiveMemberInfoPage());
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: const Color(0xff9C9C9C)),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/brahmanlogo.png",
                                height: Get.height * 0.15,
                                width: Get.width,
                              ),
                              height(5),
                              Text(
                                "कार्यकारिणी मंडल",
                                style: customTextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff383838)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
