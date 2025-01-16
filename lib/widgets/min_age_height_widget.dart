import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/dimensions.dart';
import '../constants/instance.dart';
import '../constants/text_style.dart';

class MinAgeHeightWidget extends StatefulWidget {
  const MinAgeHeightWidget({super.key});

  @override
  State<MinAgeHeightWidget> createState() => _MinAgeHeightWidgetState();
}

class _MinAgeHeightWidgetState extends State<MinAgeHeightWidget> {
  String minAge = "";
  String maxAge = "";
  String minHeight = "";
  String maxHeight = "";

  void _showAgeDialog() {
    _showRangeDialog(
      minController: searchController.minAge,
      maxController: searchController.maxAge,
      onSave: () {
        if (searchController.minAge.text.isNotEmpty &&
            searchController.maxAge.text.isNotEmpty) {
          setState(() {
            minAge = searchController.minAge.text;
            maxAge = searchController.maxAge.text;
          });
          Get.back();
        }
      },
    );
  }

  void _showHeightDialog() {
    _showRangeDialog(
      minController: searchController.minHeight,
      maxController: searchController.maxHeight,
      onSave: () {
        if (searchController.minHeight.text.isNotEmpty &&
            searchController.maxHeight.text.isNotEmpty) {
          setState(() {
            minHeight = searchController.minHeight.text;
            maxHeight = searchController.maxHeight.text;
          });
          Get.back();
        }
      },
    );
  }

  void _showRangeDialog({
    required TextEditingController minController,
    required TextEditingController maxController,
    required VoidCallback onSave,
  }) {
    // Store initial values to restore if validation fails
    final initialMinValue = minController.text;
    final initialMaxValue = maxController.text;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                    top: 16.0,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Minimum",
                          style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: minController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }

                            final number = int.tryParse(value);
                            if (number == null) {
                              return 'Please enter a valid number';
                            }

                            if (minController == searchController.maxAge) {
                              if (number < 18) {
                                return 'Minimum age must be 18+';
                              }
                            }

                            if (minController == searchController.minHeight) {
                              if (number < 100) {
                                return 'Minimum height must be 100cm or more';
                              }
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Maximum",
                          style: customTextStyle(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff686D76),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: maxController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }

                            final number = int.tryParse(value);
                            if (number == null) {
                              return 'Please enter a valid number';
                            }

                            final minValue =
                                int.tryParse(minController.text) ?? 0;
                            if (number <= minValue) {
                              return 'Maximum value must be greater than minimum value';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                onSave();
                              } else {
                                minController.text = initialMinValue;
                                maxController.text = initialMaxValue;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ).then((_) {
      if (formKey.currentState?.validate() ?? false) {
        return;
      }
      minController.text = initialMinValue;
      maxController.text = initialMaxValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 0.082,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Age",
                  style: customTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff686D76),
                  ),
                ),
                height(8),
                Flexible(
                  child: GestureDetector(
                    onTap: _showAgeDialog,
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff9C9C9C)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (minAge.isNotEmpty && maxAge.isNotEmpty)
                                  ? "$minAge - $maxAge"
                                  : "Select",
                              style: customTextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
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
                  "Height (in cm)",
                  style: customTextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff686D76),
                  ),
                ),
                height(8),
                Flexible(
                  child: GestureDetector(
                    onTap: _showHeightDialog,
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff9C9C9C)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (minHeight.isNotEmpty && maxHeight.isNotEmpty)
                                  ? "$minHeight - $maxHeight"
                                  : "Select",
                              style: customTextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
