import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';

class BlockedProfilePage extends StatelessWidget {
  const BlockedProfilePage({super.key});

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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: ListTile(
                              isThreeLine: true,
                              leading: const CircleAvatar(
                                radius: 30,
                              ),
                              title: Text(
                                "Shailesh Sharma",
                                style: customTextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "26 Yrs | 165 cm",
                                        style: customTextStyle(
                                            color: const Color(0xff686D76)),
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
                                            "Doctor",
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
                                            color: Color(0xffE8461C),
                                            size: 18,
                                          ),
                                          width(4),
                                          Text(
                                            "Mumbai",
                                            style: customTextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff686D76)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  height(7),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: Get.width * 0.3,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffFF0000)),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7.0),
                                              child: Text(
                                                "Unblock",
                                                style: GoogleFonts.sourceSans3(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xffFF0000))),
                                                textAlign: TextAlign.center,
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
                        height(20),
                        Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: ListTile(
                              isThreeLine: true,
                              leading: const CircleAvatar(
                                radius: 30,
                              ),
                              title: Text(
                                "Shailesh Sharma",
                                style: customTextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "26 Yrs | 162 cm",
                                        style: customTextStyle(
                                            color: const Color(0xff686D76)),
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
                                            "Doctor",
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
                                            color: Color(0xffE8461C),
                                            size: 18,
                                          ),
                                          width(4),
                                          Text(
                                            "Mumbai",
                                            style: customTextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff686D76)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  height(7),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: Get.width * 0.3,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                border: Border.all(
                                                    color: const Color(
                                                        0xffFF0000)),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7.0),
                                              child: Text(
                                                "Unblock",
                                                style: GoogleFonts.sourceSans3(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xffFF0000))),
                                                textAlign: TextAlign.center,
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
                        height(20),
                        Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xff9C9C9C)),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: ListTile(
                              isThreeLine: true,
                              leading: const CircleAvatar(
                                radius: 30,
                              ),
                              title: Text(
                                "Shailesh Sharma",
                                style: customTextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "26 Yrs | 164 cm",
                                        style: customTextStyle(
                                            color: const Color(0xff686D76)),
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
                                            "Doctor",
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
                                            color: Color(0xffE8461C),
                                            size: 18,
                                          ),
                                          width(4),
                                          Text(
                                            "Mumbai",
                                            style: customTextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xff686D76)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  height(7),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Material(
                                        child: Container(
                                          width: Get.width * 0.3,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffffffff),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffFF0000)),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7.0),
                                            child: Text(
                                              "Unblock",
                                              style: GoogleFonts.sourceSans3(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12,
                                                      color:
                                                          Color(0xffFF0000))),
                                              textAlign: TextAlign.center,
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
                      ],
                    ),
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
