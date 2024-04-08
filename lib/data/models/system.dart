class IDPIcon {
  final String title;
  final String description;
  final String contentType;
  final String fileName;
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

class IDPImageView {
  final String internalName;
  final String imageFrontMarkup;
  final String imageBackMarkup;
  final String buttonsTemplate;
  final String description;
  final String descriptionPosition;

  IDPImageView({
    required this.internalName,
    required this.imageFrontMarkup,
    required this.imageBackMarkup,
    required this.buttonsTemplate,
    required this.description,
    required this.descriptionPosition,
  });

  factory IDPImageView.fromJson(Map<String, dynamic> json) {
    return IDPImageView(
      internalName: json['internalName'],
      imageFrontMarkup: json['imageFrontMarkup'],
      imageBackMarkup: json['imageBackMarkup'],
      buttonsTemplate: json['buttonsTemplate'],
      description: json['description'],
      descriptionPosition: json['descriptionPosition'],
    );
  }
}

class PdfFile {
  final String internalName;
  final String title;

  PdfFile({
    required this.internalName,
    required this.title,
  });

  factory PdfFile.fromJson(Map<String, dynamic> json) {
    return PdfFile(
      internalName: json['internalName'],
      title: json['title'],
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
          json['items'].map((pdfFile) => PdfFile.fromJson(pdfFile))),
    );
  }
}

class IDPVideo {
  final String internalName;
  final String title;
  final String url;

  IDPVideo({
    required this.internalName,
    required this.title,
    required this.url,
  });

  factory IDPVideo.fromJson(Map<String, dynamic> json) {
    return IDPVideo(
      internalName: json['internalName'],
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
