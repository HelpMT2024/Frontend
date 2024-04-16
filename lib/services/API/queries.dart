abstract class Queries {
  static const image = '''
    title
    description
    contentType
    fileName
    size
    url
    width
    height
  ''';

  static const imageView = '''
    imageFront {
      $image
    }
    imageBack {
      $image
    }
    leftImage {
      $image
    }
    rightImage {
      $image
    }
    imageFrontMarkup
    imageBackMarkup
    buttonsTemplate
    description
    descriptionPosition
  ''';
  static const String getTrucks = '''
    query TruckCollection {
  truckCollection {
  	items {
      sys {
        id
      }
      name
      image {
        $image
      }
    }
  }
}
  ''';

  static const String getEngines = '''
    query EngineCollection {
  engineCollection {
  	items {
      sys {
        id
      }
      name
      image {
        $image
      }
    }
  }
}
''';

  static String getConfiguration({
    required String truckId,
    required String engineId,
  }) {
    return '''
    query ConfigurationByTruckAndEngineId(\$truckId: String = "$truckId", \$engineId: String = "$engineId") {
  configurationCollection(
    where: {truck: {sys: {id: \$truckId}}, engine: {sys: {id: \$engineId}}},
    limit: 1
  ) {
    items {
      name
      childrenCollection {
        items {
          sys {
            id
          }
          name
          icon {
            $image
          }
        }
      }
      imageView {
        $imageView
      } 
    }
  }
}
''';
  }

  static String unitById({required String id}) {
    return '''
    query Unit(\$id: String = "$id") {
  unit(id: \$id) {
    internalName
    name
    icon {
      $image
    } 
    imageView {
      $imageView
    }
    childrenCollection {
      items {
        sys {
          id
        }
        internalName
        name
        icon {
          $image
        } 
      }
    }
  }
} 
''';
  }

  static String systemById({required String id}) {
    return '''
    query System(\$id: String = "$id") {
  system(id: \$id) {
    sys {
      id
    }
    name
    icon {
      $image
    } 
    imageView {
      $imageView
    }
    childrenCollection {
      items {
        sys {
          id
        }
        internalName
        name
        icon {
          $image
        } 
      }
    }
  }
} 
''';
  }

  static String componentById({required String id}) {
    return '''
    query Component(\$id: String = "$id") {
  component(id: \$id) {
    sys {
      id
    }
    internalName
    name
    icon {
      $image
    } 
    imageView {
      $imageView
    }
    childrenCollection {
      items {
        sys {
          id
        }
        icon {
          $image
        }
        name
      }
    }
  }
} 
''';
  }

  static String partById({required String id}) {
    return '''
    query Part(\$id: String = "$id") {
      part(id: \$id) {
        internalName
        name
        icon {
          $image
        } 
        description {
          json
        }
        imageView {
          $imageView
        }
        pdfFilesCollection {
          items {
            internalName
            asset {
              url
            }
            title
          }
        }
        videosCollection {
          items {
            internalName
            title
            url
          } 
        }
      }
    } 
    ''';
  }

  static String getPartCollection() {
    return '''
      query GetPartCollection {
      partCollection {
        items {
          sys {
            id
          }
          internalName
          name
          imageView {
            $imageView
          }
          icon {
            $image
          }
        } 
      }
    }
    ''';
  }
}
