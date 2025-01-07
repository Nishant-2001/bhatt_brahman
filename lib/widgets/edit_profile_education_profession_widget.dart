import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/education_model.dart';
import '../model/location_model.dart';
import '../model/profession_model.dart';

class EditProfileEducationProfessionWidget extends StatefulWidget {
  const EditProfileEducationProfessionWidget({super.key});

  @override
  State<EditProfileEducationProfessionWidget> createState() =>
      _EditProfileEducationProfessionWidgetState();
}

class _EditProfileEducationProfessionWidgetState
    extends State<EditProfileEducationProfessionWidget> {
  late Future<EducationResponse> futureeducationList;
  late Future<ProfessionResponse> futureprofessionList;
  late Future<LocationResponse> futurelocationlist;

  @override
  void initState() {
    super.initState();
    futureeducationList = dropdownController.fetchEducation();
    futureprofessionList = dropdownController.fetchProfession();
    futurelocationlist = dropdownController.fetchLocation();
    editProfileController.loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Education & Professional Details :-",
              style: customTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff2A3171)),
            ),
            height(15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: constraints.maxWidth,
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
                          Expanded(
                              child: FutureBuilder<EducationResponse>(
                            future: futureeducationList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CupertinoActivityIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data?.educationList.isEmpty ==
                                      true) {
                                return const Center(
                                    child: Text('No education available'));
                              }

                              var educationList = snapshot.data!.educationList;

                              EducationModel? selectedEducation =
                                  editProfileController.selectedEducation !=
                                          null
                                      ? educationList.firstWhere((p) =>
                                          p.id ==
                                          editProfileController
                                              .selectedEducation)
                                      : null;

                              return DropdownSearch<EducationModel>(
                                selectedItem: selectedEducation,
                                items: educationList,
                                itemAsString: (EducationModel? p) =>
                                    p?.name ?? '',
                                onChanged: (EducationModel? newValue) {
                                  setState(() {
                                    editProfileController.selectedEducation =
                                        newValue?.id;
                                  });
                                },
                                dropdownBuilder: (context, selectedItem) {
                                  return Text(
                                    selectedItem?.name ?? 'Select',
                                    style: customTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
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
                                  constraints:
                                      const BoxConstraints(maxHeight: 350),
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
                          Expanded(
                            child: FutureBuilder<ProfessionResponse>(
                              future: futureprofessionList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CupertinoActivityIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data?.professionList.isEmpty ==
                                        true) {
                                  return const Center(
                                      child: Text('No profession available'));
                                }

                                var professionList =
                                    snapshot.data!.professionList;
                                var uniqueProfessions =
                                    professionList.toSet().toList();
                                var selectedValue =
                                    editProfileController.selectedProfession;

                                ProfessionModel? currentProfession =
                                    selectedValue != null
                                        ? uniqueProfessions.firstWhere(
                                            (profession) =>
                                                profession.id == selectedValue,
                                          )
                                        : null;

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
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                                  selectedItem: currentProfession,
                                  items: uniqueProfessions,
                                  itemAsString: (ProfessionModel profession) =>
                                      profession.name,
                                  dropdownBuilder: (context, selectedItem) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        selectedItem?.name ?? 'Select',
                                        style: customTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  },
                                  onChanged: (ProfessionModel? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        editProfileController
                                            .selectedProfession = newValue.id;
                                        // print(
                                        //     "Selected profession ID: ${newValue.id}");
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
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            height(10),
            Text(
              "Designation",
              style: customTextStyle(
                  fontWeight: FontWeight.w500, color: const Color(0xff686D76)),
              textAlign: TextAlign.left,
            ),
            height(6),
            TextFormField(
              controller: editProfileController.designationController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required";
                }
                return null;
              },
            ),
            height(10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Income (LPA)",
                        style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                        textAlign: TextAlign.left,
                      ),
                      height(6),
                      TextFormField(
                        controller: editProfileController.incomeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Requried";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                width(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Working At",
                        style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                        textAlign: TextAlign.left,
                      ),
                      height(6),
                      TextFormField(
                        controller: editProfileController.workingAtController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7)),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height(15),
            Text(
              "Work Location",
              style: customTextStyle(
                  fontWeight: FontWeight.w500, color: const Color(0xff686D76)),
            ),
            height(6),
            FutureBuilder<LocationResponse>(
              future: futurelocationlist,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData ||
                    snapshot.data?.locationList.isEmpty == true) {
                  return const Center(child: Text('No education available'));
                }

                var locationList = snapshot.data!.locationList;
                // var selectedValue = editProfileController.selectedLocation;

                LocationModel? selectedLocation =
                    editProfileController.selectedLocation != null
                        ? locationList.firstWhere((p) =>
                            p.id == editProfileController.selectedLocation)
                        : null;

                return DropdownSearch<LocationModel>(
                  selectedItem: selectedLocation,
                  items: locationList,
                  itemAsString: (LocationModel? p) => p?.name ?? '',
                  onChanged: (LocationModel? newValue) {
                    setState(() {
                      editProfileController.selectedLocation = newValue?.id;
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
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Search...",
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
            )
          ],
        );
      },
    );
  }
}
