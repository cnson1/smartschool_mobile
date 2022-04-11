import 'package:get/get.dart';
import 'package:smartschool_mobile/modules/changePassword/views/change_password_screen.dart';
import 'package:smartschool_mobile/modules/checkinToday/bindings/get_inday_attendance_bindings.dart';
import 'package:smartschool_mobile/modules/checkinToday/views/get_inday_attendance_screen.dart';
import 'package:smartschool_mobile/modules/dashboard/views/dashboard_screen.dart';
import 'package:smartschool_mobile/modules/notification/views/notification_screen.dart';
import 'package:smartschool_mobile/modules/profile/bindings/profile_bindings.dart';
import 'package:smartschool_mobile/modules/profile/views/profile_screen.dart';
import 'package:smartschool_mobile/modules/qrcode/views/qrcode_screen.dart';
import 'package:smartschool_mobile/modules/report/views/report_screen.dart';
import 'package:smartschool_mobile/modules/report/views/subject_detail_report_screen.dart';
import 'package:smartschool_mobile/modules/setttings/bindings/settings_binding.dart';
import 'package:smartschool_mobile/modules/setttings/views/setttings_screen.dart';
import 'package:smartschool_mobile/modules/splash/views/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashBoardScreen(),
        children: [
          GetPage(name: Routes.qrcode, page: () => QRCodeScreen()),
          GetPage(name: Routes.report, page: () => const ReportScreen()),
          GetPage(
              name: Routes.profile,
              page: () => const ProfileScreen(),
              binding: ProfileBinding()),
          GetPage(
              name: Routes.settings,
              page: () => SettingsScreen(),
              binding: SettingsBinding(),
              children: [
                GetPage(
                    name: Routes.changePassword,
                    page: () => const ChangePasswordScreen()),
              ]),
          GetPage(
            name: Routes.notification,
            page: () => const NotificationScreen(),
          ),
          GetPage(
              name: Routes.checkinToday,
              page: () => const CheckinTodayScreen(),
              binding: GetIndayAttendanceBinding()),
        ]),
    GetPage(
        name: Routes.subjectDetailReport,
        page: () => const SubjectDetailReportScreen()),
  ];
}
