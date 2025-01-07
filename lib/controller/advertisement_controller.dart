import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/advertisement_model.dart';

class AdvertisementController extends GetxController {
  var isLoading = true.obs;
  var advertisements = <Advertisement>[].obs;

  @override
  void onInit() {
    fetchAdvertisements();
    super.onInit();
  }

  Future<void> fetchAdvertisements() async {
    try {
      isLoading(true);
      const url = '${baseUrl}advertisement_list';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 200) {
          advertisements.value = (data['data'] as List)
              .map((item) => Advertisement.fromJson(item))
              .toList();
        }
      } else {
        Get.snackbar("Error", "Failed to fetch advertisements.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
