import 'dart:async';

import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/favorite_model_type.dart';
import 'package:help_my_truck/data/models/problem_case.dart';
import 'package:help_my_truck/extensions/widget_error.dart';
import 'package:help_my_truck/services/API/item_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProblemCaseScreenViewModel with ErrorHandable {
  final VehicleProvider provider;
  final ItemProvider itemProvider;
  final FavoriteModelType itemType = FavoriteModelType.problemCase;
  final ChildProblem config;

  var itemStreamController = StreamController<ContentfulItem>();

  late final problem = BehaviorSubject<ProblemCase>()
    ..addStream(Stream.fromFuture(
      provider.problemCase(config.id).catchError((error) {
        showAlertDialog(null, error);
      }),
    ));

  List<IDPVideo> get videos => problem.valueOrNull?.videos ?? [];
  bool get hasVideos => videos.isNotEmpty;

  List<PdfFile> get pdfFiles =>
      problem.valueOrNull?.pdfFilesCollection.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;

  List<ChildFault> get faults => problem.valueOrNull?.faults ?? [];
  bool get hasFaults => faults.isNotEmpty;

  List<ChildWarningLight> get warnings =>
      problem.valueOrNull?.warningLights ?? [];
  bool get hasWarnings => warnings.isNotEmpty;
  Map<String, dynamic>? get description => problem.valueOrNull?.description;
  bool get hasDescription => description != null;
  bool get hasImage => problem.valueOrNull?.image != null;

  ProblemCaseScreenViewModel({
    required this.provider,
    required this.config,
    required this.itemProvider,
  }) {
    item();
  }

  item() {
    itemProvider
        .processItem(config.id, itemType.filterKey())
        .then((item) => itemStreamController.add(item));
  }
}
