abstract class Queries {
  static const String getTrucks = r'''
    query TruckCollection {
  truckCollection {
  	items {
      sys {
        id
      }
      name
      image {
        title
        description
        contentType
        fileName
        size
        url
        width
        height
      }
    }
  }
}
  ''';

  static const String getEngines = r'''
    query EngineCollection {
  engineCollection {
  	items {
      sys {
        id
      }
      name
      image {
        title
        description
        contentType
        fileName
        size
        url
        width
        height
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
            title
            description
            contentType
            fileName
            size
            url
            width
            height
          }
        }
      }
      imageView {
        imageFrontMarkup
        buttonsTemplate
        imageBackMarkup
        imageFront {
          title
          description
          contentType
          fileName
          size
          url
          width
          height
        }
        description
        descriptionPosition
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
      title
      description
      contentType
      fileName
      size
      url
      width
      height
    } 
    imageView {
      imageFront {
        title
        description
        contentType
        fileName
        size
        url
        width
        height
      }
      imageFrontMarkup
      imageBackMarkup
      buttonsTemplate
      description
      descriptionPosition
    }
    childrenCollection {
      items {
        sys {
          id
        }
        internalName
        name
        icon {
          title
          description
          contentType
          fileName
          size
          url
          width
          height
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
      title
      description
      contentType
      fileName
      size
      url
      width
      height
    } 
    imageView {
      imageFrontMarkup
      imageBackMarkup
      imageFront {
          title
          description
          contentType
          fileName
          size
          url
          width
          height
        }
      buttonsTemplate
      description
      descriptionPosition
    }
    childrenCollection {
      items {
        sys {
          id
        }
        internalName
        name
        icon {
          title
          description
          contentType
          fileName
          size
          url
          width
          height
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
      title
      description
      contentType
      fileName
      size
      url
      width
      height
    } 
    imageView {
      imageFront {
          title
          description
          contentType
          fileName
          size
          url
          width
          height
        }
      imageFrontMarkup
      imageBackMarkup
      buttonsTemplate
      description
      descriptionPosition
    }
    childrenCollection {
      items {
        sys {
          id
        }
        icon {
          title
          description
          contentType
          fileName
          size
          url
          width
          height
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
          title
          description
          contentType
          fileName
          size
          url
          width
          height
        } 
        description {
          json
        }
        imageView {
          imageFront {
              title
              description
              contentType
              fileName
              size
              url
              width
              height
            }
          imageFrontMarkup
          imageBackMarkup
          buttonsTemplate
          description
          descriptionPosition
        }
        pdfFilesCollection {
          items {
            internalName
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
            imageFront {
              title
              description
              contentType
              fileName
              size
              url
              width
              height
            } 
            internalName
            imageFrontMarkup
            imageBackMarkup
            buttonsTemplate
            description
            descriptionPosition
          }
          icon {
            title
            description
            contentType
            fileName
            size
            url
            width
            height
          }
        } 
      }
    }
    ''';
  }
}
