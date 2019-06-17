class SearchResponse {
  List<Null> disruptions;
  List<Null> feedPublishers;
  List<Links> links;
  Context context;
  List<PtObjects> ptObjects;

  SearchResponse(
      {this.disruptions,
      this.feedPublishers,
      this.links,
      this.context,
      this.ptObjects});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
    if (json['pt_objects'] != null) {
      ptObjects = new List<PtObjects>();
      json['pt_objects'].forEach((v) {
        ptObjects.add(new PtObjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    if (this.context != null) {
      data['context'] = this.context.toJson();
    }
    if (this.ptObjects != null) {
      data['pt_objects'] = this.ptObjects.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Links {
  String href;
  String type;
  String rel;
  bool templated;

  Links({this.href, this.type, this.rel, this.templated});

  Links.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    type = json['type'];
    rel = json['rel'];
    templated = json['templated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['type'] = this.type;
    data['rel'] = this.rel;
    data['templated'] = this.templated;
    return data;
  }
}

class Context {
  String timezone;
  String currentDatetime;

  Context({this.timezone, this.currentDatetime});

  Context.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    currentDatetime = json['current_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    data['current_datetime'] = this.currentDatetime;
    return data;
  }
}

class PtObjects {
  String embeddedType;
  StopArea stopArea;
  int quality;
  String name;
  String id;

  PtObjects(
      {this.embeddedType, this.stopArea, this.quality, this.name, this.id});

  PtObjects.fromJson(Map<String, dynamic> json) {
    embeddedType = json['embedded_type'];
    stopArea = json['stop_area'] != null
        ? new StopArea.fromJson(json['stop_area'])
        : null;
    quality = json['quality'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embedded_type'] = this.embeddedType;
    if (this.stopArea != null) {
      data['stop_area'] = this.stopArea.toJson();
    }
    data['quality'] = this.quality;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class StopArea {
  List<Codes> codes;
  String name;
  List<Null> links;
  Coord coord;
  String label;
  List<AdministrativeRegions> administrativeRegions;
  String timezone;
  String id;

  StopArea(
      {this.codes,
      this.name,
      this.links,
      this.coord,
      this.label,
      this.administrativeRegions,
      this.timezone,
      this.id});

  StopArea.fromJson(Map<String, dynamic> json) {
    if (json['codes'] != null) {
      codes = new List<Codes>();
      json['codes'].forEach((v) {
        codes.add(new Codes.fromJson(v));
      });
    }
    name = json['name'];
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    label = json['label'];
    if (json['administrative_regions'] != null) {
      administrativeRegions = new List<AdministrativeRegions>();
      json['administrative_regions'].forEach((v) {
        administrativeRegions.add(new AdministrativeRegions.fromJson(v));
      });
    }
    timezone = json['timezone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.codes != null) {
      data['codes'] = this.codes.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    data['label'] = this.label;
    if (this.administrativeRegions != null) {
      data['administrative_regions'] =
          this.administrativeRegions.map((v) => v.toJson()).toList();
    }
    data['timezone'] = this.timezone;
    data['id'] = this.id;
    return data;
  }
}

class Codes {
  String type;
  String value;

  Codes({this.type, this.value});

  Codes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class Coord {
  String lat;
  String lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class AdministrativeRegions {
  String insee;
  String name;
  int level;
  Coord coord;
  String label;
  String id;
  String zipCode;

  AdministrativeRegions(
      {this.insee,
      this.name,
      this.level,
      this.coord,
      this.label,
      this.id,
      this.zipCode});

  AdministrativeRegions.fromJson(Map<String, dynamic> json) {
    insee = json['insee'];
    name = json['name'];
    level = json['level'];
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    label = json['label'];
    id = json['id'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insee'] = this.insee;
    data['name'] = this.name;
    data['level'] = this.level;
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    data['label'] = this.label;
    data['id'] = this.id;
    data['zip_code'] = this.zipCode;
    return data;
  }
}
