abstract class Queries {
  static String pdfFilesCollection = '''
  pdfFilesCollection {
          items {
            asset {
              url
            }
            title
          }
        }
  ''';
  static String warningCollection = '''
    warningLightsCollection {
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
    ''';

  static String getWholeWarningsCollection = '''
query WarningLights {
  warningLightCollection {
    items {
      sys {
        id
      }
      name
      linkedFrom {
        entryCollection(limit: 30, skip: 0) {
          items {
            ... on SubPart {
              __typename
              name
              sys {
                id
              }
            }
            ... on Part {
              __typename
              name
              sys {
                id
              }
            }
            ... on SubPart {
              __typename
              name
              sys {
                id
              }
            }
            ... on ProblemCase {
              __typename
              sys {
                id
              }
              name
            }
            ... on Component {
              __typename
              sys {
                id
              }
              name
              type
            }
          }
        }
      }
      icon {
        $image
      }
    }
  }
}
''';
  static String problemsCollection = '''
   problemCasesCollection(limit: 50) {
      items {
        sys {
          id
        }
        name
      } 
    }
    ''';

  static String videoCollection = '''
    videosCollection {
          items {
            title
            url
          } 
        }
  ''';

  static const faultsCodesCollection = '''
faultCodesCollection {
      items {
        sys {
          id
        }
        spnCode
        fmiCodes
        showAsPdf
      } 
    }
    ''';

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
    previewAnimation {
      title
      description
      contentType
      fileName
      size
      url
      width
      height
    }
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
      sys {
        id
      }
      name
      childrenCollection {
        items {
          ... on Unit {
            __typename
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
          ... on System {
            __typename
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
      }
      imageView {
        imageFrontMarkup
        buttonsTemplate
        imageBackMarkup
        description
        descriptionPosition
        imageFront {
          title
          description
          fileName
          url
          width
          height
          size
          contentType
        }
        imageBack {
          title
          description
          fileName
          url
          width
          height
          size
          contentType
        }
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
    name
    icon {
      $image
    } 
    imageView {
      $imageView
    }
    $problemsCollection
    childrenCollection {
      items {
        sys {
          id
        }
        childrenCollection {
        
          items {
            ... on Component {
              type
            }
            ... on System {
              __typename
            }
          }
        }
        name
        icon {
          $image
        } 
      }
    }
    description {
      json
    }
    $videoCollection
    pdfFilesCollection {
      items {
        title
        asset {
          $image
        }
      }
    }
  }
} 
''';
  }

  static String problemCase({required String id}) {
    return '''
    query ProblemCase(\$id: String = "$id") {
  problemCase(id: \$id) {
    name
    description {
      json
    }
    videosCollection {
      items {
        title
        url
      }
    }
    pdfFilesCollection {
      items {
        
        title
        asset {
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
    $warningCollection
    $faultsCodesCollection
    image {
      $image
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
    description {
      json
    }
    icon {
      $image
    } 
    imageView {
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
    	previewAnimation {
      	$image
    	}
    }
    $videoCollection
    $problemsCollection
    childrenCollection {
      items {
        ... on Component {
          __typename
          sys {
            id
          }
          type
          name
          icon {
            $image
          } 
        }
        ... on System {
          __typename
          sys {
            id
          }
          name
          icon {
            $image
          } 
        }
      }
    }
    pdfFilesCollection {
      items {
        title
        asset {
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
    $videoCollection
    $faultsCodesCollection
    $problemsCollection
    $warningCollection
    name
    icon {
      $image
    } 
    description {json}
    imageView {
      $imageView
    }
    pdfFilesCollection {
          items {
            asset {
              url
            }
            title
          }
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

  static String subPartById({required String id}) {
    return '''
query Subpart(\$id: String = "$id") {
	subPart(id: \$id) {
    internalName
    name
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
    $problemsCollection
    $faultsCodesCollection
    $warningCollection
    imageView {
      $imageView
    }
    description {
      json
    }
    $pdfFilesCollection
    $videoCollection
  }
}''';
  }

  static String partById({required String id}) {
    return '''
    query Part(\$id: String = "$id") {
      part(id: \$id) {
        name
        icon {
          $image
        } 
        $problemsCollection
        $faultsCodesCollection
        $warningCollection
        description {
          json
        }
        imageView {
          $imageView
        }
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
        $pdfFilesCollection
        $videoCollection
      }
    } 
    ''';
  }

  static faultById({required String id}) {
    return '''
    query FaultById(\$id: String = "$id") {
  faultCode(id: \$id) {
    sys {
      id
    }
    spnCode
    fmiCodes
    showAsPdf
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
    description {
      json
    }
    pdfFilesCollection {
      items {
        title
        asset {
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
    videosCollection {
      items {
        title
        url
      } 
    }
  }
} 
    ''';
  }

  static String foundFaults({
    required String spn,
    required String fmi,
  }) {
    return '''
    query SearchFaultCode(\$spnCode: String! = "$spn", \$fmiCodes: String! = "$fmi") {
  faultCodeCollection(
    where: {spnCode: \$spnCode, fmiCodes_contains_some: [\$fmiCodes]}
    limit: 50
  ) {
    items {
      sys {
        id
      }
      showAsPdf
      spnCode
      fmiCodes
      linkedFrom {
        entryCollection(limit: 100, skip: 0) {
          items {
          ... on SubPart {
              __typename
              name
              sys {
                id
              }
            }
            ... on Part {
              __typename
              name
              sys {
                id
              }
            }
            ... on Component {
              __typename
              name
              sys {
                id
              }
            }
          }
        }
      }
    }
  }
}
    ''';
  }
}
