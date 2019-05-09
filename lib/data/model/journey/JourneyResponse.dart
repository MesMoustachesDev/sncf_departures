class JourneyResponse {
  List<Links> links;
  List<Journeys> journeys;
  Context context;

  JourneyResponse({this.links, this.journeys, this.context});

  JourneyResponse.fromJson(Map<String, dynamic> json) {
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    if (json['journeys'] != null) {
      journeys = new List<Journeys>();
      json['journeys'].forEach((v) {
        journeys.add(new Journeys.fromJson(v));
      });
    }
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    if (this.journeys != null) {
      data['journeys'] = this.journeys.map((v) => v.toJson()).toList();
    }
    if (this.context != null) {
      data['context'] = this.context.toJson();
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

class Journeys {
  String status;
  Distances distances;
  List<Links> links;
  List<String> tags;
  int nbTransfers;
  Durations durations;
  String arrivalDateTime;
  List<Calendars> calendars;
  String departureDateTime;
  String requestedDateTime;
  Fare fare;
  Co2Emission co2Emission;
  String type;
  int duration;
  List<Sections> sections;

  Journeys(
      {this.status,
      this.distances,
      this.links,
      this.tags,
      this.nbTransfers,
      this.durations,
      this.arrivalDateTime,
      this.calendars,
      this.departureDateTime,
      this.requestedDateTime,
      this.fare,
      this.co2Emission,
      this.type,
      this.duration,
      this.sections});

  Journeys.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    distances = json['distances'] != null
        ? new Distances.fromJson(json['distances'])
        : null;
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    tags = json['tags'].cast<String>();
    nbTransfers = json['nb_transfers'];
    durations = json['durations'] != null
        ? new Durations.fromJson(json['durations'])
        : null;
    arrivalDateTime = json['arrival_date_time'];
    if (json['calendars'] != null) {
      calendars = new List<Calendars>();
      json['calendars'].forEach((v) {
        calendars.add(new Calendars.fromJson(v));
      });
    }
    departureDateTime = json['departure_date_time'];
    requestedDateTime = json['requested_date_time'];
    fare = json['fare'] != null ? new Fare.fromJson(json['fare']) : null;
    co2Emission = json['co2_emission'] != null
        ? new Co2Emission.fromJson(json['co2_emission'])
        : null;
    type = json['type'];
    duration = json['duration'];
    if (json['sections'] != null) {
      sections = new List<Sections>();
      json['sections'].forEach((v) {
        sections.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.distances != null) {
      data['distances'] = this.distances.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['tags'] = this.tags;
    data['nb_transfers'] = this.nbTransfers;
    if (this.durations != null) {
      data['durations'] = this.durations.toJson();
    }
    data['arrival_date_time'] = this.arrivalDateTime;
    if (this.calendars != null) {
      data['calendars'] = this.calendars.map((v) => v.toJson()).toList();
    }
    data['departure_date_time'] = this.departureDateTime;
    data['requested_date_time'] = this.requestedDateTime;
    if (this.fare != null) {
      data['fare'] = this.fare.toJson();
    }
    if (this.co2Emission != null) {
      data['co2_emission'] = this.co2Emission.toJson();
    }
    data['type'] = this.type;
    data['duration'] = this.duration;
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Distances {
  int car;
  int walking;
  int bike;
  int ridesharing;

  Distances({this.car, this.walking, this.bike, this.ridesharing});

  Distances.fromJson(Map<String, dynamic> json) {
    car = json['car'];
    walking = json['walking'];
    bike = json['bike'];
    ridesharing = json['ridesharing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car'] = this.car;
    data['walking'] = this.walking;
    data['bike'] = this.bike;
    data['ridesharing'] = this.ridesharing;
    return data;
  }
}

class Durations {
  int car;
  int walking;
  int total;
  int ridesharing;
  int bike;

  Durations({this.car, this.walking, this.total, this.ridesharing, this.bike});

  Durations.fromJson(Map<String, dynamic> json) {
    car = json['car'];
    walking = json['walking'];
    total = json['total'];
    ridesharing = json['ridesharing'];
    bike = json['bike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car'] = this.car;
    data['walking'] = this.walking;
    data['total'] = this.total;
    data['ridesharing'] = this.ridesharing;
    data['bike'] = this.bike;
    return data;
  }
}

class Calendars {
  List<Exceptions> exceptions;
  List<ActivePeriods> activePeriods;
  WeekPattern weekPattern;

  Calendars({this.exceptions, this.activePeriods, this.weekPattern});

  Calendars.fromJson(Map<String, dynamic> json) {
    if (json['exceptions'] != null) {
      exceptions = new List<Exceptions>();
      json['exceptions'].forEach((v) {
        exceptions.add(new Exceptions.fromJson(v));
      });
    }
    if (json['active_periods'] != null) {
      activePeriods = new List<ActivePeriods>();
      json['active_periods'].forEach((v) {
        activePeriods.add(new ActivePeriods.fromJson(v));
      });
    }
    weekPattern = json['week_pattern'] != null
        ? new WeekPattern.fromJson(json['week_pattern'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exceptions != null) {
      data['exceptions'] = this.exceptions.map((v) => v.toJson()).toList();
    }
    if (this.activePeriods != null) {
      data['active_periods'] =
          this.activePeriods.map((v) => v.toJson()).toList();
    }
    if (this.weekPattern != null) {
      data['week_pattern'] = this.weekPattern.toJson();
    }
    return data;
  }
}

class Exceptions {
  String type;
  String datetime;

  Exceptions({this.type, this.datetime});

  Exceptions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['datetime'] = this.datetime;
    return data;
  }
}

class ActivePeriods {
  String begin;
  String end;

  ActivePeriods({this.begin, this.end});

  ActivePeriods.fromJson(Map<String, dynamic> json) {
    begin = json['begin'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['begin'] = this.begin;
    data['end'] = this.end;
    return data;
  }
}

class WeekPattern {
  bool monday;
  bool tuesday;
  bool friday;
  bool wednesday;
  bool thursday;
  bool sunday;
  bool saturday;

  WeekPattern(
      {this.monday,
      this.tuesday,
      this.friday,
      this.wednesday,
      this.thursday,
      this.sunday,
      this.saturday});

  WeekPattern.fromJson(Map<String, dynamic> json) {
    monday = json['monday'];
    tuesday = json['tuesday'];
    friday = json['friday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    sunday = json['sunday'];
    saturday = json['saturday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['friday'] = this.friday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['sunday'] = this.sunday;
    data['saturday'] = this.saturday;
    return data;
  }
}

class Fare {
  bool found;
  Total total;
  List<Null> links;

  Fare({this.found, this.total, this.links});

  Fare.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['found'] = this.found;
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    return data;
  }
}

class Total {
  String value;

  Total({this.value});

  Total.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class Co2Emission {
  double value;
  String unit;

  Co2Emission({this.value, this.unit});

  Co2Emission.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}

class Sections {
  From from;
  List<Null> links;
  String arrivalDateTime;
  String departureDateTime;
  To to;
  Co2Emission co2Emission;
  DisplayInformation displayInformation;
  int duration;
  String type;
  String id;
  String mode;

  Sections(
      {this.from,
      this.links,
      this.arrivalDateTime,
      this.departureDateTime,
      this.to,
      this.co2Emission,
      this.duration,
      this.type,
      this.id,
      this.mode});

  Sections.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    arrivalDateTime = json['arrival_date_time'];
    departureDateTime = json['departure_date_time'];
    to = json['to'] != null ? new To.fromJson(json['to']) : null;
    co2Emission = json['co2_emission'] != null
        ? new Co2Emission.fromJson(json['co2_emission'])
        : null;
    duration = json['duration'];
    type = json['type'];
    id = json['id'];
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    data['arrival_date_time'] = this.arrivalDateTime;
    data['departure_date_time'] = this.departureDateTime;
    if (this.to != null) {
      data['to'] = this.to.toJson();
    }
    if (this.co2Emission != null) {
      data['co2_emission'] = this.co2Emission.toJson();
    }
    data['duration'] = this.duration;
    data['type'] = this.type;
    data['id'] = this.id;
    data['mode'] = this.mode;
    return data;
  }
}

class DisplayInformations {
  String color;
  String code;

  DisplayInformations({this.ref});

  DisplayInformations.fromJson(Map<String, dynamic> json) {
    ref = json['$ref'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$ref'] = this.ref;
    return data;
  }
}

class From {
  String embeddedType;
  int quality;
  AdministrativeRegion administrativeRegion;
  String name;
  String id;

  From(
      {this.embeddedType,
      this.quality,
      this.administrativeRegion,
      this.name,
      this.id});

  From.fromJson(Map<String, dynamic> json) {
    embeddedType = json['embedded_type'];
    quality = json['quality'];
    administrativeRegion = json['administrative_region'] != null
        ? new AdministrativeRegion.fromJson(json['administrative_region'])
        : null;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embedded_type'] = this.embeddedType;
    data['quality'] = this.quality;
    if (this.administrativeRegion != null) {
      data['administrative_region'] = this.administrativeRegion.toJson();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class AdministrativeRegion {
  String insee;
  String name;
  int level;
  Coord coord;
  String label;
  String id;
  String zipCode;

  AdministrativeRegion(
      {this.insee,
      this.name,
      this.level,
      this.coord,
      this.label,
      this.id,
      this.zipCode});

  AdministrativeRegion.fromJson(Map<String, dynamic> json) {
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

class To {
  String embeddedType;
  StopPoint stopPoint;
  int quality;
  String name;
  String id;

  To({this.embeddedType, this.stopPoint, this.quality, this.name, this.id});

  To.fromJson(Map<String, dynamic> json) {
    embeddedType = json['embedded_type'];
    stopPoint = json['stop_point'] != null
        ? new StopPoint.fromJson(json['stop_point'])
        : null;
    quality = json['quality'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embedded_type'] = this.embeddedType;
    if (this.stopPoint != null) {
      data['stop_point'] = this.stopPoint.toJson();
    }
    data['quality'] = this.quality;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class StopPoint {
  String name;
  List<Null> links;
  Coord coord;
  String label;
  List<Null> equipments;
  List<AdministrativeRegions> administrativeRegions;
  FareZone fareZone;
  String id;
  StopArea stopArea;

  StopPoint(
      {this.name,
      this.links,
      this.coord,
      this.label,
      this.equipments,
      this.administrativeRegions,
      this.fareZone,
      this.id,
      this.stopArea});

  StopPoint.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    label = json['label'];
    if (json['administrative_regions'] != null) {
      administrativeRegions = new List<AdministrativeRegions>();
      json['administrative_regions'].forEach((v) {
        administrativeRegions.add(new AdministrativeRegions.fromJson(v));
      });
    }
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
    data['name'] = this.name;
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
  String timezone;
  String id;

  StopArea(
      {this.codes,
      this.name,
      this.links,
      this.coord,
      this.label,
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
    timezone = json['timezone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.codes != null) {
      data['codes'] = this.codes.map((v) => v.toJson()).toList();
    }
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    data['label'] = this.label;
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

class Context {
  String timezone;
  String currentDatetime;
  CarDirectPath carDirectPath;

  Context({this.timezone, this.currentDatetime, this.carDirectPath});

  Context.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'];
    currentDatetime = json['current_datetime'];
    carDirectPath = json['car_direct_path'] != null
        ? new CarDirectPath.fromJson(json['car_direct_path'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timezone'] = this.timezone;
    data['current_datetime'] = this.currentDatetime;
    if (this.carDirectPath != null) {
      data['car_direct_path'] = this.carDirectPath.toJson();
    }
    return data;
  }
}

class CarDirectPath {
  Co2Emission co2Emission;

  CarDirectPath({this.co2Emission});

  CarDirectPath.fromJson(Map<String, dynamic> json) {
    co2Emission = json['co2_emission'] != null
        ? new Co2Emission.fromJson(json['co2_emission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.co2Emission != null) {
      data['co2_emission'] = this.co2Emission.toJson();
    }
    return data;
  }
}
