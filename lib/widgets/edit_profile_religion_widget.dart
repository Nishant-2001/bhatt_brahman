import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/gotra_model.dart';
import '../model/raashi_model.dart';

class EditProfileReligionWidget extends StatefulWidget {
  const EditProfileReligionWidget({super.key});

  @override
  State<EditProfileReligionWidget> createState() =>
      _EditProfileReligionWidgetState();
}

class _EditProfileReligionWidgetState extends State<EditProfileReligionWidget> {
  late Future<GotraResponse> futureGotras;
  late Future<RaashiResponse> futureRaashis;

  @override
  void initState() {
    super.initState();
    futureGotras = dropdownController.fetchGotras();
    futureRaashis = dropdownController.fetchRaashis();
    editProfileController.loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Religion Status :-",
          style: customTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xff2A3171)),
        ),
        height(15),
        SizedBox(
          width: Get.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gotra",
                      style: customTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff686D76)),
                    ),
                    height(8),
                    Flexible(
                      child: FutureBuilder<GotraResponse>(
                        future: futureGotras,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data?.gotras.isEmpty == true) {
                            return const Center(
                                child: Text('No gotras available'));
                          }

                          var gotras = snapshot.data!.gotras;

                          final selectedValue =
                              editProfileController.selectedGotra;

                          return DropdownButtonFormField<String>(
                            value: selectedValue,
                            hint: Text(
                              'Select',
                              style: customTextStyle(fontSize: 14),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                editProfileController.selectedGotra = newValue;
                              });
                            },
                            items: gotras.map((gotra) {
                              return DropdownMenuItem<String>(
                                value: gotra.id,
                                child: Text(
                                  gotra.gotraName,
                                  style: customTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff9C9C9C))),
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
                    ),
                  ],
                ),
              ),
              width(7),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manglik",
                      style: customTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff686D76)),
                    ),
                    height(8),
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        value: editProfileController.selectedManglik,
                        hint: Text(
                          "Select",
                          style: customTextStyle(fontSize: 14),
                        ),
                        items: [
                          DropdownMenuItem(
                            value: "Yes",
                            child: Text(
                              "Yes",
                              style: customTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff373A40)),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "No",
                            child: Text(
                              "No",
                              style: customTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff373A40)),
                            ),
                          ),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            editProfileController.selectedManglik = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xff9C9C9C))),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        height(15),
        Text(
          "Star/Rassi",
          style: customTextStyle(
              fontWeight: FontWeight.w500, color: const Color(0xff686D76)),
        ),
        height(10),
        FutureBuilder<RaashiResponse>(
          future: futureRaashis,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data?.raashis.isEmpty == true) {
              return const Center(child: Text('No Raashis available'));
            }

            var raashis = snapshot.data!.raashis;

            final selectedValue = editProfileController.selectedRaasi;

            return DropdownButtonFormField<String>(
              value: selectedValue,
              hint: Text(
                'Select',
                style: customTextStyle(fontSize: 14),
              ),
              onChanged: (newValue) {
                setState(() {
                  editProfileController.selectedRaasi = newValue;
                });
              },
              items: raashis.map((raashi) {
                return DropdownMenuItem<String>(
                  value: raashi.id,
                  child: Text(
                    raashi.raashiName,
                    style: customTextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xff9C9C9C))),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Required";
                }
                return null;
              },
            );
          },
        )
      ],
    );
  }
}
