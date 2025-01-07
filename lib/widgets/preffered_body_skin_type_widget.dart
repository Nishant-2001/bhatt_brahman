import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/body_type_model.dart';
import '../model/skin_complexion_model.dart';

class PrefferedBodySkinTypeWidget extends StatefulWidget {
  const PrefferedBodySkinTypeWidget({super.key});

  @override
  State<PrefferedBodySkinTypeWidget> createState() =>
      _PrefferedBodySkinTypeWidgetState();
}

class _PrefferedBodySkinTypeWidgetState
    extends State<PrefferedBodySkinTypeWidget> {
  late Future<BodyTypeResponse> futurebodyTypes;
  late Future<SkinComplexionResponse> futureskinComplexionList;

  @override
  void initState() {
    super.initState();
    futurebodyTypes = dropdownController.fetchBodyType();
    futureskinComplexionList = dropdownController.fetchSkinComplexion();
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

                      bool valueExists = bodyTypes.any((type) =>
                          type.id ==
                          editPrefferenceController.selectedBodyType);

                      // Reset if value doesn't exist
                      if (!valueExists) {
                        editPrefferenceController.selectedBodyType = null;
                      }

                      return DropdownButtonFormField<String>(
                        value: valueExists
                            ? editPrefferenceController.selectedBodyType
                            : null,
                        hint: Text(
                          'Select',
                          style: customTextStyle(fontSize: 14),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            editPrefferenceController.selectedBodyType =
                                newValue;
                          });
                        },
                        items: bodyTypes.map((bodyType) {
                          return DropdownMenuItem<String>(
                            value: bodyType.id,
                            child: Text(
                              bodyType.name,
                              style: customTextStyle(
                                fontSize: 14,
                              ),
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
                            return 'Required';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Skin Complextion",
                  style: customTextStyle(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

                    bool valueExists = skinComplexionList.any((complexion) =>
                        complexion.id ==
                        editPrefferenceController.selectedSkinComplextion);

                    if (!valueExists) {
                      editPrefferenceController.selectedSkinComplextion = null;
                    }

                    return DropdownButtonFormField<String>(
                      value: valueExists
                          ? editPrefferenceController.selectedSkinComplextion
                          : null,
                      hint: Text(
                        'Select',
                        style: customTextStyle(fontSize: 14),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          editPrefferenceController.selectedSkinComplextion =
                              newValue;
                        });
                      },
                      items: skinComplexionList.map((skinComplexion) {
                        return DropdownMenuItem<String>(
                          value: skinComplexion.id,
                          child: Text(
                            skinComplexion.name,
                            style: customTextStyle(
                              fontSize: 14,
                            ),
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
