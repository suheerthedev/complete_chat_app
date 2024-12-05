import 'package:alwan_chat_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:alwan_chat_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:alwan_chat_app/ui/views/home/home_view.dart';
import 'package:alwan_chat_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:alwan_chat_app/ui/views/otp_verification/otp_verification_view.dart';
import 'package:alwan_chat_app/ui/views/phone_registration/phone_registration_view.dart';
import 'package:alwan_chat_app/ui/views/user_info/user_info_view.dart';
import 'package:alwan_chat_app/services/phone_auth_service.dart';
import 'package:alwan_chat_app/ui/views/chat/chat_view.dart';
import 'package:alwan_chat_app/ui/dialogs/user_input/user_input_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: OtpVerificationView),
    MaterialRoute(page: PhoneRegistrationView),
    MaterialRoute(page: UserInfoView),
    MaterialRoute(page: ChatView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: PhoneAuthService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: UserInputDialog),
// @stacked-dialog
  ],
)
class App {}
