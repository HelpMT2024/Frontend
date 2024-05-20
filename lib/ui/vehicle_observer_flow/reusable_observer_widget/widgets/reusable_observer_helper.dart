import 'package:help_my_truck/data/models/contentfull_entnities.dart';
import 'package:help_my_truck/extensions/list_extensions.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/reusable_observer_widget/reusable_observer_screen.dart';

class ReusableObserverHelperModel {
  final List<List<IDPIcon?>> chunked;
  final List<List<ReusableModel>> models;

  ReusableObserverHelperModel({required this.chunked, required this.models});
}

abstract class ReusableObserverHelper {
  static List<List<ReusableModel>> getReusableObserverHelperModel({
    required ReusableObserverWidgetConfig config,
    required int chunkSize,
    required bool isFront,
  }) {
    final models = config.models;

    final frontMarkup = config.imageView.imageFrontMarkup;
    final backMarkup = config.imageView.imageBackMarkup;

    final filtered = models.where((button) {
      return isFront
          ? _filter(frontMarkup, button)
          : _filter(backMarkup, button);
    }).toList();

    return filtered.chunked(chunkSize);
  }

  static bool _filter(List<IDPPoint>? points, ReusableModel model) {
    if (points == null) {
      return false;
    }

    final filtered = points.where((point) {
      return point.parentID == model.id;
    }).toList();

    return filtered.isNotEmpty;
  }
}
