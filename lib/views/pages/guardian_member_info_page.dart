import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';
import '../../controller/guardian_committee_controller.dart';
import '../../model/founder_committee_model.dart';
import '../../model/guardian_committee_model.dart';

class GuardianMemberInfoPage extends StatefulWidget {
  const GuardianMemberInfoPage({super.key});

  @override
  State<GuardianMemberInfoPage> createState() => _GuardianMemberInfoPageState();
}

class _GuardianMemberInfoPageState extends State<GuardianMemberInfoPage> {
  late Future<GuardianCommitteeModel?> _futureCommittee;

  final Set<String> _expandedItems = {};

  @override
  void initState() {
    super.initState();
    _futureCommittee = GuardianCommitteeController.fetchCommitteeData();
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
            "संरक्षक मंडल",
            style: customTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xffffffff)),
          ),
        ),
        centerTitle: true,
        actions: [
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
                  child: FutureBuilder<GuardianCommitteeModel?>(
                      future: _futureCommittee,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'An error occurred: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          final committeeList = snapshot.data!.committee;
                          if (committeeList == null || committeeList.isEmpty) {
                            return const Center(
                                child: Text("No data available"));
                          }
                          return ListView.builder(
                              padding: const EdgeInsets.all(12.0),
                              itemCount: committeeList.length,
                              itemBuilder: (context, index) {
                                final committee = committeeList[index];
                                final isExpanded =
                                    _expandedItems.contains(committee.id ?? '');
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                            color: const Color(0xff9C9C9C))),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: committee
                                                        .committeeImage !=
                                                    null
                                                ? NetworkImage(
                                                    committee.committeeImage!)
                                                : null,
                                            child:
                                                committee.committeeImage == null
                                                    ? const Icon(Icons.person)
                                                    : null,
                                          ),
                                          title: Text(
                                            committee.name ?? "N/A",
                                            style: customTextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff383838)),
                                          ),
                                          subtitle: Text(
                                            committee.positionHindi ?? "N/A",
                                            style: customTextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff686D76)),
                                          ),
                                          trailing: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (isExpanded) {
                                                    _expandedItems.remove(
                                                        committee.id ?? '');
                                                  } else {
                                                    _expandedItems.add(
                                                        committee.id ?? '');
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                isExpanded
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                              )),
                                        ),
                                        height(5),
                                        if (isExpanded)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 6),
                                            child: Text(
                                              committee.description ?? "N/A",
                                              style: customTextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xff686D76)),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(child: Text("No data available"));
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }
}
