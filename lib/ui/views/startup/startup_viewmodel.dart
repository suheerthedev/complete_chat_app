import 'package:alwan_chat_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService navigationService = NavigationService();

  StartupViewModel() {
    initializeApp();
  }

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
    navigateToPhoneRegistration();
  }

  void navigateToPhoneRegistration() {
    navigationService.replaceWithPhoneRegistrationView();
  }
}
