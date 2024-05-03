class IDPIcon {
  final String? title;
  final String? description;
  final String? contentType;
  final String? fileName;
  final int size;
  final String url;
  final int width;
  final int height;

  IDPIcon({
    required this.title,
    required this.description,
    required this.contentType,
    required this.fileName,
    required this.size,
    required this.url,
    required this.width,
    required this.height,
  });

  factory IDPIcon.fromJson(Map<String, dynamic> json) {
    return IDPIcon(
      title: json['title'],
      description: json['description'],
      contentType: json['contentType'],
      fileName: json['fileName'],
      size: json['size'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}

class IDPPoint {
  final double x;
  final double y;
  final String id;
  final String type;
  final String color;
  final String parentID;

  IDPPoint({
    required this.x,
    required this.y,
    required this.id,
    required this.type,
    required this.color,
    required this.parentID,
  });

  factory IDPPoint.fromJson(Map<String, dynamic> json) {
    return IDPPoint(
      x: json['x'],
      y: json['y'],
      id: json['id'],
      type: json['type'],
      color: json['color'],
      parentID: json['cls'],
    );
  }
}

enum ButtonsPosition {
  topAndBottom,
  bottom,
  left,
  right,
  verticalLeft,
  verticalRight,
  chess,
}

ButtonsPosition descriptionPositionFromString(String position) {
  switch (position) {
    case 'Top and Bottom':
      return ButtonsPosition.topAndBottom;
    case 'Bottom':
      return ButtonsPosition.bottom;
    case 'Left':
      return ButtonsPosition.left;
    case 'Right':
      return ButtonsPosition.right;
    case 'Vertical Left':
      return ButtonsPosition.verticalLeft;
    case 'Vertical Right':
      return ButtonsPosition.verticalRight;
    case 'Chess':
      return ButtonsPosition.chess;
    default:
      return ButtonsPosition.topAndBottom;
  }
}

class IDPImageView {
  final List<IDPPoint>? imageFrontMarkup;
  final List<IDPPoint>? imageBackMarkup;
  final ButtonsPosition buttonsTemplate;
  final String? description;
  final String descriptionPosition;
  final IDPImage imageFront;
  final IDPImage? imageBack;
  final IDPImage? leftImage;
  final IDPImage? rightImage;
  final IDPImage? preview;

  IDPImageView({
    required this.imageFrontMarkup,
    required this.imageBackMarkup,
    required this.buttonsTemplate,
    required this.description,
    required this.descriptionPosition,
    required this.imageFront,
    required this.imageBack,
    required this.leftImage,
    required this.rightImage,
    required this.preview,
  });

  factory IDPImageView.fromJson(Map<String, dynamic> json) {
    return IDPImageView(
      preview: json['previewAnimation'] != null
          ? IDPImage.fromJson(json['previewAnimation'])
          : null,
      imageFrontMarkup: json['imageFrontMarkup'] != null
          ? List<IDPPoint>.from(
              json['imageFrontMarkup'].map(
                (point) => IDPPoint.fromJson(point),
              ),
            )
          : null,
      imageBackMarkup: json['imageBackMarkup'] != null
          ? List<IDPPoint>.from(
              json['imageBackMarkup'].map(
                (point) => IDPPoint.fromJson(point),
              ),
            )
          : null,
      buttonsTemplate: descriptionPositionFromString(json['buttonsTemplate']),
      description: json['description'],
      descriptionPosition: json['descriptionPosition'],
      imageFront: IDPImage.fromJson(json['imageFront']),
      imageBack: json['imageBack'] != null
          ? IDPImage.fromJson(json['imageBack'])
          : null,
      leftImage: json['leftImage'] != null
          ? IDPImage.fromJson(json['leftImage'])
          : null,
      rightImage: json['rightImage'] != null
          ? IDPImage.fromJson(json['rightImage'])
          : null,
    );
  }
}

class PdfFile {
  final String title;
  final String? url;

  PdfFile({
    required this.title,
    required this.url,
  });

  factory PdfFile.fromJson(Map<String, dynamic> json) {
    return PdfFile(
      title: json['title'],
      url: json['asset']['url'],
    );
  }
}

class PdfFilesCollection {
  final List<PdfFile> items;

  PdfFilesCollection({
    required this.items,
  });

  factory PdfFilesCollection.fromJson(Map<String, dynamic> json) {
    return PdfFilesCollection(
      items: List<PdfFile>.from(
        json['items'].map(
          (pdfFile) => PdfFile.fromJson(pdfFile),
        ),
      ),
    );
  }
}

class IDPVideo {
  final String title;
  final String url;

  IDPVideo({
    required this.title,
    required this.url,
  });

  factory IDPVideo.fromJson(Map<String, dynamic> json) {
    return IDPVideo(
      title: json['title'],
      url: json['url'],
    );
  }
}

class VideosCollection {
  final List<IDPVideo> items;

  VideosCollection({
    required this.items,
  });

  factory VideosCollection.fromJson(Map<String, dynamic> json) {
    return VideosCollection(
      items: List<IDPVideo>.from(
        json['items'].map(
          (video) => IDPVideo.fromJson(video),
        ),
      ),
    );
  }
}

class IDPImage {
  final String title;
  final String description;
  final String contentType;
  final String fileName;
  final int size;
  final String url;
  final int width;
  final int height;

  IDPImage({
    required this.title,
    required this.description,
    required this.contentType,
    required this.fileName,
    required this.size,
    required this.url,
    required this.width,
    required this.height,
  });

  factory IDPImage.fromJson(Map<String, dynamic> json) {
    return IDPImage(
      title: json['title'],
      description: json['description'],
      contentType: json['contentType'],
      fileName: json['fileName'],
      size: json['size'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
