import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../model/location_model.dart';
import '../../model/marital_status_model.dart';
import '../../model/partner_model.dart';
import '../../widgets/body_skin_type_widget.dart';
import '../../widgets/education_profession_widget.dart';
import '../../widgets/min_age_height_widget.dart';
import 'find_matches_page.dart';
import 'notification_page.dart';

class SearchMacthesPage extends StatefulWidget {
  const SearchMacthesPage({super.key});

  @override
  State<SearchMacthesPage> createState() => _SearchMacthesPageState();
}

class _SearchMacthesPageState extends State<SearchMacthesPage> {
  late Future<MaritalStatusResponse> futuremaritalStatusList;
  late Future<LocationResponse> futurelocationList;

  @override
  void initState() {
    super.initState();
    futuremaritalStatusList = dropdownController.fetchMaritalStatus();
    futurelocationList = dropdownController.fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const NotificationPage());
            },
            child: const Icon(
              Icons.notifications_outlined,
              size: 28,
            ),
          ),
          width(20)
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
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Search your partner",
                            style: customTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff373A40)),
                          ),
                        ),
                        height(30),
                        const MinAgeHeightWidget(),
                        height(15),
                        const BodySkinTypeWidget(),
                        height(6),
                        Text(
                          "Marital Status",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(10),
                        FutureBuilder<MaritalStatusResponse>(
                          future: futuremaritalStatusList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CupertinoActivityIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data?.maritalStatusList.isEmpty ==
                                    true) {
                              return const Center(
                                  child: Text('No marital status available'));
                            }

                            var maritalStatusList =
                                snapshot.data!.maritalStatusList;

                            return DropdownButtonFormField<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select ',
                                style: customTextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  var selectedMaritalStatus = maritalStatusList
                                      .firstWhere(
                                          (maritalStatus) =>
                                              maritalStatus.id == newValue,
                                          orElse: () => maritalStatusList.first)
                                      .name;
                                  searchController.maritalStatus =
                                      selectedMaritalStatus;
                                });
                              },
                              items: maritalStatusList.map((maritalStatus) {
                                return DropdownMenuItem<String>(
                                  value: maritalStatus.id,
                                  child: Text(
                                    maritalStatus.name,
                                    style: customTextStyle(
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff9C9C9C)),
                                ),
                              ),
                            );
                          },
                        ),
                        height(15),
                        const EducationProfessionWidget(),
                        height(6),
                        Text(
                          "Location",
                          style: customTextStyle(
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff686D76)),
                        ),
                        height(10),
                        FutureBuilder<LocationResponse>(
                          future: futurelocationList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CupertinoActivityIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data?.locationList.isEmpty == true) {
                              return const Center(
                                  child: Text('No location available'));
                            }

                            var locationList = snapshot.data!.locationList;
                            String? initialSelection =
                                searchController.location;

                            return DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: "Search location...",
                                    prefixIcon: const Icon(Icons.search),
                                  ),
                                ),
                                fit: FlexFit.loose,
                                constraints:
                                    const BoxConstraints(maxHeight: 350),
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff9C9C9C)),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                ),
                              ),
                              selectedItem: initialSelection,
                              asyncItems: (String filter) async {
                                return locationList
                                    .where((location) => location.name
                                        .toLowerCase()
                                        .contains(filter.toLowerCase()))
                                    .map((location) => location.name)
                                    .toList();
                              },
                              dropdownButtonProps: const DropdownButtonProps(
                                color: Color(0xff9C9C9C),
                              ),
                              dropdownBuilder: (context, selectedItem) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 1),
                                  child: Text(
                                    selectedItem ?? 'Select',
                                    style: customTextStyle(
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    searchController.location = newValue;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select location';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        height(30),
                        Material(
                          child: GestureDetector(
                            onTap: findController.isLoading.value
                                ? null
                                : () async {
                                    try {
                                      if (!searchController
                                          .isAnyFieldFilled()) {
                                        Get.snackbar(
                                          'Field Required',
                                          'Please fill at least one search field.',
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }

                                      List<PartnerModel> partners =
                                          await searchController
                                              .fetchPartners();

                                      if (partners.isNotEmpty) {
                                        Get.to(() => FindMatchesPage(
                                              partners: partners,
                                              message: '',
                                            ));
                                      } else {
                                        Get.snackbar(
                                          'No Results Found',
                                          'No customer data matches your search criteria.',
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white,
                                        );
                                      }
                                    } catch (e) {
                                      Get.snackbar(
                                        'Not Found',
                                        "No customer data found",
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                      );
                                    }
                                  },
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.05,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff2A3171),
                                      Color(0xff4E5CD3)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Obx(() => findController.isLoading.value
                                  ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CupertinoActivityIndicator(
                                            color: Colors.white),
                                        SizedBox(width: 10),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 7.0),
                                          child: Text(
                                            "Loading...",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Search",
                                      style: GoogleFonts.sourceSans3(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: Color(0xffFFFFFF))),
                                      textAlign: TextAlign.center,
                                    )),
                            ),
                          ),
                        ),
                      ],
                    ),
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
