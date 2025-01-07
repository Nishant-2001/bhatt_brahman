import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/profession_model.dart';

class EditProfileAboutFamilyWidget extends StatefulWidget {
  const EditProfileAboutFamilyWidget({super.key});

  @override
  State<EditProfileAboutFamilyWidget> createState() =>
      _EditProfileAboutFamilyWidgetState();
}

class _EditProfileAboutFamilyWidgetState
    extends State<EditProfileAboutFamilyWidget> {
  late Future<ProfessionResponse> futureprofessionList;

  @override
  void initState() {
    super.initState();
    futureprofessionList = dropdownController.fetchProfession();
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
              "About Family :-",
              style: customTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff2A3171)),
            ),
            height(15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Father’s Name",
                        style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                        textAlign: TextAlign.left,
                      ),
                      height(6),
                      TextFormField(
                        controller: editProfileController.fatherNameController,
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
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mother’s Name",
                        style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76)),
                        textAlign: TextAlign.left,
                      ),
                      height(6),
                      TextFormField(
                        controller: editProfileController.motherNameController,
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
                            "Father’s Profession",
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
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data?.professionList.isEmpty ==
                                      true) {
                                return const Center(
                                    child: Text('No professions available'));
                              }

                              var professionList =
                                  snapshot.data!.professionList;

                              // Find the currently selected profession model
                              ProfessionModel? selectedProfession =
                                  editProfileController
                                              .selectedFatherProfession !=
                                          null
                                      ? professionList.firstWhere(
                                          (p) =>
                                              p.id ==
                                              editProfileController
                                                  .selectedFatherProfession,
                                        )
                                      : null;

                              return DropdownSearch<ProfessionModel>(
                                selectedItem: selectedProfession,
                                items: professionList,
                                itemAsString: (ProfessionModel? p) =>
                                    p?.name ?? '',
                                onChanged: (ProfessionModel? newValue) {
                                  setState(() {
                                    editProfileController
                                            .selectedFatherProfession =
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
                          ))
                        ],
                      ),
                    ),
                    width(7),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mother’s Profession",
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
                              var selectedValue = editProfileController
                                  .selectedMotherProfession;

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
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                onChanged: (ProfessionModel? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      editProfileController
                                              .selectedMotherProfession =
                                          newValue.id;
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
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height(15),
            Text(
              "Siblings",
              style: customTextStyle(
                  fontWeight: FontWeight.w500, color: const Color(0xff686D76)),
            ),
            height(6),
            TextFormField(
              controller: editProfileController.siblingNumberController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required";
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
