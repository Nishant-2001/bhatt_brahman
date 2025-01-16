import 'package:get/get.dart';

import '../controller/accept_request_controller.dart';
import '../controller/block_profile_controller.dart';
import '../controller/cancel_request_controller.dart';
import '../controller/change_password_controller.dart';
import '../controller/dropdown_controller.dart';
import '../controller/edit_prefference_controller.dart';
import '../controller/edit_profile_controller.dart';
import '../controller/find_controller.dart';
import '../controller/forgot_new_password_controller.dart';
import '../controller/forgot_password_controller.dart';
import '../controller/interested_person_controller.dart';
import '../controller/not_interested_person_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/otp_verification_controller.dart';
import '../controller/prefferences_controller.dart';
import '../controller/recommended_controller.dart';
import '../controller/report_controller.dart';
import '../controller/search_controller.dart';
import '../controller/shortlist_controller.dart';
import '../controller/sign_in_controller.dart';
import '../controller/sign_up_controller.dart';
import '../controller/update_profile_controller.dart';
import '../controller/user_profile_controller.dart';
import '../controller/verification_controller.dart';
import '../controller/view_profile_controller.dart';

final SignInController signInController = Get.put(SignInController());

final ForgotPasswordController forgotPasswordController =
    Get.put(ForgotPasswordController());

final ChangePasswordController changePasswordController =
    Get.put(ChangePasswordController());

final SignUpController signUpController = Get.put(SignUpController());
final ProfileController profileController = Get.put(ProfileController());

final DropdownController dropdownController = Get.put(DropdownController());
final EditProfileController editProfileController =
    Get.put(EditProfileController());

final SearchController searchController = Get.put(SearchController());

final ForgotNewPasswordController forgotNewPasswordController =
    Get.put(ForgotNewPasswordController());

final OtpVerificationController otpVerificationController =
    Get.put(OtpVerificationController());

final EditPrefferenceController editPrefferenceController =
    Get.put(EditPrefferenceController());
final UpdateProfileController updateProfileController =
    Get.put(UpdateProfileController());

final InterestedPersonController interestedPersonController =
    Get.put(InterestedPersonController());

final NotInterestedPersonController notInterestedPersonController =
    Get.put(NotInterestedPersonController());

final AcceptRequestController acceptRequestController =
    Get.put(AcceptRequestController());

final CancelRequestController cancelRequestController =
    Get.put(CancelRequestController());

final FindController findController = Get.put(FindController());

final VerificationController verificationController =
    Get.put(VerificationController());

final PrefferencesController prefferencesController =
    Get.put(PrefferencesController());

final RecommendedController recommendedController =
    Get.put(RecommendedController());

final ViewProfileController viewProfileController =
    Get.put(ViewProfileController());

final ShortlistController shortlistController = Get.put(ShortlistController());

final BlockProfileController blockProfileController =
    Get.put(BlockProfileController());

final ReportController reportController = Get.put(ReportController());

final NotificationController notificationController =
    Get.put(NotificationController());
