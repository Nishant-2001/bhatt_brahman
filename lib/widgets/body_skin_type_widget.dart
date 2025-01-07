import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';
import '../model/body_type_model.dart';
import '../model/skin_complexion_model.dart';

class BodySkinTypeWidget extends StatefulWidget {
  const BodySkinTypeWidget({super.key});

  @override
  State<BodySkinTypeWidget> createState() => _BodySkinTypeWidgetState();
}

class _BodySkinTypeWidgetState extends State<BodySkinTypeWidget> {
  late Future<BodyTypeResponse> futurebodyTypes;
  late Future<SkinComplexionResponse> futureSkinComplexionList;

  @override
  void initState() {
    super.initState();
    futurebodyTypes = dropdownController.fetchBodyType();
    futureSkinComplexionList = dropdownController.fetchSkinComplexion();
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

                      final selectedValue = bodyTypes.any((bodyType) =>
                              bodyType.name == searchController.bodyType)
                          ? bodyTypes
                              .firstWhere((bodyType) =>
                                  bodyType.name == searchController.bodyType)
                              .id
                          : null;

                      return DropdownButtonFormField<String>(
                        value: selectedValue,
                        hint: Text(
                          'Select',
                          style: customTextStyle(fontSize: 14),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            var selectedBodyTypes = bodyTypes
                                .firstWhere(
                                    (bodyType) => bodyType.id == newValue,
                                    orElse: () => bodyTypes.first)
                                .name;
                            searchController.bodyType = selectedBodyTypes;
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
                  "Skin Complexion",
                  style: customTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff686D76)),
                ),
                height(8),
                Flexible(
                    child: FutureBuilder<SkinComplexionResponse>(
                  future: futureSkinComplexionList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error: {snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.skinComplexionList.isEmpty == true) {
                      return const Center(
                          child: Text('No body types available'));
                    }

                    var skinComplexionList = snapshot.data!.skinComplexionList;

                    final selectedValue = skinComplexionList.any(
                            (skinComplexion) =>
                                skinComplexion.name ==
                                searchController.skinComplexion)
                        ? skinComplexionList
                            .firstWhere((kinComplexion) =>
                                kinComplexion.name ==
                                searchController.skinComplexion)
                            .id
                        : null;

                    return DropdownButtonFormField<String>(
                      value: selectedValue,
                      hint: Text(
                        'Select',
                        style: customTextStyle(fontSize: 14),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          var selectedSkinComplexion = skinComplexionList
                              .firstWhere(
                                  (skinComplexion) =>
                                      skinComplexion.id == newValue,
                                  orElse: () => skinComplexionList.first)
                              .name;
                          searchController.skinComplexion =
                              selectedSkinComplexion;
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
