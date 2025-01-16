import 'package:bhatt_brahman_var_vadhu/constants/instance.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';
import '../../model/partner_model.dart';
import 'find_match_profile_page.dart';
import 'notification_page.dart';

class MatchPartnerPage extends StatelessWidget {
  final List<PartnerModel> partners;
  final String? message;

  const MatchPartnerPage({super.key, required this.partners, this.message});

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
            "Find Matches",
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
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: partners.isEmpty
                      ? Center(
                          child: Text(
                            message ?? "No matches found",
                            style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff686D76),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: partners.length,
                          itemBuilder: (context, index) {
                            final partner = partners[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  viewProfileController
                                      .openProfilePage(partner.id);
                                  Get.to(() =>
                                      FindMatchProfilePage(partner: partner));
                                },
                                child: Container(
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff9C9C9C)),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: "${partner.profileImg}",
                                            placeholder: (context, url) =>
                                                const CupertinoActivityIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              partner.userType == "Bride"
                                                  ? "assets/bride.jpg"
                                                  : "assets/groom.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        "${partner.firstName} ${partner.lastName}",
                                        style: customTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: SingleChildScrollView(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${partner.age} Yrs | ${partner.height} cm",
                                              style: customTextStyle(
                                                  color:
                                                      const Color(0xff686D76)),
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
                                                  "${partner.profession?.split(' ').first}...",
                                                  style: customTextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xff686D76)),
                                                ),
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
                                                  "${partner.livesIn?.split(' ').first}...",
                                                  style: customTextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xff686D76)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
