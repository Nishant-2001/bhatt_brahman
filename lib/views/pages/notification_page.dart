import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';

class NotificationPage extends StatelessWidget {
  final RemoteMessage? message;
  const NotificationPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final notification = message?.notification;
    notificationController.fetchNotifications();

    return Scaffold(
      backgroundColor: const Color(0xffE94C22),
      appBar: AppBar(
        backgroundColor: const Color(0xffE94C22),
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Text(
          "Notifications",
          style: customTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xffffffff),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: Get.width * 0.9,
              height: Get.height * 0.015,
              decoration: BoxDecoration(
                color: const Color(0xffffffff).withOpacity(.50),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 223, 219, 219),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffffffff),
                          border: Border.all(
                              color: const Color.fromARGB(255, 240, 237, 237)),
                        ),
                        child: ListTile(
                          title: Text(
                            notification?.title ?? "No Title",
                            style: customTextStyle(fontSize: 14),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification?.body ?? "No Body",
                                style: customTextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Obx(() {
                        if (notificationController.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (notificationController
                            .notifications.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.notifications_none,
                                size: 48,
                                color: Color(0xff9C9C9C),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "No new notifications",
                                style: customTextStyle(
                                  fontSize: 14,
                                  color: const Color(0xff9C9C9C),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                notificationController.notifications.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final notification =
                                  notificationController.notifications[index];
                              return Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 240, 237, 237)),
                                ),
                                child: ListTile(
                                  title: Text(
                                    notification.title,
                                    style: customTextStyle(fontSize: 14),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification.body,
                                        style: customTextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
