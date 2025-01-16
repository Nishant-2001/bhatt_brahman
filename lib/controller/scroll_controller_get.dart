// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollControllerGet extends GetxController {
  final ScrollController scrollController = ScrollController();

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    } else {
      // log("ScrollController not attached to any scrollable widget.");
    }
  }

  @override
  void onClose() {
    scrollController.dispose(); // Dispose of the ScrollController
    super.onClose();
  }
}
