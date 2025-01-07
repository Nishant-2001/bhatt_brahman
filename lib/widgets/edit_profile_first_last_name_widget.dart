import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/location_model.dart';

class EditProfileFirstLastNameWidget extends StatefulWidget {
  const EditProfileFirstLastNameWidget({super.key});

  @override
  State<EditProfileFirstLastNameWidget> createState() =>
      _EditProfileFirstLastNameWidgetState();
}

class _EditProfileFirstLastNameWidgetState
    extends State<EditProfileFirstLastNameWidget> {
  late Future<LocationResponse> futurelocationList;
  @override
  void initState() {
    super.initState();
    futurelocationList = dropdownController.fetchLocation();
    editProfileController.loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.11,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Native Place",
                  style: customTextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                  textAlign: TextAlign.left,
                ),
                height(6),
                Flexible(
                    child: FutureBuilder<LocationResponse>(
                  future: futurelocationList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.locationList.isEmpty == true) {
                      return const Center(child: Text('No location available'));
                    }

                    var locationList = snapshot.data!.locationList;
                    // var selectedValue =
                    //     editProfileController.selectedNativePlace;

                    LocationModel? selectedNativePlace = editProfileController
                                .selectedNativePlace !=
                            null
                        ? locationList.firstWhere((p) =>
                            p.id == editProfileController.selectedNativePlace)
                        : null;

                    return DropdownSearch<LocationModel>(
                      selectedItem: selectedNativePlace,
                      items: locationList,
                      itemAsString: (LocationModel? p) => p?.name ?? '',
                      onChanged: (LocationModel? newValue) {
                        setState(() {
                          editProfileController.selectedNativePlace =
                              newValue?.id;
                        });
                      },
                      dropdownBuilder: (context, selectedItem) {
                        return Text(
                          selectedItem?.name ?? 'Select',
                          style: customTextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search location...",
                          ),
                        ),
                        fit: FlexFit.loose,
                        constraints: BoxConstraints(maxHeight: 350),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                      dropdownButtonProps: const DropdownButtonProps(
                        color: Color(0xff9C9C9C),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Required";
                        }
                        return null;
                      },
                    );
                  },
                )),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lives In",
                  style: customTextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                  textAlign: TextAlign.left,
                ),
                height(6),
                Flexible(
                    child: FutureBuilder<LocationResponse>(
                  future: futurelocationList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.locationList.isEmpty == true) {
                      return const Center(child: Text('No location available'));
                    }

                    var locationList = snapshot.data!.locationList;
                    // var selectedValue = editProfileController.selectedLivesIn;

                    LocationModel? selectedLivesIn =
                        editProfileController.selectedLivesIn != null
                            ? locationList.firstWhere((p) =>
                                p.id == editProfileController.selectedLivesIn)
                            : null;

                    return DropdownSearch<LocationModel>(
                      selectedItem: selectedLivesIn,
                      items: locationList,
                      itemAsString: (LocationModel? p) => p?.name ?? '',
                      onChanged: (LocationModel? newValue) {
                        setState(() {
                          editProfileController.selectedLivesIn = newValue?.id;
                        });
                      },
                      dropdownBuilder: (context, selectedItem) {
                        return Text(
                          selectedItem?.name ?? 'Select',
                          style: customTextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search location...",
                          ),
                        ),
                        fit: FlexFit.loose,
                        constraints: BoxConstraints(maxHeight: 350),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                      dropdownButtonProps: const DropdownButtonProps(
                        color: Color(0xff9C9C9C),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Required";
                        }
                        return null;
                      },
                    );
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
