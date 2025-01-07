import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';
import '../../widgets/accepted_interest_widget.dart';
import '../../widgets/pending_interested_widget.dart';
import '../../widgets/rejected_interest_widget.dart';

class AcceptedInterestPage extends StatefulWidget {
  const AcceptedInterestPage({super.key});

  @override
  State<AcceptedInterestPage> createState() => _AcceptedInterestPageState();
}

class _AcceptedInterestPageState extends State<AcceptedInterestPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppConstant.appMainColor,
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          iconTheme: const IconThemeData(color: Color(0xffffffff)),
          title: Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: Text(
              "My Interests",
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(25)),
                          child: TabBar(
                              dividerColor: Colors.transparent,
                              labelColor: Colors.white,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                  color: const Color(0xff434343),
                                  borderRadius: BorderRadius.circular(25)),
                              tabs: const [
                                Tab(
                                  text: "Accepted",
                                ),
                                Tab(
                                  text: "Pending",
                                ),
                                Tab(
                                  text: "Rejected",
                                ),
                              ]),
                        ),
                        height(30),
                        Expanded(
                            child: TabBarView(children: [
                          AcceptedInterestWidget(),
                          PendingInterestedWidget(),
                          RejectedInterestWidget(),
                        ]))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
