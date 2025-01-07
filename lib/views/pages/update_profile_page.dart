// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '../../constants/app_constant.dart';
// import '../../constants/dimensions.dart';
// import '../../constants/instance.dart';
// import '../../constants/text_style.dart';
// import '../../model/blood_type_model.dart';
// import '../../model/created_by_model.dart';
// import '../../model/marital_status_model.dart';
// import '../../widgets/edit_profile_about_family_widget.dart';
// import '../../widgets/edit_profile_education_profession_widget.dart';
// import '../../widgets/edit_profile_first_last_name_widget.dart';
// import '../../widgets/edit_profile_religion_widget.dart';
// import '../../widgets/edit_profile_skin_body_widget.dart';
// import '../auth/sign_in_page.dart';

// class UpdateProfilePage extends StatefulWidget {
//   const UpdateProfilePage({super.key});

//   @override
//   State<UpdateProfilePage> createState() => _UpdateProfilePageState();
// }

// class _UpdateProfilePageState extends State<UpdateProfilePage> {
//   late Future<CreatedByResponse> futurecreatedByList;
//   late Future<MaritalStatusResponse> futuremaritalStatusList;
//   late Future<BloodTypeResponse> futurebodyTypeListList;

//   @override
//   void initState() {
//     super.initState();
//     futurecreatedByList = dropdownController.fetchCreatedBy();
//     futuremaritalStatusList = dropdownController.fetchMaritalStatus();
//     futurebodyTypeListList = dropdownController.fetchBloodType();
//   }

//   File? _image;

//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppConstant.appMainColor,
//       appBar: AppBar(
//         backgroundColor: AppConstant.appMainColor,
//         iconTheme: const IconThemeData(color: Color(0xffffffff)),
//         title: Padding(
//           padding: const EdgeInsets.only(top: 7.0),
//           child: Text(
//             "Edit Profile",
//             style: customTextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xffffffff)),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20.0),
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 width: Get.width * 0.9,
//                 height: Get.height * 0.015,
//                 decoration: BoxDecoration(
//                     color: const Color(0xffffffff).withOpacity(.50),
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20))),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 width: Get.width,
//                 decoration: const BoxDecoration(
//                   color: Color(0xffffffff),
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Stack(
//                             children: [
//                               ValueListenableBuilder<File?>(
//                                 valueListenable:
//                                     editProfileController.imageNotifier,
//                                 builder: (context, imageFile, child) {
//                                   return CircleAvatar(
//                                     radius: 60,
//                                     backgroundImage: imageFile != null
//                                         ? FileImage(imageFile)
//                                         : null,
//                                     child: imageFile == null
//                                         ? const Icon(Icons.person, size: 60)
//                                         : null,
//                                   );
//                                 },
//                               ),
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: IconButton(
//                                   icon: const Icon(Icons.photo_camera_outlined),
//                                   onPressed: () {
//                                     showModalBottomSheet(
//                                       context: context,
//                                       builder: (context) {
//                                         return Padding(
//                                           padding: const EdgeInsets.all(16.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () async {
//                                                   await editProfileController
//                                                       .pickImage(
//                                                           ImageSource.camera);
//                                                   if (context.mounted) {
//                                                     Navigator.pop(context);
//                                                   }
//                                                 },
//                                                 child: const Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     Icon(Icons.camera,
//                                                         size: 40),
//                                                     SizedBox(height: 8),
//                                                     Text('Camera'),
//                                                   ],
//                                                 ),
//                                               ),
//                                               width(40),
//                                               GestureDetector(
//                                                 onTap: () async {
//                                                   await editProfileController
//                                                       .pickImage(
//                                                           ImageSource.gallery);
//                                                   if (context.mounted) {
//                                                     Navigator.pop(context);
//                                                   }
//                                                 },
//                                                 child: const Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     Icon(Icons.photo_library,
//                                                         size: 40),
//                                                     SizedBox(height: 8),
//                                                     Text('Gallery'),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         height(30),
//                         Text(
//                           "About :-",
//                           style: customTextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xff2A3171)),
//                         ),
//                         height(10),
//                         Container(
//                           width: Get.width,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(7)),
//                           child: TextFormField(
//                             controller: editProfileController.aboutController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             ),
//                           ),
//                         ),
//                         height(20),
//                         Text(
//                           "Basic Details :-",
//                           style: customTextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xff2A3171)),
//                         ),
//                         height(15),
//                         Text(
//                           "Profile Created By",
//                           style: customTextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xff686D76)),
//                         ),
//                         height(10),
//                         FutureBuilder<CreatedByResponse>(
//                           future: futurecreatedByList,
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                   child: CupertinoActivityIndicator());
//                             } else if (snapshot.hasError) {
//                               return Center(
//                                   child: Text('Error: ${snapshot.error}'));
//                             } else if (!snapshot.hasData ||
//                                 snapshot.data?.createdByList.isEmpty == true) {
//                               return const Center(child: Text('Not available'));
//                             }

//                             var createdByList = snapshot.data!.createdByList;

//                             final selectedValue = createdByList.any(
//                                     (createdBy) =>
//                                         createdBy.name ==
//                                         editProfileController.profileCreatedBY)
//                                 ? createdByList
//                                     .firstWhere((createdBy) =>
//                                         createdBy.name ==
//                                         editProfileController.profileCreatedBY)
//                                     .id
//                                 : null;

//                             return DropdownButtonFormField<String>(
//                               isExpanded: true,
//                               value: selectedValue,
//                               hint: Text(
//                                 'Created By',
//                                 style: customTextStyle(),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   var selectedCreatedBy =
//                                       createdByList.firstWhere(
//                                           (createdBy) =>
//                                               createdBy.id == newValue,
//                                           orElse: () => createdByList.first);
//                                   editProfileController.profileCreatedBY =
//                                       selectedCreatedBy.id;
//                                 });
//                               },
//                               items: createdByList.map((createdBy) {
//                                 return DropdownMenuItem<String>(
//                                   value: createdBy.id,
//                                   child: Text(
//                                     createdBy.name,
//                                     style: customTextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 );
//                               }).toList(),
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 0),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(
//                                       color: Color(0xff9C9C9C)),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         height(15),
//                         Text(
//                           "Marital Status",
//                           style: customTextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xff686D76)),
//                         ),
//                         height(10),
//                         FutureBuilder<MaritalStatusResponse>(
//                           future: futuremaritalStatusList,
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                   child: CupertinoActivityIndicator());
//                             } else if (snapshot.hasError) {
//                               return Center(
//                                   child: Text('Error: ${snapshot.error}'));
//                             } else if (!snapshot.hasData ||
//                                 snapshot.data?.maritalStatusList.isEmpty ==
//                                     true) {
//                               return const Center(child: Text('Not available'));
//                             }

//                             var maritalStatusList =
//                                 snapshot.data!.maritalStatusList;

//                             final selectedValue = maritalStatusList.any(
//                                     (maritalStatus) =>
//                                         maritalStatus.name ==
//                                         editProfileController
//                                             .selectedMaritalStatus)
//                                 ? maritalStatusList
//                                     .firstWhere((maritalStatus) =>
//                                         maritalStatus.name ==
//                                         editProfileController
//                                             .selectedMaritalStatus)
//                                     .id
//                                 : null;

//                             return DropdownButtonFormField<String>(
//                               isExpanded: true,
//                               value: selectedValue,
//                               hint: Text(
//                                 'Select Marital Status',
//                                 style: customTextStyle(),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   var selectedMaritalStatus =
//                                       maritalStatusList.firstWhere(
//                                           (maritalStatus) =>
//                                               maritalStatus.id == newValue,
//                                           orElse: () =>
//                                               maritalStatusList.first);

//                                   editProfileController.selectedMaritalStatus =
//                                       selectedMaritalStatus.id;
//                                 });
//                               },
//                               items: maritalStatusList.map((maritalStatus) {
//                                 return DropdownMenuItem<String>(
//                                   value: maritalStatus.id,
//                                   child: Text(
//                                     maritalStatus.name,
//                                     style: customTextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 );
//                               }).toList(),
//                               decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 0),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(
//                                       color: Color(0xff9C9C9C)),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                         height(20),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "First Name",
//                                     style: customTextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: const Color(0xff686D76)),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                   height(6),
//                                   TextFormField(
//                                     controller: editProfileController
//                                         .firstNameController,
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(7)),
//                                     ),
//                                     keyboardType: TextInputType.name,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Middle Name",
//                                     style: customTextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: const Color(0xff686D76)),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                   height(6),
//                                   TextFormField(
//                                     controller: editProfileController
//                                         .fatherNameController,
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(7)),
//                                     ),
//                                     keyboardType: TextInputType.name,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         height(15),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Last Name",
//                                     style: customTextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: const Color(0xff686D76)),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                   height(6),
//                                   TextFormField(
//                                     controller: editProfileController
//                                         .lastNameController,
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(7)),
//                                     ),
//                                     keyboardType: TextInputType.name,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Mobile Number",
//                                     style: customTextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: const Color(0xff686D76)),
//                                     textAlign: TextAlign.left,
//                                   ),
//                                   height(6),
//                                   TextFormField(
//                                     controller:
//                                         editProfileController.contactController,
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(7)),
//                                     ),
//                                     keyboardType: TextInputType.name,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         height(15),
//                         Text(
//                           "Email Address",
//                           style: customTextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: const Color(0xff686D76)),
//                         ),
//                         height(6),
//                         TextFormField(
//                           controller: editProfileController.emailController,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             suffixIcon: Icon(Icons.email_outlined),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         height(15),
//                         SizedBox(
//                           width: Get.width,
//                           height: Get.height * 0.1,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Date of Birth",
//                                       style: customTextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xff686D76)),
//                                     ),
//                                     height(8),
//                                     Flexible(
//                                         child: TextFormField(
//                                       controller: editProfileController
//                                           .dateOfBirthController,
//                                       decoration: InputDecoration(
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         focusColor: const Color(0xff9C9C9C),
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                               ),
//                               width(7),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Blood Group",
//                                       style: customTextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xff686D76)),
//                                     ),
//                                     height(8),
//                                     Flexible(
//                                       child: FutureBuilder<BloodTypeResponse>(
//                                           future: futurebodyTypeListList,
//                                           builder: (context, snapshot) {
//                                             if (snapshot.connectionState ==
//                                                 ConnectionState.waiting) {
//                                               return const Center(
//                                                   child:
//                                                       CupertinoActivityIndicator());
//                                             } else if (snapshot.hasError) {
//                                               return Center(
//                                                   child: Text(
//                                                       'Error: ${snapshot.error}'));
//                                             } else if (!snapshot.hasData ||
//                                                 snapshot.data?.bloodTypeList
//                                                         .isEmpty ==
//                                                     true) {
//                                               return const Center(
//                                                   child: Text('Not available'));
//                                             }

//                                             var bodyTypeList =
//                                                 snapshot.data!.bloodTypeList;

//                                             final selectedValue = bodyTypeList
//                                                     .any((bodyType) =>
//                                                         bodyType.name ==
//                                                         editProfileController
//                                                             .selectedBloodGroup)
//                                                 ? bodyTypeList
//                                                     .firstWhere((bodyType) =>
//                                                         bodyType.name ==
//                                                         editProfileController
//                                                             .selectedBloodGroup)
//                                                     .id
//                                                 : null;
//                                             return DropdownButtonFormField<
//                                                 String>(
//                                               isExpanded: true,
//                                               value: selectedValue,
//                                               hint: Text(
//                                                 'Select Blood Group',
//                                                 style: customTextStyle(),
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               onChanged: (newValue) {
//                                                 setState(() {
//                                                   var selectedBodyType =
//                                                       bodyTypeList.firstWhere(
//                                                           (bodyType) =>
//                                                               bodyType.id ==
//                                                               newValue,
//                                                           orElse: () =>
//                                                               bodyTypeList
//                                                                   .first);

//                                                   editProfileController
//                                                           .selectedBloodGroup =
//                                                       selectedBodyType.id;
//                                                 });
//                                               },
//                                               items: bodyTypeList
//                                                   .map((maritalStatus) {
//                                                 return DropdownMenuItem<String>(
//                                                   value: maritalStatus.id,
//                                                   child: Text(
//                                                     maritalStatus.name,
//                                                     style: customTextStyle(
//                                                         fontSize: 14,
//                                                         fontWeight:
//                                                             FontWeight.w500),
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                   ),
//                                                 );
//                                               }).toList(),
//                                               decoration: InputDecoration(
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 0),
//                                                 border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   borderSide: const BorderSide(
//                                                       color: Color(0xff9C9C9C)),
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: Get.width,
//                           height: Get.height * 0.1,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Height",
//                                       style: customTextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xff686D76)),
//                                     ),
//                                     height(8),
//                                     Flexible(
//                                         child: TextFormField(
//                                       controller: editProfileController
//                                           .heightController,
//                                       decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10))),
//                                     )),
//                                   ],
//                                 ),
//                               ),
//                               width(7),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Weight",
//                                       style: customTextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xff686D76)),
//                                     ),
//                                     height(8),
//                                     Flexible(
//                                         child: TextFormField(
//                                       controller: editProfileController
//                                           .weightController,
//                                       decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10))),
//                                     )),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         height(15),
//                         const EditProfileSkinBodyWidget(),
//                         height(15),
//                         const EditProfileFirstLastNameWidget(),
//                         height(15),
//                         const EditProfileEducationProfessionWidget(),
//                         height(15),
//                         const EditProfileReligionWidget(),
//                         height(15),
//                         const EditProfileAboutFamilyWidget(),
//                         height(50),
//                         Material(
//                           child: Container(
//                             width: Get.width,
//                             // height: Get.height * 0.05,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xff2A3171),
//                                     Color(0xff4E5CD3)
//                                   ],
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                 ),
//                                 borderRadius: BorderRadius.circular(25)),
//                             child: TextButton(
//                                 onPressed: () {
//                                   updateProfileController
//                                       .updateProfileData(context);

//                                   Get.dialog(AlertDialog(
//                                     title: Image.asset(
//                                       "assets/alert1.png",
//                                       height: 70,
//                                       width: 60,
//                                     ),
//                                     content: Text(
//                                       "Your profile is under verification.\n You will be notified once it's\nverified, and then you can log in.",
//                                       style: customTextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     actions: [
//                                       Center(
//                                           child: Material(
//                                         child: Container(
//                                           width: Get.width,
//                                           height: Get.height * 0.05,
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xff2A3171),
//                                                   Color(0xff4E5CD3)
//                                                 ],
//                                                 begin: Alignment.centerLeft,
//                                                 end: Alignment.centerRight,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(25)),
//                                           child: Text(
//                                             "Continue",
//                                             style: GoogleFonts.sourceSans3(
//                                                 textStyle: const TextStyle(
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 20,
//                                                     color: Color(0xffFFFFFF))),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                       ))
//                                     ],
//                                   ));
//                                 },
//                                 child: Text(
//                                   "Update",
//                                   style: GoogleFonts.sourceSans3(
//                                       textStyle: const TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 20,
//                                           color: Color(0xffFFFFFF))),
//                                   textAlign: TextAlign.center,
//                                 )),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
