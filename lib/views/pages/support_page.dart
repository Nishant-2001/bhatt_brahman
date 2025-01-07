import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

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
            "Contact Us",
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Image.asset(
                          "assets/Support1.png",
                          height: Get.height * 0.3,
                        ),
                      ),
                      height(20),
                      Text(
                        "Hello! How can we help you?",
                        style: customTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                      ),
                      height(20),
                      Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: const Color(0xffE6E6E6))),
                            child: const Icon(
                              Icons.forum_outlined,
                              size: 28,
                              color: Color(0xffE8461C),
                            ),
                          ),
                          title: Text(
                            "Contact Through Chat",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff686D76)),
                          ),
                        ),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: const Color(0xffE6E6E6))),
                            child: const Icon(
                              Icons.call,
                              size: 28,
                              color: Color(0xffE8461C),
                            ),
                          ),
                          title: Text(
                            "Call Us ",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff686D76)),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "+91 9833653101,\n+91 9773086693, \n+91 9892372479",
                                style: customTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff686D76)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      height(10),
                      Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9C9C9C)),
                            borderRadius: BorderRadius.circular(7)),
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: const Color(0xffE6E6E6))),
                            child: const Icon(
                              Icons.mail_outline_outlined,
                              size: 28,
                              color: Color(0xffE8461C),
                            ),
                          ),
                          title: Text(
                            "Email Us",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff686D76)),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ajsbbct@gmail.com",
                                style: customTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff686D76)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      height(10),
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
