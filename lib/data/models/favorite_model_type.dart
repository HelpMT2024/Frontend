import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FavoriteModelType {
  unit,
  system,
  component,
  part,
  subPart,
  faultCode,
  problemCase,
}

extension FavoriteModelTypesExtension on FavoriteModelType {
  static Map<String, FavoriteModelType> itemTypeByString = {
    "unit": FavoriteModelType.unit,
    "system": FavoriteModelType.system,
    "driver_display": FavoriteModelType.system,
    "component": FavoriteModelType.component,
    "warning_lights": FavoriteModelType.component,
    "part": FavoriteModelType.part,
    "sub_parts": FavoriteModelType.subPart,
    "fault_code": FavoriteModelType.faultCode,
    "problem_case": FavoriteModelType.problemCase,
  };

  String title(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (this) {
      case FavoriteModelType.unit:
        return l10n?.favorites_item_type_units ?? '';
      case FavoriteModelType.system:
        return l10n?.favorites_item_type_systems ?? '';
      case FavoriteModelType.component:
        return l10n?.favorites_item_type_components ?? '';
      case FavoriteModelType.part:
        return l10n?.favorites_item_type_parts ?? '';
      case FavoriteModelType.subPart:
        return l10n?.favorites_item_type_sub_parts ?? '';
      case FavoriteModelType.faultCode:
        return l10n?.favorites_item_type_fault_codes ?? '';
      case FavoriteModelType.problemCase:
        return l10n?.favorites_item_type_problem_cases ?? '';
    }
  }

  String filterKey() {
    switch (this) {
      case FavoriteModelType.unit:
        return 'unit';
      case FavoriteModelType.system:
        return 'system';
      case FavoriteModelType.component:
        return 'component';
      case FavoriteModelType.part:
        return 'part';
      case FavoriteModelType.subPart:
        return 'sub_part';
      case FavoriteModelType.faultCode:
        return 'fault_code';
      case FavoriteModelType.problemCase:
        return 'problem_case';
    }
  }

  List<String> filterKeys() {
    switch (this) {
      case FavoriteModelType.unit:
        return ['unit'];
      case FavoriteModelType.system:
        return ['system', 'driver_display'];
      case FavoriteModelType.component:
        return ['component', 'warning_lights'];
      case FavoriteModelType.part:
        return ['part'];
      case FavoriteModelType.subPart:
        return ['sub_part'];
      case FavoriteModelType.faultCode:
        return ['fault_code'];
      case FavoriteModelType.problemCase:
        return ['problem_case'];
    }
  }
}

enum FavoriteModelSubType {
  driverDisplay,
  warningLights,
}

extension FavoriteModelSubTypeExtension on FavoriteModelSubType {
  String filterKey() {
    switch (this) {
      case FavoriteModelSubType.driverDisplay:
        return 'driver_display';
      case FavoriteModelSubType.warningLights:
        return 'warning_lights';
    }
  }
}
