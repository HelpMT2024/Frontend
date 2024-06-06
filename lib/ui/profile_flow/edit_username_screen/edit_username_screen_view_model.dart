import 'package:flutter/material.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:rxdart/rxdart.dart';

class EditUsernameScreenViewModel with ViewModelErrorHandable {
  final ProfileProvider provider;

  late final isLoading = BehaviorSubject<bool>.seeded(false);

  String? _username;

  EditUsernameScreenViewModel({required this.provider});

  void saveUsername(String? value) {
    if (value != _username) {
      _username = value;
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username can't be empty";
    }

    return null;
  }

  void submit(BuildContext context) {
    if (_username?.isNotEmpty ?? false) {
      isLoading.add(true);
      provider.editUsername(newUsername: _username ?? '').then((value) {
        isLoading.add(false);
      }).catchError((error) {
        isLoading.add(false);
        showAlertDialog(context, error.message);
      });
    }
  }
}
