class DeparturesResponse {
  Pagination pagination;
  List<Links> links;
  List<Null> disruptions;
  List<Null> notes;
  List<Null> feedPublishers;
  List<Departures> departures;
  Context context;
  List<Null> exceptions;

  DeparturesResponse(
      {this.pagination,
        this.links,
        this.disruptions,
        this.notes,
        this.feedPublishers,
        this.departures,
        this.context,
        this.exceptions});

  DeparturesResponse.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    if (json['departures'] != null) {
      departures = new List<Departures>();
      json['departures'].forEach((v) {
        departures.add(new Departures.fromJson(v));
      });
    }
    context =
    json['context'] != null ? new Context.fromJson(json['context']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    if (this.departures != null) {
      data['departures'] = this.departures.map((v) => v.toJson()).toList();
    }
    if (this.context != null) {
      data['context'] = this.context.toJson();
    }
    return data;
  }
}

class Pagination {
  int startPage;
  int itemsOnPage;
  int itemsPerPage;
  int totalResult;

  Pagination(
      {this.startPage, this.itemsOnPage, this.itemsPerPage, this.totalResult});

  Pagination.fromJson(Map<String, dynamic> json) {
    startPage = json['start_page'];
    itemsOnPage = json['items_on_page'];
    itemsPerPage = json['items_per_page'];
    totalResult = json['total_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_page'] = this.startPage;
    data['items_on_page'] = this.itemsOnPage;
    data['items_per_page'] = this.itemsPerPage;
    data['total_result'] = this.totalResult;
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

class Departures {
  DisplayInformations displayInformations;
  StopPoint stopPoint;
  Route route;
  List<Links> links;
  StopDateTime stopDateTime;

  Departures(
      {this.displayInformations,
        this.stopPoint,
        this.route,
        this.links,
        this.stopDateTime});

  Departures.fromJson(Map<String, dynamic> json) {
    displayInformations = json['display_informations'] != null
        ? new DisplayInformations.fromJson(json['display_informations'])
        : null;
    stopPoint = json['stop_point'] != null
        ? new StopPoint.fromJson(json['stop_point'])
        : null;
    route = json['route'] != null ? new Route.fromJson(json['route']) : null;
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    stopDateTime = json['stop_date_time'] != null
        ? new StopDateTime.fromJson(json['stop_date_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.displayInformations != null) {
      data['display_informations'] = this.displayInformations.toJson();
    }
    if (this.stopPoint != null) {
      data['stop_point'] = this.stopPoint.toJson();
    }
    if (this.route != null) {
      data['route'] = this.route.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    if (this.stopDateTime != null) {
      data['stop_date_time'] = this.stopDateTime.toJson();
    }
    return data;
  }
}

class DisplayInformations {
  String direction;
  String code;
  String network;
  List<Null> links;
  String color;
  String name;
  String physicalMode;
  String headsign;
  String label;
  List<Null> equipments;
  String textColor;
  String commercialMode;
  String description;

  DisplayInformations(
      {this.direction,
        this.code,
        this.network,
        this.links,
        this.color,
        this.name,
        this.physicalMode,
        this.headsign,
        this.label,
        this.equipments,
        this.textColor,
        this.commercialMode,
        this.description});

  DisplayInformations.fromJson(Map<String, dynamic> json) {
    direction = json['direction'];
    code = json['code'];
    network = json['network'];
    color = json['color'];
    name = json['name'];
    physicalMode = json['physical_mode'];
    headsign = json['headsign'];
    label = json['label'];
    textColor = json['text_color'];
    commercialMode = json['commercial_mode'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['direction'] = this.direction;
    data['code'] = this.code;
    data['network'] = this.network;
    data['color'] = this.color;
    data['name'] = this.name;
    data['physical_mode'] = this.physicalMode;
    data['headsign'] = this.headsign;
    data['label'] = this.label;
    data['text_color'] = this.textColor;
    data['commercial_mode'] = this.commercialMode;
    data['description'] = this.description;
    return data;
  }
}

class StopPoint {
  List<CommercialModes> commercialModes;
  String name;
  List<Null> links;
  List<PhysicalModes> physicalModes;
  Coord coord;
  String label;
  List<Null> equipments;
  List<AdministrativeRegions> administrativeRegions;
  FareZone fareZone;
  String id;
  StopArea stopArea;

  StopPoint(
      {this.commercialModes,
        this.name,
        this.links,
        this.physicalModes,
        this.coord,
        this.label,
        this.equipments,
        this.administrativeRegions,
        this.fareZone,
        this.id,
        this.stopArea});

  StopPoint.fromJson(Map<String, dynamic> json) {
    if (json['commercial_modes'] != null) {
      commercialModes = new List<CommercialModes>();
      json['commercial_modes'].forEach((v) {
        commercialModes.add(new CommercialModes.fromJson(v));
      });
    }
    name = json['name'];
    if (json['links'] != null) {
      links = new List<Null>();
    }
    if (json['physical_modes'] != null) {
      physicalModes = new List<PhysicalModes>();
      json['physical_modes'].forEach((v) {
        physicalModes.add(new PhysicalModes.fromJson(v));
      });
    }
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    label = json['label'];
    fareZone = json['fare_zone'] != null
        ? new FareZone.fromJson(json['fare_zone'])
        : null;
    id = json['id'];
    stopArea = json['stop_area'] != null
        ? new StopArea.fromJson(json['stop_area'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commercialModes != null) {
      data['commercial_modes'] =
          this.commercialModes.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.physicalModes != null) {
      data['physical_modes'] =
          this.physicalModes.map((v) => v.toJson()).toList();
    }
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    data['label'] = this.label;
    if (this.administrativeRegions != null) {
      data['administrative_regions'] =
          this.administrativeRegions.map((v) => v.toJson()).toList();
    }
    if (this.fareZone != null) {
      data['fare_zone'] = this.fareZone.toJson();
    }
    data['id'] = this.id;
    if (this.stopArea != null) {
      data['stop_area'] = this.stopArea.toJson();
    }
    return data;
  }
}

class CommercialModes {
  String id;
  String name;

  CommercialModes({this.id, this.name});

  CommercialModes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class PhysicalModes {
  String id;
  String name;

  PhysicalModes({this.id, this.name});

  PhysicalModes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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

class FareZone {
  String name;

  FareZone({this.name});

  FareZone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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
    if (json['links'] != null) {
      links = new List<Null>();
    }
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

class Route {
  Direction direction;
  String name;
  List<Null> links;
  List<PhysicalModes> physicalModes;
  String isFrequence;
  Geojson geojson;
  String directionType;
  Line line;
  String id;

  Route(
      {this.direction,
        this.name,
        this.links,
        this.physicalModes,
        this.isFrequence,
        this.geojson,
        this.directionType,
        this.line,
        this.id});

  Route.fromJson(Map<String, dynamic> json) {
    direction = json['direction'] != null
        ? new Direction.fromJson(json['direction'])
        : null;
    name = json['name'];
    if (json['physical_modes'] != null) {
      physicalModes = new List<PhysicalModes>();
      json['physical_modes'].forEach((v) {
        physicalModes.add(new PhysicalModes.fromJson(v));
      });
    }
    isFrequence = json['is_frequence'];
    geojson =
    json['geojson'] != null ? new Geojson.fromJson(json['geojson']) : null;
    directionType = json['direction_type'];
    line = json['line'] != null ? new Line.fromJson(json['line']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.direction != null) {
      data['direction'] = this.direction.toJson();
    }
    data['name'] = this.name;
    if (this.physicalModes != null) {
      data['physical_modes'] =
          this.physicalModes.map((v) => v.toJson()).toList();
    }
    data['is_frequence'] = this.isFrequence;
    if (this.geojson != null) {
      data['geojson'] = this.geojson.toJson();
    }
    data['direction_type'] = this.directionType;
    if (this.line != null) {
      data['line'] = this.line.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Direction {
  String embeddedType;
  StopArea stopArea;
  int quality;
  String name;
  String id;

  Direction(
      {this.embeddedType, this.stopArea, this.quality, this.name, this.id});

  Direction.fromJson(Map<String, dynamic> json) {
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


class Geojson {
  String type;
  List<Null> coordinates;

  Geojson({this.type, this.coordinates});

  Geojson.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class Line {
  String code;
  String name;
  List<Null> links;
  String color;
  Geojson geojson;
  String textColor;
  List<Null> codes;
  String closingTime;
  String openingTime;
  String id;

  Line(
      {this.code,
        this.name,
        this.links,
        this.color,
        this.geojson,
        this.textColor,
        this.codes,
        this.closingTime,
        this.openingTime,
        this.id});

  Line.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    color = json['color'];
    geojson =
    json['geojson'] != null ? new Geojson.fromJson(json['geojson']) : null;
    textColor = json['text_color'];
    closingTime = json['closing_time'];
    openingTime = json['opening_time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['color'] = this.color;
    if (this.geojson != null) {
      data['geojson'] = this.geojson.toJson();
    }
    data['text_color'] = this.textColor;
    data['closing_time'] = this.closingTime;
    data['opening_time'] = this.openingTime;
    data['id'] = this.id;
    return data;
  }
}


class StopDateTime {
  List<Null> links;
  String arrivalDateTime;
  List<Null> additionalInformations;
  String departureDateTime;
  String baseArrivalDateTime;
  String baseDepartureDateTime;
  String dataFreshness;

  StopDateTime(
      {this.links,
        this.arrivalDateTime,
        this.additionalInformations,
        this.departureDateTime,
        this.baseArrivalDateTime,
        this.baseDepartureDateTime,
        this.dataFreshness});

  StopDateTime.fromJson(Map<String, dynamic> json) {
    arrivalDateTime = json['arrival_date_time'];
    departureDateTime = json['departure_date_time'];
    baseArrivalDateTime = json['base_arrival_date_time'];
    baseDepartureDateTime = json['base_departure_date_time'];
    dataFreshness = json['data_freshness'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arrival_date_time'] = this.arrivalDateTime;
    data['departure_date_time'] = this.departureDateTime;
    data['base_arrival_date_time'] = this.baseArrivalDateTime;
    data['base_departure_date_time'] = this.baseDepartureDateTime;
    data['data_freshness'] = this.dataFreshness;
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