import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/component.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/fault.dart';
import 'package:help_my_truck/data/models/part.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

class PartViewModel {
  final VehicleProvider provider;
  final ChildrenPart config;

  late final part = BehaviorSubject<Part>()
    ..addStream(Stream.fromFuture(provider.part(config.id)));

  bool get hasImage => part.valueOrNull?.imageView != null;

  List<PdfFile> get pdfFiles =>
      part.valueOrNull?.pdfFilesCollection.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;
  bool get hasVideos =>
      part.valueOrNull?.videosCollection.items.isNotEmpty ?? false;

  bool get hasFaults => part.valueOrNull?.faults.isNotEmpty ?? false;

  List<ChildWarningLight> get warnings => part.valueOrNull?.warningLights ?? [];
  bool get hasWarnings => warnings.isNotEmpty;

  List<IDPVideo> get videos => part.valueOrNull?.videosCollection.items ?? [];
  List<ChildFault> get faults => part.valueOrNull?.faults ?? [];

  List<ChildProblem> get problems => part.valueOrNull?.problems ?? [];
  bool get hasProblems => problems.isNotEmpty;

  int currentTruckIndex = 0;

  PartViewModel({
    required this.provider,
    required this.config,
  });
}
