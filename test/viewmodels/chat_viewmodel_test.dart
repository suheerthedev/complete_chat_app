import 'package:flutter_test/flutter_test.dart';
import 'package:alwan_chat_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ChatViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
