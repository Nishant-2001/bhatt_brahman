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
import '../../widgets/preffered_age_height_widget.dart';
import '../../widgets/preffered_body_skin_type_widget.dart';
import '../../widgets/preffered_education_profession_widget.dart';

class EditPreferrencesPage extends StatefulWidget {
  const EditPreferrencesPage({super.key});

  @override
  State<EditPreferrencesPage> createState() => _EditPreferrencesPageState();
}

class _EditPreferrencesPageState extends State<EditPreferrencesPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<MaritalStatusResponse> futuremaritalStatusList;
  late Future<LocationResponse> futurelocationlist;

  Future<void> showEditConfirmation() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Edit",
                  style: customTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2A3171),
                  ),
                ),
                height(15),
                Text(
                  "Are you sure you want to Edit Preference",
                  style: customTextStyle(
                    fontSize: 16,
                    color: const Color(0xff686D76),
                  ),
                ),
                height(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: customTextStyle(
                          fontSize: 16,
                          color: const Color(0xff686D76),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editPrefferenceController
                            .updatePrefferenceData(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.appMainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        "Edit",
                        style: customTextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    futuremaritalStatusList = dropdownController.fetchMaritalStatus();
    futurelocationlist = dropdownController.fetchLocation();
    editPrefferenceController.loadPreferenceData().then((_) {
      if (mounted) setState(() {});
    });
  }

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
            "Edit Preferrences",
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
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height(20),
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
                                    child: Text('Not available'));
                              }

                              var maritalStatusList =
                                  snapshot.data!.maritalStatusList;

                              bool valueExists = maritalStatusList.any(
                                  (status) =>
                                      status.id ==
                                      editPrefferenceController
                                          .selectedMaritalStatusId);
                              if (!valueExists) {
                                editPrefferenceController
                                    .selectedMaritalStatusId = null;
                              }

                              return DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: valueExists
                                    ? editPrefferenceController
                                        .selectedMaritalStatusId
                                    : null,
                                hint: Text(
                                  'Select',
                                  style: customTextStyle(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    editPrefferenceController
                                        .selectedMaritalStatusId = newValue;
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
                                      horizontal: 10, vertical: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff9C9C9C)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          height(15),
                          const PrefferedAgeHeightWidget(),
                          height(15),
                          const PrefferedBodySkinTypeWidget(),
                          height(15),
                          const PrefferedEducationProfessionWidget(),
                          height(15),
                          Text(
                            "Location",
                            style: customTextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff686D76)),
                          ),
                          height(10),
                          FutureBuilder<LocationResponse>(
                            future: futurelocationlist,
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

                              // Using where().firstOrNull to safely handle the case when no matching location is found
                              LocationModel? selectedLocation;
                              if (editPrefferenceController.selectedLocation !=
                                  null) {
                                selectedLocation = locationList
                                    .where((p) =>
                                        p.id ==
                                        editPrefferenceController
                                            .selectedLocation)
                                    .firstOrNull;
                              }

                              return DropdownSearch<LocationModel>(
                                selectedItem: selectedLocation,
                                items: locationList,
                                itemAsString: (LocationModel? p) =>
                                    p?.name ?? '',
                                onChanged: (LocationModel? newValue) {
                                  setState(() {
                                    editPrefferenceController.selectedLocation =
                                        newValue?.id;
                                  });
                                },
                                dropdownBuilder: (context, selectedItem) {
                                  return Text(
                                    selectedItem?.name ?? 'Select',
                                    style: customTextStyle(
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: "Search...",
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
                                    ),
                                  ),
                                ),
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
                          ),
                          height(40),
                          Material(
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  showEditConfirmation();
                                }
                              },
                              child: Container(
                                width: Get.width,
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
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7.0),
                                  child: Text(
                                    "Update",
                                    style: GoogleFonts.sourceSans3(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
