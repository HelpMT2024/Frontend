import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/auth_provider.dart';
import 'package:rxdart/rxdart.dart';

class DisclaimerScreenViewModel with ErrorHandable {
  final AuthProvider provider;

  late final text = BehaviorSubject<String?>.seeded(null)
    ..addStream(Stream.fromFuture(
      // ignore: body_might_complete_normally_catch_error
      provider.disclaimer().catchError((error) {
        showAlertDialog(null, error);
      }),
    ));

  DisclaimerScreenViewModel({required this.provider});
}
