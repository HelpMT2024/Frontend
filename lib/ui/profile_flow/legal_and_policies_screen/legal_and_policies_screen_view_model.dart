import 'package:flutter/cupertino.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:help_my_truck/services/router/auth_router.dart';

class LegalAndPoliciesScreenViewModel with ErrorHandable {
  final ProfileProvider provider;

  LegalAndPoliciesScreenViewModel({required this.provider});

  void terms(BuildContext context) {
    Navigator.of(context).pushNamed(AuthRouteKeys.termsOfService);
  }

  void privacyPolicy(BuildContext context) {
    Navigator.of(context).pushNamed(AuthRouteKeys.privacyPolicy);
  }

  void disclaimer(BuildContext context) {
    Navigator.of(context).pushNamed(AuthRouteKeys.disclaimer);
  }
}
