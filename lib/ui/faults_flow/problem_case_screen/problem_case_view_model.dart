import 'package:help_my_truck/data/models/child_problem.dart';
import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/data/models/problem_case.dart';
import 'package:help_my_truck/services/API/favorites_provider.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProblemCaseScreenViewModel {
  final VehicleProvider provider;
  final FavoritesProvider favoritesProvider;
  final ChildProblem config;

  late final problem = BehaviorSubject<ProblemCase>()
    ..addStream(Stream.fromFuture(provider.problemCase(config.id)));

  List<IDPVideo> get videos => problem.valueOrNull?.videos ?? [];
  bool get hasVideos => videos.isNotEmpty;

  List<PdfFile> get pdfFiles =>
      problem.valueOrNull?.pdfFilesCollection.items ?? [];
  bool get hasPDF => pdfFiles.isNotEmpty;

  List<ChildWarningLight> get warnings =>
      problem.valueOrNull?.warningLights ?? [];
  bool get hasWarnings => warnings.isNotEmpty;
  Map<String, dynamic>? get description => problem.valueOrNull?.description;
  bool get hasDescription => description != null;

  ProblemCaseScreenViewModel({
    required this.provider,
    required this.config,
    required this.favoritesProvider, 
  });
}
