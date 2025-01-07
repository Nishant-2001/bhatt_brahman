import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    void _launchURL(String url) async {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Text(
            "Privacy Policy",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Introduction",
                          style: customTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff2A3171)),
                        ),
                        height(10),
                        const Divider(),
                        height(20),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Welcome to the Bhatt Brahman Var Vadhu App. ',
                                style: customTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffCB333C))),
                            TextSpan(
                                text:
                                    "We are committed to protecting your privacy and ensuring that your personal information is handled securely and responsibly. This Privacy Policy outlines how we collect, use, and protect your data when you use our services.",
                                style: customTextStyle(
                                    fontSize: 14,
                                    color: const Color(0xff686D76)))
                          ]),
                        ),
                        height(30),
                        Text(
                          "1. Information We Collect",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        height(10),
                        Text(
                          "We may collect the following types of information:",
                          style: customTextStyle(
                              fontSize: 14, color: const Color(0xff686D76)),
                        ),
                        height(15),
                        _buildInfoItem("Personal Information:",
                            "Name, age, gender, marital status, contact details, height, weight, and other profile details you provide during registration."),
                        height(10),
                        _buildInfoItem("Usage Data:",
                            "Information about how you interact with the App, such as features accessed, pages visited, and preferences."),
                        height(10),
                        _buildInfoItem("Device Information:",
                            "Details about the device you use, such as the operating system, browser type, and IP address."),
                        height(30),
                        Text(
                          "2. How We Use Your Information",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        Text(
                          "We use the collected information for the following purposes:",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        height(15),
                        _buildBulletPoint(
                            "To create and manage user profiles."),
                        height(10),
                        _buildBulletPoint(
                            "To facilitate matches based on user preferences and criteria."),
                        height(10),
                        _buildBulletPoint(
                            "To improve the App's functionality and user experience."),
                        height(10),
                        _buildBulletPoint(
                            "To communicate with users regarding updates, notifications, and support."),
                        height(20),
                        Text(
                          "3. Sharing of Information",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        Text(
                          "We do not sell, rent, or trade your personal information. However, we may share your data with:",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        height(15),
                        _buildInfoItem("Other Users: ",
                            ": Limited profile information may be visible to other users based on the matchmaking criteria."),
                        height(10),
                        _buildInfoItem("Service Providers: ",
                            "Trusted third-party vendors for hosting, analytics, or customer support services."),
                        height(10),
                        _buildInfoItem("Legal Authorities: ",
                            "When required by law or to protect the rights and safety of our users."),
                        height(30),
                        Text(
                          "4. Data Security",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        height(3),
                        Text(
                          "We take reasonable measures to protect your information from unauthorized access, alteration, or disclosure. However, no system can be completely secure, and we cannot guarantee absolute security of your data.",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(15),
                        Text(
                          "5. User Rights",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        Text(
                          "You have the following rights regarding your data:",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(15),
                        _buildInfoItem("Access and Update:  ",
                            ": View and update your personal information through the App."),
                        height(10),
                        _buildInfoItem("Delete Account:  ",
                            "Request the deletion of your account and associated data."),
                        height(10),
                        _buildInfoItem("Withdraw Consent:  ",
                            "Revoke your consent for specific data processing activities."),
                        height(30),
                        Text(
                          "6. Cookies and Tracking Technologies",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        height(3),
                        Text(
                          "The App may use cookies or similar technologies to enhance user experience and analyze usage patterns. You can modify your device settings to disable cookies if preferred.",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(30),
                        Text(
                          "7. Changes to This Privacy Policy",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        Text(
                          "We may update this Privacy Policy from time to time. Any changes will be notified within the App or via email, where applicable.",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(30),
                        Text(
                          "8. Contact Us",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        Text(
                          "You have the following rights regarding your data:",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "Bhatt Brahman Var Vadhu",
                          style: customTextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "102 A, Shiv Smriti, 1st Floor, N M Joshi Marg,",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "Lower Parel (East), Mumbai 400013",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "+91 9833653101, +91 9773086693, +91 9892372479",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "ajsbbct@gmail.com",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchURL('www.bhattbrahmanvarvadhu.com');
                          },
                          child: Text(
                            "www.bhattbrahmanvarvadhu.com",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171)),
                          ),
                        ),
                        height(30),
                        Text(
                          "9. Change in Policy",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffCB333C)),
                        ),
                        height(3),
                        Text(
                          "We can change/update this Privacy Policy as and when required. We recommend that you check our website from time-to-time to update yourself of any changes in this Privacy Policy or any of our other policies.",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(40)
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

  Widget _buildInfoItem(String title, String content) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '⚫ $title ',
            style: customTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2A3171),
            ),
          ),
          TextSpan(
            text: content,
            style: customTextStyle(
              fontSize: 14,
              color: const Color(0xff686D76),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "⚫ ",
          style: customTextStyle(
            fontSize: 14,
            color: const Color(0xff2A3171),
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: customTextStyle(
              fontSize: 14,
              color: const Color(0xff686D76),
            ),
          ),
        ),
      ],
    );
  }
}
