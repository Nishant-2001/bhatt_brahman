import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../controller/verification_controller.dart';
import '../model/partner_model.dart';
import '../views/pages/create_profile_page.dart';
import '../views/pages/match_partner_page.dart';

class FindMatchesWidget extends StatelessWidget {
  final List<PartnerModel> partners;
  FindMatchesWidget({super.key, required this.partners});

  final VerificationController verificationController =
      Get.put(VerificationController());

  Future<void> handleVerificationStatus() async {
    final verificationStatus =
        await verificationController.fetchVerificationStatus();

    if (verificationStatus != null) {
      if (verificationStatus == 'Incomplete') {
        Get.to(() => const EditProfilePage());
      } else if (verificationStatus == 'Pending') {
        Get.dialog(
          AlertDialog(
            title: const Text("Verification Pending"),
            content: const Text("Your verification status is pending."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else if (verificationStatus == 'Active') {
        try {
          List<PartnerModel> partners = await findController.fetchPartners();

          if (partners.isEmpty) {
            Get.to(() => MatchPartnerPage(
                  partners: partners,
                  message: 'No customer data found.',
                ));
          } else {
            Get.to(() => MatchPartnerPage(
                  partners: partners,
                  message: '',
                ));
          }
        } catch (e) {
          Get.to(() => MatchPartnerPage(
                partners: const [],
                message: e.toString(),
              ));
        }
      } else if (verificationStatus == 'Rejected') {
        Get.dialog(
          AlertDialog(
            title: const Text("Verification Rejected"),
            content: const Text("Your verification status is Rejected."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else if (verificationStatus == 'Blocked') {
        Get.dialog(
          AlertDialog(
            title: const Text("Verification Blocked"),
            content: const Text("Your verification status is Blocked."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.14,
          decoration: BoxDecoration(
              color: const Color(0xffFFE7E0),
              borderRadius: BorderRadius.circular(7)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Looking for a partner to share a\n beautiful journey that lasts forever?",
                  style: GoogleFonts.sourceSans3(
                      textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffE8461C))),
                ),
                height(10),
                Material(
                  color: const Color(0xffFFE7E0),
                  child: GestureDetector(
                    onTap: searchController.isLoading.value
                        ? null
                        : () async {
                            await handleVerificationStatus();
                          },
                    child: Container(
                      width: Get.width * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff2A3171), Color(0xff4E5CD3)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: searchController.isLoading.value
                            ? const CupertinoActivityIndicator(
                                color: Color(0xffffffff),
                              )
                            : Text(
                                "Find",
                                style: GoogleFonts.sourceSans3(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Color(0xffFFFFFF))),
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/var-vadhu1.png",
              height: Get.height * 0.17,
            ))
      ],
    );
  }
}
