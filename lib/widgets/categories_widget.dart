import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/data.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../views/pages/create_profile_page.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  Future<void> handleVerificationStatus(Function onTap) async {
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
        onTap();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 110),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.8,
              ),
              itemCount: categoryData.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () async {
                    await handleVerificationStatus(
                      categoryData[i]["onTap"],
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: const Color(0xffFFDF8E)),
                          color: const Color(0xffFFEBC6),
                        ),
                        child: Image.asset(
                          categoryData[i]["image"],
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        categoryData[i]["name"],
                        style: customTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
