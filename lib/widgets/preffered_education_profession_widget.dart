import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/education_model.dart';
import '../model/profession_model.dart';

class PrefferedEducationProfessionWidget extends StatefulWidget {
  const PrefferedEducationProfessionWidget({super.key});

  @override
  State<PrefferedEducationProfessionWidget> createState() =>
      _PrefferedEducationProfessionWidgetState();
}

class _PrefferedEducationProfessionWidgetState
    extends State<PrefferedEducationProfessionWidget> {
  late Future<EducationResponse> futureeducationList;
  late Future<ProfessionResponse> futureprofessionList;

  @override
  void initState() {
    super.initState();
    futureeducationList = dropdownController.fetchEducation();
    futureprofessionList = dropdownController.fetchProfession();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.1,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Education",
                  style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                ),
                height(8),
                Flexible(
                    child: FutureBuilder<EducationResponse>(
                  future: futureeducationList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.educationList.isEmpty == true) {
                      return const Center(
                          child: Text('No education available'));
                    }

                    var educationList = snapshot.data!.educationList;

                    // Using where().firstOrNull to safely handle the case when no matching education is found
                    EducationModel? selectedEducation;
                    if (editPrefferenceController.selectedEducation != null) {
                      selectedEducation = educationList
                          .where((p) =>
                              p.id ==
                              editPrefferenceController.selectedEducation)
                          .firstOrNull;
                    }

                    return DropdownSearch<EducationModel>(
                      selectedItem: selectedEducation,
                      items: educationList,
                      itemAsString: (EducationModel? p) => p?.name ?? '',
                      onChanged: (EducationModel? newValue) {
                        setState(() {
                          editPrefferenceController.selectedEducation =
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
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 1),
                          ),
                        ),
                        fit: FlexFit.loose,
                        constraints: BoxConstraints(maxHeight: 350),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Required";
                        }
                        return null;
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
          width(7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profession",
                  style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                ),
                height(8),
                Flexible(
                    child: FutureBuilder<ProfessionResponse>(
                  future: futureprofessionList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.professionList.isEmpty == true) {
                      return const Center(
                          child: Text('No profession available'));
                    }

                    var professionList = snapshot.data!.professionList;
                    var uniqueProfessions = professionList.toSet().toList();
                    var selectedValue =
                        editPrefferenceController.selectedProfession;

                    // Only find currentProfession if selectedValue exists
                    ProfessionModel? currentProfession;
                    if (selectedValue != null) {
                      currentProfession = uniqueProfessions
                          .where((profession) => profession.id == selectedValue)
                          .firstOrNull;
                    }

                    return DropdownSearch<ProfessionModel>(
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Search...",
                          ),
                        ),
                        fit: FlexFit.loose,
                        constraints: BoxConstraints(maxHeight: 350),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      selectedItem: currentProfession,
                      items: uniqueProfessions,
                      itemAsString: (ProfessionModel profession) =>
                          profession.name,
                      dropdownBuilder: (context, selectedItem) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            selectedItem?.name ?? 'Select',
                            style: customTextStyle(
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                      onChanged: (ProfessionModel? newValue) {
                        if (newValue != null) {
                          setState(() {
                            editPrefferenceController.selectedProfession =
                                newValue.id;
                            // print("Selected profession ID: ${newValue.id}");
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select profession';
                        }
                        return null;
                      },
                    );
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
