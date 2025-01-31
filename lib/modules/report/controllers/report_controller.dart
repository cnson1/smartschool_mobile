import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/authentication/controllers/authentication_manager.dart';
import 'package:smartschool_mobile/modules/report/providers/report_provider.dart';

class ReportController extends GetxController {
  var isLoading = false.obs;

  late final AuthenticationManager _authenticationManager;

  var userSemestersList = [].obs;

  var currentSemesterValue = "".obs;

  var userCoursesList = [].obs;

  var userCourseAttendanceList = [].obs;

  var selectedCourse = "".obs;

  var filterCourseAttendance = [].obs;

  var filterValue = "1".obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _authenticationManager = Get.find();
    getUserSemestersList();

    //handle scroll course attendance list
    scrollController.addListener(() {});
  }

  Future<void> getUserSemestersList() async {
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ReportProvider().getUserSemestersList(headers);
    userSemestersList.value = res;
    currentSemesterValue.value = userSemestersList.last['id'].toString();
    getCoursesInSemester();
  }

  Future<void> getCoursesInSemester() async {
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ReportProvider()
        .getUserCoursesInSemester(headers, currentSemesterValue.value);
    userCoursesList.value = res;
  }

  Future<void> getCourseAttendance(selectedCourseId) async {
    isLoading(true);
    String? token = _authenticationManager.getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    var res = await ReportProvider()
        .getUserCourseAttendance(headers, selectedCourseId);
    if (res != null) {
      isLoading(false);
      userCourseAttendanceList.value = res.attendanceList;

      filterCourseAttendance.value = res.attendanceList;
      selectedCourse.value = res.course;
      filterValue.value = "1";
    } else {
      isLoading(false);
      Get.snackbar('Lỗi ', 'Lấy danh sách thất bại!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void filterCourseAttendanceFun(String filterValue) {
    if (filterValue == "1") {
      filterCourseAttendance.value = userCourseAttendanceList;
    } else if (filterValue == "2") {
      filterCourseAttendance.value = userCourseAttendanceList
          .where(
              (courseAttendance) => courseAttendance.checkInStatus == "Attend")
          .toList();
    } else if (filterValue == "3") {
      filterCourseAttendance.value = userCourseAttendanceList
          .where((courseAttendance) => courseAttendance.checkInStatus == "Late")
          .toList();
    } else {
      filterCourseAttendance.value = userCourseAttendanceList
          .where((courseAttendance) => courseAttendance.checkInStatus == "")
          .toList();
    }
  }

  //get more course attendance data by scrolling
  void getMoreData() {}

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
