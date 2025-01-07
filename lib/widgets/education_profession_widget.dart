import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/education_model.dart';
import '../model/profession_model.dart';

class EducationProfessionWidget extends StatefulWidget {
  const EducationProfessionWidget({super.key});

  @override
  State<EducationProfessionWidget> createState() =>
      _EducationProfessionWidgetState();
}

class _EducationProfessionWidgetState extends State<EducationProfessionWidget> {
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

                    String? initialSelection = searchController.education;

                    return DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Search education...",
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                        fit: FlexFit.loose,
                        constraints: const BoxConstraints(maxHeight: 350),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff9C9C9C)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                        ),
                      ),
                      selectedItem: initialSelection,
                      asyncItems: (String filter) async {
                        return educationList
                            .where((education) => education.name
                                .toLowerCase()
                                .contains(filter.toLowerCase()))
                            .map((education) => education.name)
                            .toList();
                      },
                      dropdownButtonProps: const DropdownButtonProps(
                        color: Color(0xff9C9C9C),
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            selectedItem ?? 'Select ',
                            style: customTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            searchController.education = newValue;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select education';
                        }
                        return null;
                      },
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

                    String? initialSelection = searchController.profession;

                    return DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Search profession...",
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                        fit: FlexFit.loose,
                        constraints: const BoxConstraints(maxHeight: 350),
                      ),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff9C9C9C)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                        ),
                      ),
                      selectedItem: initialSelection,
                      asyncItems: (String filter) async {
                        return uniqueProfessions
                            .where((profession) => profession.name
                                .toLowerCase()
                                .contains(filter.toLowerCase()))
                            .map((profession) => profession.name)
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
                                fontSize: 14, fontWeight: FontWeight.w400),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            searchController.profession = newValue;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a profession';
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
