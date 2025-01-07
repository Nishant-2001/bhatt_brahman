import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/body_type_model.dart';
import '../model/skin_complexion_model.dart';

class EditProfileSkinBodyWidget extends StatefulWidget {
  const EditProfileSkinBodyWidget({super.key});

  @override
  State<EditProfileSkinBodyWidget> createState() =>
      _EditProfileSkinBodyWidgetState();
}

class _EditProfileSkinBodyWidgetState extends State<EditProfileSkinBodyWidget> {
  late Future<BodyTypeResponse> futurebodyTypes;
  late Future<SkinComplexionResponse> futureskinComplexionList;

  @override
  void initState() {
    super.initState();
    futurebodyTypes = dropdownController.fetchBodyType();
    futureskinComplexionList = dropdownController.fetchSkinComplexion();
    editProfileController.loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      // height: Get.height * 0.1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Body Type",
                  style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                ),
                height(8),
                Flexible(
                  child: FutureBuilder<BodyTypeResponse>(
                    future: futurebodyTypes,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error: \${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data?.bodyTypes.isEmpty == true) {
                        return const Center(
                            child: Text('No body types available'));
                      }

                      var bodyTypes = snapshot.data!.bodyTypes;

                      final selectedValue =
                          editProfileController.selectedBodyType;

                      return DropdownButtonFormField<String>(
                        value: selectedValue,
                        hint: Text(
                          'Select',
                          style: customTextStyle(fontSize: 14),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            editProfileController.selectedBodyType = newValue;
                          });
                        },
                        items: bodyTypes.map((bodyType) {
                          return DropdownMenuItem<String>(
                            value: bodyType.id,
                            child: Text(
                              bodyType.name,
                              style: customTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff9C9C9C)),
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
                  "Skin Complextion",
                  style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                ),
                height(8),
                Flexible(
                    child: FutureBuilder<SkinComplexionResponse>(
                  future: futureskinComplexionList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error: \${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.skinComplexionList.isEmpty == true) {
                      return const Center(child: Text('Not available'));
                    }

                    var skinComplexionList = snapshot.data!.skinComplexionList;

                    final selectedValue =
                        editProfileController.selectedSkinComplextion;

                    return DropdownButtonFormField<String>(
                      value: selectedValue,
                      hint: Text(
                        'Select',
                        style: customTextStyle(fontSize: 14),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          editProfileController.selectedSkinComplextion =
                              newValue;
                        });
                      },
                      items: skinComplexionList.map((skinComplexion) {
                        return DropdownMenuItem<String>(
                          value: skinComplexion.id,
                          child: Text(
                            skinComplexion.name,
                            style: customTextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xff9C9C9C)),
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
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
