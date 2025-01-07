import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/text_style.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
            " About Us",
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
                          "About Bhatt Brahman Var Vadhu",
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
                                text: 'भट्ट ब्राह्मण समाज  ',
                                style: customTextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xffCB333C))),
                            TextSpan(
                                text:
                                    "एक ऐसा समुदाय है जो अपनी परंपराओं, संस्कृति, और वैदिक ज्ञान के लिए प्रसिद्ध है। यह समुदाय प्राचीन काल से ही भारतीय सभ्यता और संस्कृति के निर्माण में एक महत्वपूर्ण भूमिका निभाता आ रहा है। भट्ट ब्राह्मण मुख्य रूप से धार्मिक और शैक्षणिक गतिविधियों से जुड़े होते हैं और समाज में उच्च मानवीय मूल्यों और शिक्षा का प्रचार करते हैं।",
                                style: customTextStyle(
                                    fontSize: 14,
                                    color: const Color(0xff2A3171)))
                          ]),
                        ),
                        height(30),
                        Text(
                          "भट्ट ब्राह्मण समाज की विशेषताएँ",
                          style: customTextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xffCB333C)),
                        ),
                        height(10),
                        Text("धार्मिक परंपराएँ:",
                            style: customTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffCB333C))),
                        height(6),
                        Text("⚫ वैदिक रीति-रिवाजों और संस्कारों का पालन करना।",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171))),
                        Text("⚫ यज्ञ, पूजा, और धार्मिक अनुष्ठानों में पारंगत।",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171))),
                        height(10),
                        Text("शिक्षा और ज्ञान:",
                            style: customTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffCB333C))),
                        height(6),
                        Text("⚫ शिक्षा और ज्ञान को जीवन का आधार मानना।",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171))),
                        Text(
                            "⚫ वेदों, उपनिषदों और शास्त्रों का अध्ययन और प्रचार।",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171))),
                        height(10),
                        Text("सामाजिक योगदान:",
                            style: customTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffCB333C))),
                        height(6),
                        Text("⚫ समाज में नैतिकता और मानवीय मूल्यों का प्रचार।",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171))),
                        Text(
                          "⚫ जरूरतमंदों की मदद करना और समाज को संगठित करना।",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        height(10),
                        height(10),
                        Text("परिवार और विवाह परंपराएँ:",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xffCB333C))),
                        height(6),
                        Text(
                            "⚫पारंपरिक रीति-रिवाजों का पालन करते हुए विवाह को एक पवित्र बंधन मानना।",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171))),
                        Text(
                          "⚫ जरूरतमंदों की मदद करना और समाज को संगठित करना।",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        height(10),
                        Text(
                          "भट्ट ब्राह्मण वर-वधू ऐप",
                          style: customTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffCB333C)),
                        ),
                        height(6),
                        Text(
                          "भट्ट ब्राह्मण समुदाय को जोड़ने और विवाह के लिए उचित जीवनसाथी खोजने के उद्देश्य से यह ऐप एक अद्वितीय मंच प्रदान करता है।",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        height(6),
                        Text(
                          "⚫ समुदाय की परंपराओं और मूल्यों को ध्यान में रखते हुए, यह ऐप केवल भट्ट ब्राह्मण समुदाय के सदस्यों के लिए डिज़ाइन किया गया है।",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "⚫ पंजीकरण, प्रोफाइल निर्माण, और संपर्क सुविधा सरल और सुरक्षित हैं।",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        Text(
                          "⚫ ऐप पर नियम और शर्तें पारदर्शी और उपयोगकर्ता के अनुकूल हैं।",
                          style: customTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff2A3171)),
                        ),
                        height(15),
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
