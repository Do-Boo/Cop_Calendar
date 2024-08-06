import "dart:io";
import "package:events_app/api/api_database_query.dart";
import "package:events_app/api/api_kakao_login.dart";
import "package:events_app/api/api_social_login.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";
import "package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value;
  set themeMode(ThemeMode mode) => _themeMode.value = mode;

  void toggleTheme() => themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}

class SelectedDayController extends GetxController {
  static SelectedDayController get to => Get.find();
  final Rx<DateTime> _selectedDay = DateTime.now().obs;
  final df = DateFormat("yyyy-MM-dd");

  DateTime get selectedDay => _selectedDay.value;
  bool get isAtToday => df.format(selectedDay) == df.format(DateTime.now());
  set selectedDay(DateTime day) => _selectedDay.value = day;
}

class SelectedRoomController extends GetxController {
  static SelectedRoomController get to => Get.find();
  final RxString _selectedRoom = "".obs;

  String get selectedRoom => _selectedRoom.value;
  set selectedRoom(String room) => _selectedRoom.value = room;
}

class DScrollController extends GetxController {
  static DScrollController get to => Get.find();
  final _scrollController = DraggableScrollableController();
  final RxDouble _isValue = 0.0.obs;
  final RxBool _isAtMax = false.obs;

  double get isValue => _isValue.value;
  DraggableScrollableController get scrollController => _scrollController;
  bool get isAtMax => _isAtMax.value;
  set isValue(double value) => _isValue.value = value;
  set isAtMax(bool value) => _isAtMax.value = value;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() => isAtMax = scrollController.size > 0.95);
  }
}

class ImagePickerController extends GetxController {
  static ImagePickerController get to => Get.find();
  final Rx<File> _selectedImage = Rx<File>(File(""));
  final RxBool isImageSelected = false.obs;

  File get selectedImage => _selectedImage.value;

  Future<bool> get isImageExists async => await selectedImage.exists();

  Future<void> imageEmpty() async {
    _selectedImage.value = File("");
    isImageSelected.value = false;
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage.value = File(pickedFile.path);
      isImageSelected.value = true;
    } else {
      _selectedImage.value = File("");
      isImageSelected.value = false;
    }
  }
}

class TextFieldsController extends GetxController {
  static TextFieldsController get to => Get.find();
  final _controller = TextEditingController();
  final RxString _getText = "".obs;

  String get getText => _getText.value;
  TextEditingController get controller => _controller;
  set setText(String text) => _getText.value = text;

  @override
  void onInit() {
    super.onInit();
    controller.addListener(() => setText = controller.text);
  }
}

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final RxBool _isLoggedIn = false.obs;
  final RxString _id = "".obs;
  final RxString _nickName = "로그인".obs;
  final RxString _profile =
      "https://postfiles.pstatic.net/MjAyMTA4MDlfMjg0/MDAxNjI4NTEwNjAyNDA4.GgeIKeGBu5yYWX9045TbFhmMZfewgDis7M6fD9iZsdAg.a1bapsTv33BhVcxbzawB9SRdUVcpo306y7KJgGzWO2Qg.JPEG.soeunkim764/0A39D13C-8535-4526-ADAB-0CC5926B05E5.jpeg?type=w773"
          .obs;

  final SocialLogin _socialLogin = KakaoLogin();
  final _defaultProfile =
      "https://postfiles.pstatic.net/MjAyMTA4MDlfMjg0/MDAxNjI4NTEwNjAyNDA4.GgeIKeGBu5yYWX9045TbFhmMZfewgDis7M6fD9iZsdAg.a1bapsTv33BhVcxbzawB9SRdUVcpo306y7KJgGzWO2Qg.JPEG.soeunkim764/0A39D13C-8535-4526-ADAB-0CC5926B05E5.jpeg?type=w773";

  bool get isLoggedIn => _isLoggedIn.value;
  String get id => _id.value;
  String get nickName => _nickName.value;
  String get profile => _profile.value;

  @override
  void onInit() {
    super.onInit();
    checkAutoLogin();
  }

  Future<void> login() async {
    bool success = await _socialLogin.login();
    if (success) {
      User user = await UserApi.instance.me();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("checkAutoLogin", true);
      await prefs.setString("id", "${user.id}");
      await prefs.setString("nickName", user.kakaoAccount!.profile?.nickname ?? "");
      await prefs.setString("profile", user.kakaoAccount?.profile?.profileImageUrl ?? _defaultProfile);

      print("${user.id}, ${user.kakaoAccount!.profile?.nickname ?? "없음"}, ${user.kakaoAccount?.profile?.profileImageUrl ?? "없음"}");

      String asdf = await insertUserPreferences();

      print(asdf);

      _id.value = prefs.getString("id") ?? "";
      _nickName.value = prefs.getString("nickName") ?? "로그인";
      _profile.value = prefs.getString("profile") ?? _defaultProfile;
      _isLoggedIn.value = true;
    } else {
      print("Login failed");
    }
  }

  Future<void> logout() async {
    bool success = await _socialLogin.logout();
    if (success) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("checkAutoLogin");
      await prefs.remove("id");
      await prefs.remove("nickName");
      await prefs.remove("profile");

      _id.value = "";
      _nickName.value = "로그인";
      _profile.value = _defaultProfile;
      _isLoggedIn.value = false;
    } else {
      print("Logout failed");
    }
  }

  Future<void> checkAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkAutoLogin = prefs.getBool("checkAutoLogin") ?? false;

    if (checkAutoLogin) {
      _id.value = prefs.getString("id") ?? "";
      _nickName.value = prefs.getString("nickName") ?? "로그인";
      _profile.value = prefs.getString("profile") ?? _defaultProfile;
      _isLoggedIn.value = true;
    }
  }
}
