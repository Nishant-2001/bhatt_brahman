import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constant.dart';
import '../../constants/dimensions.dart';
import '../../constants/instance.dart';
import '../../constants/text_style.dart';
import '../../model/blood_type_model.dart';
import '../../model/created_by_model.dart';
import '../../model/marital_status_model.dart';
import '../../widgets/edit_profile_about_family_widget.dart';
import '../../widgets/edit_profile_education_profession_widget.dart';
import '../../widgets/edit_profile_first_last_name_widget.dart';
import '../../widgets/edit_profile_religion_widget.dart';
import '../../widgets/edit_profile_skin_body_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? verificationStatus;

  late Future<CreatedByResponse> futurecreatedByList;
  late Future<MaritalStatusResponse> futuremaritalStatusList;
  late Future<BloodTypeResponse> futurebodyTypeListList;

  @override
  void initState() {
    super.initState();
    futurecreatedByList = dropdownController.fetchCreatedBy();
    futuremaritalStatusList = dropdownController.fetchMaritalStatus();
    futurebodyTypeListList = dropdownController.fetchBloodType();
    fetchVerificationStatus();
    editProfileController.loadProfileData();
    const EditProfileSkinBodyWidget();
    const EditProfileFirstLastNameWidget();
    const EditProfileEducationProfessionWidget();
    const EditProfileReligionWidget();
    const EditProfileAboutFamilyWidget();
  }

  Future<void> fetchVerificationStatus() async {
    try {
      final status = await verificationController.fetchVerificationStatus();
      if (mounted) {
        setState(() {
          verificationStatus = status;
        });
      }
    } catch (e) {
      log("Error fetching verification status: $e");
      Get.snackbar("Error", "Unable to fetch verification status.");
    }
  }

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> showLEditConfirmation() async {
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
                  verificationStatus == 'Incomplete' ? "Create" : "Edit",
                  style: customTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2A3171),
                  ),
                ),
                height(15),
                Text(
                  verificationStatus == 'Incomplete'
                      ? "Are you sure want to Create Profile?"
                      : "Are you sure want to Edit Profile?",
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
                        "No",
                        style: customTextStyle(
                          fontSize: 16,
                          color: const Color(0xff686D76),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editProfileController.updateProfileData();
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
                        verificationStatus == 'Incomplete' ? "Yes" : "Yes",
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Padding(
          padding: const EdgeInsets.only(top: 7.0),
          child: Text(
            verificationStatus == 'Incomplete'
                ? "Create Profile"
                : "Edit Profile",
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
                          Center(
                            child: Stack(
                              children: [
                                ValueListenableBuilder<File?>(
                                  valueListenable:
                                      editProfileController.imageNotifier,
                                  builder: (context, file, child) {
                                    if (file != null) {
                                      return CircleAvatar(
                                        radius: 60,
                                        backgroundImage: FileImage(file),
                                      );
                                    } else if (editProfileController
                                            .networkImageUrl !=
                                        null) {
                                      return CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                            editProfileController
                                                .networkImageUrl!),
                                      );
                                    } else {
                                      return const CircleAvatar(
                                        radius: 60,
                                        child: Icon(Icons.person, size: 60),
                                      );
                                    }
                                  },
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon:
                                        const Icon(Icons.photo_camera_outlined),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    await editProfileController
                                                        .pickImage(
                                                            ImageSource.camera);
                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.camera,
                                                          size: 40),
                                                      SizedBox(height: 8),
                                                      Text('Camera'),
                                                    ],
                                                  ),
                                                ),
                                                width(40),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await editProfileController
                                                        .pickImage(ImageSource
                                                            .gallery);
                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(Icons.photo_library,
                                                          size: 40),
                                                      SizedBox(height: 8),
                                                      Text('Gallery'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          height(30),
                          Text(
                            "Select :-",
                            style: customTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171)),
                          ),
                          height(10),
                          FormField<String>(
                            validator: (value) {
                              if (editProfileController
                                      .selectedUserType?.isEmpty ??
                                  true) {
                                return 'Please select Bride or Groom';
                              }
                              return null;
                            },
                            builder: (FormFieldState<String> state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: state.hasError
                                                    ? Colors.red
                                                    : const Color(0xff9C9C9C),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: RadioListTile<String>(
                                              value: "Bride",
                                              groupValue: editProfileController
                                                  .selectedUserType,
                                              onChanged: verificationStatus ==
                                                      'Incomplete'
                                                  ? (value) {
                                                      setState(() {
                                                        editProfileController
                                                                .selectedUserType =
                                                            value!;
                                                      });
                                                      state.didChange(value);
                                                    }
                                                  : null,
                                              title: Text(
                                                "Bride",
                                                style: customTextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff373A40),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        width(10),
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: state.hasError
                                                    ? Colors.red
                                                    : const Color(0xff9C9C9C),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: RadioListTile<String>(
                                              value: "Groom",
                                              groupValue: editProfileController
                                                  .selectedUserType,
                                              onChanged: verificationStatus ==
                                                      'Incomplete'
                                                  ? (value) {
                                                      setState(() {
                                                        editProfileController
                                                                .selectedUserType =
                                                            value!;
                                                      });
                                                      state.didChange(value);
                                                    }
                                                  : null,
                                              title: Text(
                                                "Groom",
                                                style: customTextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff373A40),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (state.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 8),
                                      child: Text(
                                        state.errorText!,
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          height(15),
                          Text(
                            "About :-",
                            style: customTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171)),
                          ),
                          height(10),
                          Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7)),
                            child: TextFormField(
                              style: customTextStyle(fontSize: 14),
                              controller: editProfileController.aboutController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter about information';
                                }
                                return null;
                              },
                            ),
                          ),
                          height(15),
                          Text(
                            "Basic Details :-",
                            style: customTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff2A3171)),
                          ),
                          height(15),
                          Text(
                            "Profile Created By",
                            style: customTextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff686D76)),
                          ),
                          height(10),
                          FutureBuilder<CreatedByResponse>(
                            future: futurecreatedByList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CupertinoActivityIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.createdByList.isEmpty) {
                                return const Center(
                                    child: Text('Not available'));
                              }

                              var createdByList = snapshot.data!.createdByList;

                              final selectedValue =
                                  editProfileController.profileCreatedBY;

                              return DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: selectedValue,
                                hint: Text(
                                  'Select',
                                  style: customTextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    editProfileController.profileCreatedBY =
                                        newValue;
                                  });
                                },
                                items: createdByList.map((createdBy) {
                                  return DropdownMenuItem<String>(
                                    value: createdBy.id,
                                    child: Text(
                                      createdBy.name,
                                      style: customTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff9C9C9C)),
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
                          height(15),
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

                              // Filter out 'Any' and 'Other'
                              var maritalStatusList = snapshot
                                  .data!.maritalStatusList
                                  .where((status) =>
                                      status.name != 'Any' &&
                                      status.name != 'Other')
                                  .toList();

                              final selectedValue =
                                  editProfileController.selectedMaritalStatus;

                              return DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: selectedValue,
                                hint: Text(
                                  'Select',
                                  style: customTextStyle(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    editProfileController
                                        .selectedMaritalStatus = newValue;
                                  });
                                },
                                items: maritalStatusList.map((maritalStatus) {
                                  return DropdownMenuItem<String>(
                                    value: maritalStatus.id,
                                    child: Text(
                                      maritalStatus.name,
                                      style: customTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff9C9C9C)),
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
                          height(15),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "First Name",
                                      style: customTextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff686D76)),
                                      textAlign: TextAlign.left,
                                    ),
                                    height(6),
                                    TextFormField(
                                      controller: editProfileController
                                          .firstNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Middle Name",
                                      style: customTextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff686D76)),
                                      textAlign: TextAlign.left,
                                    ),
                                    height(6),
                                    TextFormField(
                                      controller: editProfileController
                                          .fatherNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
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
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Last Name",
                                      style: customTextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff686D76)),
                                      textAlign: TextAlign.left,
                                    ),
                                    height(6),
                                    TextFormField(
                                      controller: editProfileController
                                          .lastNameController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required';
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Mobile Number",
                                      style: customTextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff686D76)),
                                      textAlign: TextAlign.left,
                                    ),
                                    height(6),
                                    TextFormField(
                                      controller: editProfileController
                                          .contactController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      keyboardType: TextInputType.name,
                                      onChanged: (value) {
                                        if (value.length > 10) {
                                          editProfileController
                                              .contactController
                                              .text = value.substring(0, 10);
                                          editProfileController
                                                  .contactController.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                                offset: editProfileController
                                                    .contactController
                                                    .text
                                                    .length),
                                          );
                                        }
                                      },
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
                            "Email Address",
                            style: customTextStyle(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff686D76)),
                          ),
                          height(6),
                          TextFormField(
                            controller: editProfileController.emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              suffixIcon: const Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date of Birth",
                                        style: customTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff686D76),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      GestureDetector(
                                        onTap: () async {
                                          DateTime initialDate = DateTime.now();
                                          if (editProfileController
                                              .dateOfBirthController
                                              .text
                                              .isNotEmpty) {
                                            try {
                                              final parts =
                                                  editProfileController
                                                      .dateOfBirthController
                                                      .text
                                                      .split('-');
                                              if (parts.length == 3) {
                                                initialDate = DateTime(
                                                  int.parse(parts[0]),
                                                  int.parse(parts[1]),
                                                  int.parse(parts[2]),
                                                );
                                              }
                                            } catch (e) {
                                              // print(
                                              //     'Error parsing existing date: $e');
                                            }
                                          }

                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: initialDate,
                                            firstDate: DateTime(1985),
                                            lastDate: DateTime.now(),
                                          );

                                          if (pickedDate != null) {
                                            String formattedDate =
                                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                            editProfileController
                                                .dateOfBirthController
                                                .text = formattedDate;

                                            int age = DateTime.now().year -
                                                pickedDate.year;
                                            if (DateTime.now().month <
                                                    pickedDate.month ||
                                                (DateTime.now().month ==
                                                        pickedDate.month &&
                                                    DateTime.now().day <
                                                        pickedDate.day)) {
                                              age--;
                                            }
                                            editProfileController.ageController
                                                .text = age.toString();
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextFormField(
                                            controller: editProfileController
                                                .dateOfBirthController,
                                            readOnly: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Required';
                                              }

                                              try {
                                                final parts = value.split('-');
                                                if (parts.length == 3) {
                                                  final date = DateTime(
                                                    int.parse(parts[0]),
                                                    int.parse(parts[1]),
                                                    int.parse(parts[2]),
                                                  );

                                                  final age =
                                                      DateTime.now().year -
                                                          date.year;
                                                  if (DateTime.now().month <
                                                          date.month ||
                                                      (DateTime.now().month ==
                                                              date.month &&
                                                          DateTime.now().day <
                                                              date.day)) {
                                                    if (age - 1 < 18) {
                                                      return 'Must be 18+';
                                                    }
                                                  } else {
                                                    if (age < 18) {
                                                      return 'Must be 18+';
                                                    }
                                                  }
                                                }
                                              } catch (e) {
                                                return 'Invalid date format';
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'YYYY-MM-DD',
                                              hintStyle: customTextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 12.0,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusColor:
                                                  const Color(0xff9C9C9C),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
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
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Blood Group",
                                        style: customTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff686D76)),
                                      ),
                                      height(6),
                                      Flexible(
                                        child: FutureBuilder<BloodTypeResponse>(
                                          future: futurebodyTypeListList,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CupertinoActivityIndicator());
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${snapshot.error}'));
                                            } else if (!snapshot.hasData ||
                                                snapshot.data?.bloodTypeList
                                                        .isEmpty ==
                                                    true) {
                                              return const Center(
                                                  child: Text('Not available'));
                                            }

                                            // Filter out 'Any' and 'Other'
                                            var bloodTypeList = snapshot
                                                .data!.bloodTypeList
                                                .where((bloodType) =>
                                                    bloodType.name != 'Any' &&
                                                    bloodType.name != 'Other')
                                                .toList();

                                            String? selectedValue;
                                            if (editProfileController
                                                    .selectedBloodGroup !=
                                                null) {
                                              var matchById = bloodTypeList.any(
                                                  (item) =>
                                                      item.id ==
                                                      editProfileController
                                                          .selectedBloodGroup);
                                              if (matchById) {
                                                selectedValue =
                                                    editProfileController
                                                        .selectedBloodGroup;
                                              } else {
                                                var matchByName =
                                                    bloodTypeList.firstWhere(
                                                  (item) =>
                                                      item.name ==
                                                      editProfileController
                                                          .selectedBloodGroup,
                                                  orElse: () =>
                                                      bloodTypeList[0],
                                                );
                                                selectedValue = matchByName.id;

                                                editProfileController
                                                        .selectedBloodGroup =
                                                    selectedValue;
                                              }
                                            }

                                            return DropdownButtonFormField<
                                                String>(
                                              isExpanded: true,
                                              value: selectedValue,
                                              hint: Text(
                                                'Select',
                                                style: customTextStyle(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  editProfileController
                                                          .selectedBloodGroup =
                                                      newValue;
                                                });
                                              },
                                              items: bloodTypeList
                                                  .map((bloodType) {
                                                return DropdownMenuItem<String>(
                                                  value: bloodType.id,
                                                  child: Text(
                                                    bloodType.name,
                                                    style: customTextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Color(0xff9C9C9C)),
                                                ),
                                              ),
                                              menuMaxHeight: 200,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Required";
                                                }
                                                return null;
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Birth Time",
                                        style: customTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff686D76),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      GestureDetector(
                                        onTap: () async {
                                          TimeOfDay initialTime =
                                              TimeOfDay.now();

                                          if (editProfileController
                                              .birthTimeController
                                              .text
                                              .isNotEmpty) {
                                            try {
                                              final timeParts =
                                                  editProfileController
                                                      .birthTimeController.text
                                                      .split(':');
                                              if (timeParts.length == 2) {
                                                initialTime = TimeOfDay(
                                                  hour: int.parse(timeParts[0]),
                                                  minute:
                                                      int.parse(timeParts[1]),
                                                );
                                              }
                                            } catch (e) {
                                              // Handle parsing error
                                            }
                                          }

                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: initialTime,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            false),
                                                child: child!,
                                              );
                                            },
                                          );

                                          if (pickedTime != null) {
                                            String formattedTime =
                                                "${pickedTime.hourOfPeriod.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')} ${pickedTime.period == DayPeriod.am ? 'AM' : 'PM'}";
                                            editProfileController
                                                .birthTimeController
                                                .text = formattedTime;
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: SizedBox(
                                            height:
                                                50, // Set fixed height for consistency
                                            child: TextFormField(
                                              controller: editProfileController
                                                  .birthTimeController,
                                              readOnly: true,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Required';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'HH:MM AM/PM',
                                                hintStyle: customTextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 12.0,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                focusColor:
                                                    const Color(0xff9C9C9C),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.red),
                                                ),
                                                errorStyle: const TextStyle(
                                                  height: 0,
                                                  fontSize: 0,
                                                ),
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
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Birth Place",
                                        style: customTextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff686D76),
                                        ),
                                      ),
                                      height(6),
                                      SizedBox(
                                        height: Get.height * 0.054,
                                        child: TextFormField(
                                          controller: editProfileController
                                              .birthPlaceController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 12.0,
                                            ),
                                            errorStyle: const TextStyle(
                                              height:
                                                  0, 
                                              fontSize: 0,
                                            ),
                                          ),
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Required";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          height(10),
                          SizedBox(
                            width: Get.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Height (in cm)",
                                        style: customTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff686D76)),
                                      ),
                                      height(8),
                                      Flexible(
                                          child: TextFormField(
                                        controller: editProfileController
                                            .heightController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                      )),
                                    ],
                                  ),
                                ),
                                width(7),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Weight (in Kg)",
                                        style: customTextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff686D76)),
                                      ),
                                      height(8),
                                      Flexible(
                                          child: TextFormField(
                                        controller: editProfileController
                                            .weightController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                      )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          height(12),
                          const EditProfileSkinBodyWidget(),
                          height(12),
                          const EditProfileFirstLastNameWidget(),
                          const EditProfileEducationProfessionWidget(),
                          height(15),
                          const EditProfileReligionWidget(),
                          height(15),
                          const EditProfileAboutFamilyWidget(),
                          height(50),
                          Material(
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  showLEditConfirmation();
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
                                    verificationStatus == 'Incomplete'
                                        ? "Create"
                                        : "Update",
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
                          ),
                          height(20)
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
