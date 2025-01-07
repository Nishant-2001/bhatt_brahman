import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

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
            "Terms & Conditions",
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
                          "Terms & Conditions",
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
                                    color: const Color(0xffCB333C),
                                    fontWeight: FontWeight.bold)),
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
                          "1. Eligibility",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "1.1 The App is intended exclusively for individuals of Bhatt Brahman community seeking matrimonial alliances. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "1.2 Users must be at least 18 years of age to register and use this App.  ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "1.3 By registering, you confirm that all information provided is accurate, current, and complete.  ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "2. Registration and Account Security",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "2.1 You are responsible for maintaining the confidentiality of your account credentials. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "2.2 You must not create multiple accounts or impersonate another individual. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "2.3 The App reserves the right to suspend or terminate accounts for any suspicious activity or violation of these terms. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "3. Registration and Account Security",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "3.1 Users must behave respectfully and courteously within the App and avoid any offensive, defamatory, or inappropriate language. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "3.2 Harassment, stalking, spamming, or sharing of unsolicited material is strictly prohibited. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "3.3 You must not use the App for any unlawful purposes or for commercial promotions outside its intended use. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "4. Registration and Account Security",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "4.1 Users are responsible for the content they share, including personal details, photos, and other information. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "4.2 By using the App, you consent to the collection, use, and sharing of your information as described in our Privacy Policy. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "4.3 The App is not liable for any misuse of information shared by users within or outside the App. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "5. Matching and Communication",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "5.1 The App facilitates connections but does not guarantee successful matches or alliances.",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "5.2 Users are solely responsible for their interactions and are encouraged to verify the authenticity of other users independently. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "5.3 The App is not responsible for any disputes, misunderstandings, or issues arising from user interactions.",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "6. Intellectual Property",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "6.1 All content, trademarks, logos, and designs associated with the App are the intellectual property of the App developers and cannot be used without prior permission. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "6.2 Users must not copy, modify, distribute, or reverse-engineer any part of the App. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "7. Termination of Use",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "7.1 The App reserves the right to suspend or terminate access to any user who violates these terms or engages in suspicious activity.  ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "7.2 Users can delete their account at any time, but no refunds will be issued for unused subscription periods. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "8. Disclaimers and Limitations of Liability",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          '8.1 The App is provided "as is," without warranties of any kind, either expressed or implied.  ',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          "8.2 The App is not responsible for any damages, losses, or disputes resulting from the use of its services. ",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "9. Amendments",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          '9.1 These terms may be updated periodically. Users will be notified of significant changes, and continued use of the App indicates acceptance of the updated terms.',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "10. Governing Law",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          '10.1 These terms shall be governed by and construed in accordance with the laws of Maharashtra Administrative Tribunal. ',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          '10.2 Any disputes arising from these terms or the use of the App will be subject to the exclusive jurisdiction of the courts in Maharashtra Administrative Tribunal.  ',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(5),
                        Text(
                          "11. Contact Us",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          'For any questions, concerns, or feedback regarding these terms, please contact us at: ',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          'Bhatt Brahman Var Vadhu ',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          '102 A, Shiv Smriti, 1st Floor, N M Joshi Marg, ',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          'Lower Parel (East), Mumbai 400013 ',
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        Text(
                          '+91 9833653101, +91 9773086693, +91 9892372479',
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
                        height(50)
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
