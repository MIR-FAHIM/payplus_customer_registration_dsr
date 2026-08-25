import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latest_payplus_agent/app/models/app_setting_controller_model.dart';
import 'package:latest_payplus_agent/app/modules/Auth/login/controllers/login_controller.dart';
import 'package:latest_payplus_agent/app/modules/home/controllers/home_controller.dart';
import 'package:latest_payplus_agent/app/modules/splashscreen/controllers/splashscreen_controller.dart';
import 'package:latest_payplus_agent/app/repositories/buysell_repository.dart';
//import 'package:ml_kit_ocr/ml_kit_ocr.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:latest_payplus_agent/app/models/address/get_area_model.dart';
import 'package:latest_payplus_agent/app/models/address/get_city_model.dart';
import 'package:latest_payplus_agent/app/models/address/get_zone_model.dart';
import 'package:latest_payplus_agent/app/models/businessTypeModel.dart';
import 'package:latest_payplus_agent/app/models/district_model.dart';
import 'package:latest_payplus_agent/app/models/icon_model.dart';
import 'package:latest_payplus_agent/app/models/nid_data_model.dart';
import 'package:latest_payplus_agent/app/models/service_fee_model.dart';
import 'package:latest_payplus_agent/app/models/thana_model.dart';
import 'package:latest_payplus_agent/app/models/union_model.dart';
import 'package:latest_payplus_agent/app/models/user_model.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/nid_number_input_widget.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/nid_verification_widget.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/tradeL_verification_widget.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/trade_select.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/user_detail_address_widget.dart';
import 'package:latest_payplus_agent/app/modules/Auth/signup/widgets/user_details_widget.dart';

import 'package:latest_payplus_agent/app/repositories/account_setting_repository.dart';
import 'package:latest_payplus_agent/app/repositories/auth_repositories.dart';
import 'package:latest_payplus_agent/app/repositories/business_type_repositoy.dart';
import 'package:latest_payplus_agent/app/repositories/division_districts_repositoy.dart';
import 'package:latest_payplus_agent/app/routes/app_pages.dart';
import 'package:latest_payplus_agent/app/services/location_service.dart';
import 'package:latest_payplus_agent/common/data.dart';
import 'package:latest_payplus_agent/common/ui.dart';

import '../../../../services/auth_service.dart';
import '../widgets/password_widget.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  final checkTerm = false.obs;
  final count = 0.obs;
  final skipTrade = true.obs;
  final hidePassword = true.obs;
  final updatePassLoading = false.obs;
  final hideConfirmPassword = true.obs;
  final errorMessagePinSet = ''.obs;
  final userData = UserModel().obs;
  final signupCompleted = true.obs;
  final nidNo = "".obs;
  final errorText = "".obs;
  final confirmPass = "".obs;
  final appSettingList = <AppSettingControllerModel>[].obs;
  final nidData = NIDDataModel().obs;
  var remarkType = ''.obs;
  final businessTypes = <BusinessTypeModel>[].obs;

  final districtsTypes = <DistrictModel>[].obs;
  final cityList = <CitDatum>[].obs;
  final zoneList = <ZoneDatum>[].obs;
  final areaList = <AreaDatum>[].obs;

  final serviceCharge = <ServiceFeeModel>[].obs;
  final isClearImage = true.obs;
  final thanas = <ThanaModel>[].obs;

  final unions = <UnionModel>[].obs;
  final nidDuplicate = false.obs;
  final postalCode = ''.obs;

  var service_fee_type = ''.obs;
  final userImage = ''.obs;
  final openingHour = '09'.obs;
  final openingMin = '01'.obs;

  final closingHour = '09'.obs;
  final closingMin = '01'.obs;

  final openingAMPM = 'AM'.obs;
  final closingAMPM = 'PM'.obs;

  late GlobalKey<FormState> registerFormKey;

  late GlobalKey<FormState> userinfo;
  late GlobalKey<FormState> usernid;

  late TextEditingController textEditingController;
  final personalPhone = TextEditingController().obs;
  final email = TextEditingController().obs;
  final outletName = TextEditingController().obs;
  final customerName = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final passController = TextEditingController().obs;
  final dateInput = TextEditingController();
  final conPassController = TextEditingController().obs;

  final simOperator = ''.obs;
  final selectedCityId = ''.obs;
  final selectedAreaId = ''.obs;
  final selectedZoneId = ''.obs;
  final porichoyNameBn = ''.obs;
  final porichoyNameEn = ''.obs;
  final porichoyFather = ''.obs;
  final porichoyMother = ''.obs;
  final porichoygender = ''.obs;

  var imageList = [].obs;

  RxBool userReviewed = true.obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // var locationPermission = ''.obs;
  final faceMatched = false.obs;
  final faceLoad = false.obs;
  var lat = ''.obs;
  var lang = ''.obs;
  var addresses = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;
  final dateInputController = TextEditingController().obs;
  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  final currentIndex = 0.obs;

  // int ocrCamera = FlutterMobileVision.CAMERA_BACK;
  String text = "TEXT";

  //final textDetector = GoogleMlKit.vision.textDetector();

  // Create an Instance of [MlKitOcr]
  //final textDetector = MlKitOcr();

  final selectedNIDFront = File('').obs;

  final dateOfBirth = ''.obs;

  final serviceFeeTypeId = ''.obs;

  final nidFound = ''.obs;

  final pages = [
    NidVerificationWidget(),
    NIDInputWidget(),

    TradeLVerificationWidget(),
    UserDetailsWidget(),
    UserDetailsAddressWidget(),

    PasswordWidget(),
    // MerchantImageWidget(),
  ];
  @override
  Future<void> onInit() async {
    super.onInit();
    getBusinessType();
    getDistrictList();
    remarkType.value = Get.arguments[0];
    getAppSetting();
    registerFormKey = GlobalKey<FormState>();
    userinfo = GlobalKey<FormState>();
    usernid = GlobalKey<FormState>();
    //userData.value.customerMobileNumber = Get.arguments[0];
    userData.value.customerMobileNumber = MyData.phone_no;
    print("working 1 bro");
    //serviceFeeTypeId.value = Get.arguments[1];
    serviceFeeTypeId.value = "1";
    print("working 2 bro");
    //userData.value.service_fee_type = Get.arguments[1];
    userData.value.service_fee_type = "1";
    print("working 3 bro");
    print('userData.value.service_fee_type: ${serviceFeeTypeId.value}');

    //getServiceFeeList();
    getBusinessType();
    getDistrictList();
    getCityList();

    // userData.value.customerMobileNumber = Get.arguments['mobileNumber'];

    // locationPermission.value = Get.arguments['locationPermission'];

    // print(Get.arguments['mobileNumber']);
    // print(Get.arguments['locationPermission']);

    userData.value.openingTime =
        openingHour.value + ':' + openingMin.value + ' AM';
    userData.value.closingTime =
        closingHour.value + ':' + closingMin.value + ' AM';

//Operator ID
    // userData.value.operator_id = '1';

    userData.value.lati = '0';
    userData.value.longi = '0';

    // if (Get.arguments['locationPermission'] == 'true') {
    //   await getCurrentPosition();
    // } else {
    //   userData.value.lati = '0';
    //   userData.value.longi = '0';
    // }

    // if (locationPermissionCheck == '1') {

    // } else {}

    textEditingController = TextEditingController();
    print('hello$count');
    // printSimCardsData();
  }

  pickDate(type) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      if(type == "nid"){
        dateInputController.value.text = formattedDate;

      }else{
        dateOfBirth.value = formattedDate;
        userData.value.dob = formattedDate;
        dateInput.text = formattedDate;
        update();
      }

    } else {}
  }
  // Future<bool> _isImageClear(File imageFile, count) async {
  //   isClearImage.value = false;
  //   // Convert the image to an InputImage format
  //   final inputImage = InputImage.fromFilePath(imageFile.path);
  //   final textRecognizer = TextRecognizer();
  //   // Recognize the text from the image
  //   final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
  //
  //   // Count the number of text blocks (lines or words) detected
  //   final textBlocks = recognizedText.blocks;
  //
  //   print("read text are ${textBlocks.length}");
  //
  //   // Check if at least 10 text blocks are detected
  //   if (textBlocks.length >= count) {
  //     isClearImage.value = true;
  //     return isClearImage.value;  // Image has enough text to be considered clear
  //   } else {
  //     return isClearImage.value; // Image is not clear enough
  //   }
  // }

  uploadNid(accNo) {
    Map data = {
      'acc_no': accNo,
      'nid_image': userData.value.nid_front,
      'nid_back': userData.value.nid_back,

    };

    AuthRepository().nidUploadWithoutPass(data).then((response) {
      print("uploadNid is res account no is $accNo ____ $response");
      if(response['result'] == "success") {
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: "NID Uploaded Successfully.", title: 'Success'.tr));
        Get.toNamed(Routes.ADD_PASS_REG, arguments: [accNo]);
      }
    });
  }
  updatePass(accNo, mobile) {
    errorMessagePinSet.value = "";
    updatePassLoading.value = true;
    Map data = {'new_password': userData.value.password.toString(), 'acc_no': accNo};

    print("my payload is 87348 $data");

    AuthRepository().updatePass(data).then((response) {

      print("uploadNid is res ____ $response");
      if (response['result'] == 'success') {
        updatePassLoading.value = false;
        Get.showSnackbar(Ui.SuccessSnackBar(
            message: "Password Updated.", title: 'Success'.tr));
        Get.offNamed(Routes.LOGIN, arguments: mobile );
      } else {
        updatePassLoading.value = false;
        errorMessagePinSet.value = response['message'];
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: response['message'], title: 'Error'.tr));
      }
    });
  }
// Helper method to format the Date of Birth
  String formatDOB(String dob) {
    var months = {
      'Jan': '01',
      'Feb': '02',
      'March': '03',
      'April': '04',
      'May': '05',
      'June': '06',
      'July': '07',
      'Aug': '08',
      'Sept': '09',
      'Oct': '10',
      'Nov': '11',
      'Dec': '12'
    };

    var dobParts = dob.split(' ');
    if (dobParts.length >= 3) {
      var day = dobParts[dobParts.length - 1];
      var month = months[dobParts[dobParts.length - 2]] ??
          '01'; // Default to January if not found
      var year = dobParts[dobParts.length - 3];
      return '$day-$month-$year';
    }
    return dob;
  }

// Helper method to check if the line contains a month
  bool containsMonth(String text) {
    var months = [
      'Jan',
      'Feb',
      'March',
      'April',
      'May',
      'June',
      'July',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months.any((month) => text.contains(month));
  }

  checkUserImageWithPorichoy() {
    faceLoad.value = true;
    Ui.customLoaderDialog();
    faceMatched.value = false;
    Map data = {
      "national_id": "3700916475",
      "team_tx_id": "paystation",
      "english_output": false,
      "person_dob": "1994-11-29",
      "person_photo": userImage.value,
    };
    AccountSettingRepository().checkUserImagePorichoy(data).then((resp) {
      print("data is $resp");
      if (resp['voter']['faceMatchResult']['matched'] == true) {
        faceLoad.value = false;

        Get.back();
        faceMatched.value = true;
         porichoyNameBn.value = resp['voter']['name'];
         porichoyNameEn.value = resp['voter']['nameEn'];
         porichoyFather.value = resp['voter']['father'];
         porichoyMother.value = resp['voter']['mother'];
         porichoygender.value = resp['voter']['gender'];

        Get.showSnackbar(Ui.SuccessSnackBar(
            message: 'Face matched with your NID.'.tr, title: 'Success'));
      } else {
        Get.back();
        faceMatched.value = false;
        faceLoad.value = false;
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: 'Please take clear image of your Face.'.tr,
            title: 'Error'));
      }
    });
  }

  Future<void> nidImageMatch(ImageSource imageSource, String type) async {
    // Initialize observables
    selectedImagePath = ''.obs;
    selectedImageSize = ''.obs;

    try {
      // Pick image using the front camera
      final pickedFile = await ImagePicker().pickImage(
        source: imageSource,
        preferredCameraDevice: CameraDevice.front,
      );

      if (pickedFile == null) {
        Get.snackbar(
          'Error',
          'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Original Image Details
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          (File(selectedImagePath.value).lengthSync() / (1024 * 1024))
              .toStringAsFixed(2) +
              " MB";

      // Convert original image to Base64
      final bytes = await File(pickedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      // Update user data based on type
      if (type == "user") {
        userImage.value = base64Image;
        userData.value.image = userImage.value;
        userData.update((val) {});
        // checkUserImageWithPorichoy();
      }

      // Debug
      log('User Image (Base64): $base64Image');

    } catch (e) {
      log('Error occurred: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }



  Future<void> checkCameraPermission() async {
    // Check if the camera permission is granted
    PermissionStatus status = await Permission.camera.status;

    if (status.isGranted) {
      // Camera permission is granted
      print('Camera permission is granted.');
      Get.toNamed(Routes.NEWNID);
    } else {
      // Camera permission is not granted
      print('Camera permission is not granted. Requesting permission...');
      // Request camera permission
      status = await Permission.camera.request();
      if (status.isGranted) {
        print('Camera permission has been granted.');
        Get.toNamed(Routes.NEWNID,);
      } else {
        print('Camera permission is still not granted.');
      }
    }
  }

/*  nidRead() async {
    print("started nid checking 1........");
    final inputImage = InputImage.fromFile(selectedNIDFront.value);
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    print("started nid checking 1........");
    String text = recognisedText.text;
    print(
        "started nid checking 1 and read test ___________________$text........");
    for (TextBlock block in recognisedText.blocks) {
      final Rect rect = block.rect;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;
      print("working here ++++++1111111111111");
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        print('nid line: ${line.text}');

        if (line.text.contains('ID NO:')) {
          print("working here ++++++2222222");
          userData.value.nid = line.text.replaceAll('ID NO:', '').trim();

          print(
              'nid no: ${line.text.replaceAll('ID NO:', '').replaceAll(' ', '')}');
          print("working here ++++++3333333");
        } else if (line.text.contains('NID No') ||
            line.text.contains('NID NO')) {
          print("working here ++++++444444444");
          userData.value.nid = line.text.replaceAll('NID No', '').trim();
          print(
              'nid no +++++++++++++++++++ FROM NID NO: ${userData.value.nid}');
          print("working here ++++++555555555");
        } else {
          print("working here ++++++6666666");
          final exp = RegExp(r'(\d{10})');
          print("working here ++++++777777");
          userData.value.nid = exp.stringMatch(line.text.replaceAll(' ', ''));

          print('nid nid: ${userData.value.nid}');
        }
        //print("nid check 2${userData.value.nid!}");
        if (line.text.contains('Date of Birth:')) {
          print("working here ++++++88888888");
          dateOfBirth.value = line.text.replaceAll('Date of Birth:', '');
          print("date of birth is ${dateOfBirth.value}");
          var dob = dateOfBirth.value.split(' ');
          for (int i = dob.length - 1; i >= 0; i--) {
            if (dob[i - 1] == 'Jan') {
              userData.value.dob = dob[i] + '-' + '01' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Feb') {
              userData.value.dob = dob[i] + '-' + '02' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'March') {
              userData.value.dob = dob[i] + '-' + '03' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'April') {
              userData.value.dob = dob[i] + '-' + '04' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'May') {
              userData.value.dob = dob[i] + '-' + '05' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'June') {
              userData.value.dob = dob[i] + '-' + '06' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'July') {
              userData.value.dob = dob[i] + '-' + '07' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Aug') {
              userData.value.dob = dob[i] + '-' + '08' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Sept') {
              userData.value.dob = dob[i] + '-' + '09' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Oct') {
              userData.value.dob = dob[i] + '-' + '10' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Nov') {
              userData.value.dob = dob[i] + '-' + '11' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Dec') {
              userData.value.dob = dob[i] + '-' + '12' + '-' + dob[i - 2];
              break;
            }
          }
          print('date of birth: ${userData.value.dob}');
        }
        if (line.text.contains('Date of Birth')) {
          print("working here ++++++999999");
          dateOfBirth.value = line.text.replaceAll('Date of Birth', '');
          var dob = dateOfBirth.value.split(' ');
          for (int i = dob.length - 1; i >= 0; i--) {
            if (dob[i - 1] == 'Jan') {
              userData.value.dob = dob[i] + '-' + '01' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Feb') {
              userData.value.dob = dob[i] + '-' + '02' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'March') {
              userData.value.dob = dob[i] + '-' + '03' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'April') {
              userData.value.dob = dob[i] + '-' + '04' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'May') {
              userData.value.dob = dob[i] + '-' + '05' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'June') {
              userData.value.dob = dob[i] + '-' + '06' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'July') {
              userData.value.dob = dob[i] + '-' + '07' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Aug') {
              userData.value.dob = dob[i] + '-' + '08' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Sept') {
              userData.value.dob = dob[i] + '-' + '09' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Oct') {
              userData.value.dob = dob[i] + '-' + '10' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Nov') {
              userData.value.dob = dob[i] + '-' + '11' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Dec') {
              userData.value.dob = dob[i] + '-' + '12' + '-' + dob[i - 2];
              break;
            }
          }
          print('date of birth: ${userData.value.dob}');
        }
        // else if (line.text.contains('NID No') || line.text.contains('NID NO')) {
        //   print('nid no: ${line.text.replaceAll('NID No', '').trim()}');
        // }
        else if (line.text.contains('Jan') ||
            line.text.contains('Feb') ||
            line.text.contains('March') ||
            line.text.contains('April') ||
            line.text.contains('May') ||
            line.text.contains('June') ||
            line.text.contains('July') ||
            line.text.contains('Aug') ||
            line.text.contains('Sept') ||
            line.text.contains('Oct') ||
            line.text.contains('Nov') ||
            line.text.contains('Dec')) {
          var dob = line.text.split(' ');
          for (int i = dob.length - 1; i >= 0; i--) {
            if (dob[i - 1] == 'Jan') {
              userData.value.dob = dob[i] + '-' + '01' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Feb') {
              userData.value.dob = dob[i] + '-' + '02' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'March') {
              userData.value.dob = dob[i] + '-' + '03' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'April') {
              userData.value.dob = dob[i] + '-' + '04' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'May') {
              userData.value.dob = dob[i] + '-' + '05' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'June') {
              userData.value.dob = dob[i] + '-' + '06' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'July') {
              userData.value.dob = dob[i] + '-' + '07' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Aug') {
              userData.value.dob = dob[i] + '-' + '08' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Sept') {
              userData.value.dob = dob[i] + '-' + '09' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Oct') {
              userData.value.dob = dob[i] + '-' + '10' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Nov') {
              userData.value.dob = dob[i] + '-' + '11' + '-' + dob[i - 2];
              break;
            } else if (dob[i - 1] == 'Dec') {
              userData.value.dob = dob[i] + '-' + '12' + '-' + dob[i - 2];
              break;
            }
          }

          print('dob dob: ${userData.value.dob}');
          print('my nid no 3 ________ +++++: ${userData.value.nid}');
        }

        for (TextElement element in line.elements) {}
      }
    }

    //print("nid check 4${userData.value.nid!}");
    // if (userData.value.nid == null) {
    //   Get.showSnackbar(Ui.ErrorSnackBar(
    //       message: "Please take a clear picture of your NID", title: 'Error'));
    // } else {
    //  // duplicateNIDCheck();
    // }

    // print('nid data: ${text}');
  }*/

  duplicateNIDCheck() async {
    print("nid check 5 ${userData.value.nid!}");
    Ui.customLoaderDialog();
    AuthRepository().duplicateNIDCheck(userData.value.nid!, 'DSR').then((response) {
      Get.back();
      nidFound.value = response['result'].toString();
      print("nid duplicacy ${response['result'].toString()}");

      if (response['result'].toString() == '1') {
        print("hlw asad ++++++++++++++");

        nidDuplicate.value = true;
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: response['message'], title: 'Error'));
      } else {
        print("success in nidverify started ++++++++++++++");
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: response['message'], title: 'Success'));
        // nidVerify(
        //
        // );
      }
    }).catchError((onError) {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: 'Please take clear image of your NID'.tr, title: 'Error'));
    });
    return nidDuplicate.value;
  }

  Future selectDate() async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1950),
      lastDate: DateTime(2023),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;
    userData.value.dob = DateFormat('dd-MM-yyyy').format(selectedDate);
    userData.update((val) {});
    print(DateFormat('dd-MM-yyyy').format(selectedDate));
  }

  Future paymentCheck() async {
    print('nid numberss : ${userData.value.nid!}');
    print('date of birthss : ${dateInput.value.text}');
    Ui.customLoaderDialog();
    try {
      AuthRepository()
          .nidVerification(userData.value.nid!, dateInput.value.text)
          .then((resp) {
        print('from porichoy: ${resp.status}');
        print('from porichoy: ${resp.transactionId}');
        Get.back();
        if (resp.status == 'YES') {
          nidData.value = resp;
          userData.value.name = nidData.value.data!.nid!.fullNameEN!;
          userData.update((val) {});

          currentIndex.value++;
        } else {
          Get.showSnackbar(
              Ui.ErrorSnackBar(message: 'Invalid NID No.'.tr, title: 'Error'));
        }
      });
    } catch (e) {
      Get.back();
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Invalid NID No.'.tr, title: 'Error'));
    }
  }

  Future nidVerify() async {
    print("hlw nid verify from porichoy ++++++++++++++++++++++");
    print('nid numberss : ${userData.value.nid!}');
    print('date of birthss : ${dateInput.value.text}');
    Ui.customLoaderDialog();
    try {
      AuthRepository()
          .nidVerification(userData.value.nid!, dateInput.value.text)
          .then((resp) {
        print('from porichoy: ${resp.status}');
        print('from porichoy: ${resp.transactionId}');
        Get.back();
        if (resp.status == 'YES') {
          nidData.value = resp;
          userData.value.name = nidData.value.data!.nid!.fullNameEN!;
          userData.update((val) {});

          currentIndex.value++;
        } else {
          Get.showSnackbar(
              Ui.ErrorSnackBar(message: 'Invalid NID No.'.tr, title: 'Error'));
        }
      });
    } catch (e) {
      Get.back();
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: 'Invalid NID No.'.tr, title: 'Error'));
    }
  }

  // Serial number: 8988013204546851685
  // I/flutter ( 7467): Serial number: 89880021709044527786
  Future tryPasteCurrentPhone() async {
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;

      userData.value.customerMobileNumber = phone;

      textEditingController.text = phone ?? '+880';
      userData.value.customerMobileNumber != textEditingController.text;

      userData.update((val) {});
      for (var item in simOperators) {
        print(item.title);
        if (userData.value.customerMobileNumber!.length > 3) {
          if (userData.value.customerMobileNumber!.substring(3, 6) ==
              item.title) {
            print(userData.value.customerMobileNumber!.substring(3, 6) ==
                item.title);
            simOperator.value = item.image!;
          }
        }
      }
    } on PlatformException catch (e) {
      print('Failed to get mobile number because of: ${e.message}');
    }
  }

  // void printSimCardsData() async {
  //   print("simData");
  //   try {
  //     SimData simData = await SimDataPlugin.getSimData();
  //     for (var s in simData.cards) {
  //       print('Serial number: ${s.serialNumber}');
  //       print('Serial number: ${s.carrierName}');
  //       print('Phone number: ${s.phoneNumber}');
  //     }
  //   } on PlatformException catch (e) {
  //     print("error! code: ${e.code} - message: ${e.message}");
  //   }
  // }

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int page) {
    currentIndex.value = page;
  }

  getServiceFeeList() async {
    // favBillerLoaded.value = false;
    AccountSettingRepository().getServiceFee().then((resp) {
      // serviceCharge.value = resp;
      // userData.value.service_fee_type =
      //     serviceCharge[0].service_fee_type_id!.toString();

      // favBillerLoaded.value = true;
    });
  }

  getBusinessType() async {
    print("hlw payplus");
    BusinessTypeRepository().getBusinessType().then((resp) {
      print("hlw payplus");
      businessTypes.value = resp;
      print("hlw bro bsns type ******${businessTypes.length}");
      // userData.value.businessType = businessTypes[0].id!.toString();
    });
  }

  getDistrictList() async {
    DivisionDistrictsRepository().getdistrictType().then((resp) {
      districtsTypes.value = resp;
      print(districtsTypes.length);
      userData.value.districts = districtsTypes[0].id!.toString();
      print("userData.value.districts");
      print('sssssss:  ${userData.value.districts}');
    });
  }

  getThanaUpojila() async {
    Ui.customLoaderDialog();
    DivisionDistrictsRepository()
        .getThana(userData.value.districts!)
        .then((resp) {
      Get.back();
      thanas.value = resp;
      userData.value.thana = thanas[0].id!.toString();
    });
  }

  getCityList() async {
    DivisionDistrictsRepository().getCityType().then((resp) {
      cityList.value = resp.data;
      print("my city list is $resp");
      print(cityList.length);
      //userData.value.districts = districtsTypes[0].id!.toString();
      // print("userData.value.districts");
      //print('sssssss:  ${userData.value.districts}');
    });
  }

  getAreaList() async {
    DivisionDistrictsRepository()
        .getAreaType(selectedZoneId.value)
        .then((resp) {
      areaList.value = resp.data;
      print(areaList.length);
      //userData.value.districts = districtsTypes[0].id!.toString();
      print("userData.value.area");
      //print('sssssss:  ${userData.value.districts}');
    });
  }

  getZoneList() async {
    DivisionDistrictsRepository()
        .getZoneType(selectedCityId.value)
        .then((resp) {
      zoneList.value = resp.data;
      print(zoneList.length);
    });
  }

  // Future<void> scanImage() async {
  //
  //
  //
  //
  //   try {
  //
  //
  //     final file = File(pictureFile.path);
  //
  //     final inputImage = InputImage.fromFile(file);
  //     final recognizedText = await textRecognizer.processImage(inputImage);
  //     print("my recognized test is $recognizedText");
  //
  //     // await navigator.push(
  //     //   MaterialPageRoute(
  //     //     builder: (BuildContext context) =>
  //     //         ResultScreen(text: recognizedText.text),
  //     //   ),
  //     // );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('An error occurred when scanning text'),
  //       ),
  //     );
  //   }
  // }
  getUnion() async {
    Ui.customLoaderDialog();
    DivisionDistrictsRepository().getUnion(userData.value.thana).then((resp) {
      Get.back();
      unions.value = resp;
      userData.value.union = thanas[0].id!.toString();
    });
  }

  getAppSetting() async {
    print("app setting is   ++++++++++");

    BuySellRepository().getAppSettingRep().then((response) {


      appSettingList.value =
          response;

      print("app setting res length is ${appSettingList.value.length}");


    });
  }

  String getAgentAppValueByName(String name) {
    final match = appSettingList.value.firstWhere(
          (item) => item.name == name,
      orElse: () => AppSettingControllerModel(), // or a default/empty model
    );

    return match.agentAppValue ?? '';
  }

  // void getImage(ImageSource imageSource, String type) async {
  //   selectedImagePath = ''.obs;
  //   selectedImageSize = ''.obs;
  //
  //   // Crop code
  //   cropImagePath = ''.obs;
  //   cropImageSize = ''.obs;
  //
  //   // Compress code
  //   compressImagePath = ''.obs;
  //   compressImageSize = ''.obs;
  //
  //   final pickedFile = await ImagePicker().pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     selectedImagePath.value = pickedFile.path;
  //     selectedImageSize.value =
  //         ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
  //                 .toStringAsFixed(2) +
  //             " Mb";
  //
  //     // Crop
  //     final cropImageFile = await ImageCropper().cropImage(
  //         sourcePath: selectedImagePath.value,
  //         maxWidth: 512,
  //         maxHeight: 512,
  //         compressFormat: ImageCompressFormat.jpg);
  //     cropImagePath.value = cropImageFile!.path;
  //     cropImageSize.value =
  //         ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
  //                 .toStringAsFixed(2) +
  //             " Mb";
  //
  //     // Compress
  //     print('compress path: ${cropImagePath.value}');
  //     final dir = Directory.systemTemp;
  //     final targetPath =
  //         dir.absolute.path + '/' + cropImagePath.value.split('/').last;
  //     var compressedFile = await FlutterImageCompress.compressAndGetFile(
  //         cropImagePath.value, targetPath,
  //         quality: 100, keepExif: false, autoCorrectionAngle: true, rotate: 0);
  //     compressImagePath.value = compressedFile!.path;
  //     compressImageSize.value =
  //         ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
  //                 .toStringAsFixed(2) +
  //             " Mb";
  //
  //     // final bytes = compressedFile.readAsBytesSync();
  //
  //     List<int> bytes = compressedFile.readAsBytesSync();
  //
  //     if (type == 'nid_front') {
  //       //  selectedNIDFront.value = File(compressedFile.path);
  //
  //       selectedNIDFront.value = File(targetPath);
  //
  //       userData.value.nid_front = base64Encode(bytes);
  //       print("nid front is ${userData.value.nid_front}");
  //       nidReadNew();
  //       userData.update((val) {});
  //     }
  //     if (type == 'nid_back') {
  //       userData.value.nid_back = base64Encode(bytes);
  //       print("nid back image is ${userData.value.nid_back}");
  //       userData.update((val) {});
  //     } else if (type == 'trade') {
  //       userData.value.trade_license = base64Encode(bytes);
  //       userData.update((val) {});
  //     } else if (type == 'user') {
  //       userData.value.image = base64Encode(bytes);
  //       userData.update((val) {});
  //     } else if (type == 'trade2') {
  //       userData.value.trade_license2 = base64Encode(bytes);
  //       userData.update((val) {});
  //     }
  //     // if (type == 'user') {
  //     //   userData.value.image = base64Encode(bytes);
  //     //   userData.update((val) {});
  //     // }
  //
  //     print(userData.value.nid_front);
  //
  //     debugPrint(userData.value.nid_front);
  //
  //     debugPrint('nid_front : ${userData.value.nid_front}');
  //
  //     debugPrint(userData.value.nid_front, wrapWidth: 2024);
  //
  //     log('data: ${userData.value.nid_front}');
  //
  //     // uploadImage(compressedFile);
  //   } else {
  //     Get.snackbar('Error', 'No image selected',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }
  Future<void> getImage(ImageSource imageSource, String type) async {
    // Initialize observables
    selectedImagePath = ''.obs;
    selectedImageSize = ''.obs;

    try {
      // Pick an image
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile == null) {
        Get.snackbar(
          'Error',
          'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Original Image Details
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          (File(selectedImagePath.value).lengthSync() / (1024 * 1024))
              .toStringAsFixed(2) +
              " MB";

      // Convert original image to bytes and Base64 encode
      final bytes = await File(pickedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      // Assign to user data based on type
      switch (type) {
        case 'nid_front':
          selectedNIDFront.value = File(pickedFile.path);
          userData.value.nid_front = base64Image;
          errorText.value =
          "Your NID front image is not Clear. We cannot recognize your text on image.";
          break;

        case 'nid_back':
          userData.value.nid_back = base64Image;
          errorText.value =
          "Your NID back image is not Clear. We cannot recognize your text on image.";
          break;

        case 'trade':
          userData.value.trade_license = base64Image;
          errorText.value =
          "Your Trade License image is not Clear. We cannot recognize your text on image.";
          break;

        case 'user':
          userData.value.image = base64Image;
          break;

        case 'trade2':
          userData.value.trade_license2 = base64Image;
          errorText.value =
          "Your Trade License is not Clear. We cannot recognize your text on image.";
          break;

        default:
          Get.snackbar(
            'Error',
            'Invalid type',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
      }

      // Update reactive model
      userData.update((val) {});
      debugPrint('Encoded Image: $base64Image');

    } catch (e) {
      log('Error occurred: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getImageAndroid13(ImageSource imageSource, String type) async {
    // Initialize observables
    selectedImagePath = ''.obs;
    selectedImageSize = ''.obs;

    try {
      // Pick an image
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile == null) {
        Get.snackbar(
          'Error',
          'No image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Set original image info
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          (File(selectedImagePath.value).lengthSync() / (1024 * 1024))
              .toStringAsFixed(2) +
              " MB";

      // Read image bytes
      final bytes = await File(pickedFile.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      // Assign to user data based on type
      switch (type) {
        case 'nid_front':
          selectedNIDFront.value = File(pickedFile.path);
          userData.value.nid_front = base64Image;
          break;
        case 'nid_back':
          userData.value.nid_back = base64Image;
          break;
        case 'trade':
          userData.value.trade_license = base64Image;
          break;
        case 'user':
          userData.value.image = base64Image;
          break;
        case 'trade2':
          userData.value.trade_license2 = base64Image;
          break;
        default:
          Get.snackbar(
            'Error',
            'Invalid type',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
      }

      userData.update((val) {}); // refresh reactive model
      debugPrint('Encoded Image: $base64Image');

    } catch (e) {
      log('Error occurred: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  changeSimLogo() {
    simOperators.map((item) {
      if (userData.value.customerMobileNumber!.substring(3, 6) == item.title) {
        print(
            userData.value.customerMobileNumber!.substring(3, 6) == item.title);
        simOperator.value = item.image!;
      }
    });
  }

  // Future<void> getCurrentPosition() async {
  //   LocationPermission permission;
  //   // permission = await Geolocator.requestPermission();
  //   // // permission = await Geolocator.checkPermission();

  //   // if (permission == LocationPermission.denied) {
  //   //   permission = await Geolocator.requestPermission();
  //   // }
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //   if (position != null) {
  //     lat.value = position.latitude.toString();
  //     ;
  //     lang.value = position.longitude.toString();
  //     ;
  //     userData.value.lati = position.latitude.toString();
  //     userData.value.longi = position.longitude.toString();
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark place = placemarks[0];
  //     addresses.value =
  //         '${place.name}, ${place.subLocality}, ${place.locality}';
  //   } else {
  //     print('permission not allowed');
  //   }
  // }

  // Future<void> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     //return Future.error('Location services are disabled.');
  //     openAppSettings();
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       //return Future.error('Location permissions are denied');

  //       openAppSettings();
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //     openAppSettings();
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   print('location');
  //   await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     userData.value.lati = position.latitude.toString();
  //     userData.value.longi = position.longitude.toString();
  //     print('latitude : $position.latitude');
  //     print('longitude: $position.longitude');
  //     lat.value = position.latitude.toString();
  //     lang.value = position.longitude.toString();
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   update();
  // }

  void register() async {
    Get.focusScope!.unfocus();
    if (Get.find<LocationService>().currentLocation['lat'] == null) {
      Get.find<LocationService>().determinePosition();
    }
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();
      signupCompleted.value = false;

      Ui.customLoaderDialog();
      print(userData.value.lati);
      print(userData.value.longi);

      var data = {
        // 'nid_front': userData.value.nid_front,
        // 'nid_back': userData.value.nid_front,
        'mobile_no': userData.value.customerMobileNumber,
        'customer_name': userData.value.name ?? 'Mr.',
        'personal_mobile': userData.value.personalMobile,
        'nid': userData.value.nid,
        'dob': dateInput.value.text,
        'outlet_name': userData.value.outletName,
        'outlet_address': 'Bangladesh',
        'business_type': userData.value.businessType,
        'district_id': userData.value.districts,
        'thana_id': userData.value.thana,
        'union_id': userData.value.union,
        'post_code': userData.value.post_code,
        'service_fee_type': serviceFeeTypeId.value,
        'password': userData.value.password,
        'imei': Get.find<LocationService>().imei.value,
        "phone_model": Get.find<LocationService>().model.value,
        'customer_latitude':
            Get.find<LocationService>().currentLocation['lat'].toString(),
        'customer_longitude':
            Get.find<LocationService>().currentLocation['lng'].toString(),
        'nid_front': userData.value.nid_front,
        'nid_back': userData.value.nid_back,
        'trade_license': userData.value.trade_license ?? "",
        'remark': "Agent"
      };

      try {
        AuthRepository().userRegistration(data).then((response) {
          if (response['result'] == 'success') {
            Get.back();
            Get.showSnackbar(Ui.SuccessSnackBar(
              message: 'Registration Successful',
              title: 'Success',
            ));
            Get.offAndToNamed(Routes.LOGIN,
                arguments: userData.value.customerMobileNumber);
          } else {
            Get.back();
            Get.showSnackbar(Ui.ErrorSnackBar(
                message: response['result'], title: response['message']));
          }
        });
        signupCompleted.value = true;
      } catch (e) {
        Get.back();
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: 'Registration Failed'.tr, title: 'Error'.tr));
        print(e.toString());
      }
    }
  }

  // new register api

  void newRegistrtionApiController() async {
    Get.focusScope!.unfocus();
    if (Get.find<LocationService>().currentLocation['lat'] == null) {
      Get.find<LocationService>().determinePosition();
    }
    if (true == true) {
      //  registerFormKey.currentState!.save();
      signupCompleted.value = false;
      Ui.customLoaderDialog();
      print(userData.value.lati);
      print(userData.value.longi);
      print("my signup imei is ${Get.find<LocationService>().imei.value}");

      var data = {
        // 'nid_front': userData.value.nid_front,
        // 'nid_back': userData.value.nid_front,
        'mobile_no': personalPhone.value.text,
        'email': personalPhone.value.text,
        'customer_name': customerName.value.text,
        //'personal_mobile': userData.value.personalMobile,
        // 'nid': userData.value.nid,
        // 'dob': dateInput.text,
        'outlet_name': outletName.value.text,
        'address': 'Bangladesh',
        //'business_type': userData.value.businessType,
        'city_id': selectedCityId.value,
        'zone_id': selectedZoneId.value,
        'area_id': selectedAreaId.value,
        //'post_code': userData.value.post_code,

        //'service_fee_type': serviceFeeTypeId.value,
        //'password': userData.value.password,
        //'imei': Get.find<LocationService>().imei.value,
        'customer_latitude':
        Get.find<LocationService>().currentLocation['lat'].toString(),
        'customer_longitude':
        Get.find<LocationService>().currentLocation['lng'].toString(),
        //'nid_front': userData.value.nid_front,
        // 'nid_back': userData.value.nid_back,
        //'trade_license': userData.value.trade_license ?? "",
        'remark': remarkType.value,
      };

      try {
        AuthRepository().newUserRegistration(data).then((response) {
          if (response['result'] == 'success') {
            Get.back();
            Get.showSnackbar(Ui.SuccessSnackBar(
              message: 'Registration Successful',
              title: 'Success',
            ));
            Get.find<HomeController>().getAgentList();
            Get.offAndToNamed(Routes.ROOT,);
          } else {
            Get.back();
            Get.showSnackbar(Ui.ErrorSnackBar(
                message: response['result'], title: response['message']));
          }
        });
        signupCompleted.value = true;
      } catch (e) {
        Get.back();
        Get.showSnackbar(Ui.ErrorSnackBar(
            message: 'Registration Failed'.tr, title: 'Error'.tr));
        print(e.toString());
      }
    }
  }

  void newNIDVerificationController() async {
    print(
      "nid data is  dob is ${dateInput.value.text}",
    );
    dateOfBirth.value = userData.value.dob!;
    print(
      "nid data is image: ${userData.value.image} dob is ${userData.value.dob}",
    );
    var data = {
      // 'nid_front': userData.value.nid_front,
      // 'nid_back': userData.value.nid_front,

      'nid_front': userData.value.nid_front,
      'nid_back': userData.value.nid_back,
      'image': userData.value.image,
      'nid_number': userData.value.nid,
      'dob': dateOfBirth.value,

      // 'remark': "Agent"
    };

    try {
      AuthRepository().newNIDVerify(data).then((response) {
        if (response['result'] == 'success') {
          Get.back();
          Get.showSnackbar(Ui.SuccessSnackBar(
            message: 'KYC submitted',
            title: 'Success',
          ));
          //Get.find<AuthService>().user;


            Get.offAndToNamed(Routes.ROOT,
                arguments: userData.value.customerMobileNumber);



        } else {
          Get.back();
          Get.showSnackbar(Ui.ErrorSnackBar(
              message: response['result'], title: response['message']));
        }
      });
      signupCompleted.value = true;
    } catch (e) {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: 'Registration Failed'.tr, title: 'Error'.tr));
      print(e.toString());
    }
  }
}

