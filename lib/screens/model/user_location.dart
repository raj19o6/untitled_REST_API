class UserLocation {
  final String city;
  final String state;
  final String country;
  final String postalcode;
  final LocationStreet street;
  final LocationCordinates cordinated;
  final LocationTimezone timezone;
  UserLocation(
      {required this.city,
      required this.state,
      required this.country,
      required this.postalcode,
      required this.street,
      required this.cordinated,
      required this.timezone});

  factory UserLocation.fromMap(Map<String, dynamic> json) {
    final coordinates = LocationCordinates.fromMap(json['coordinates']);
    final street = LocationStreet.fromMap(json['street']);
    final timezone = LocationTimezone.fromMap(json['timezone']);
    //
    return UserLocation(
        city: json['city'],
        state: json['state'],
        country: json['country'],
        postalcode:
            json['postalcode'].toString(), //some postal code are in string
        street: street,
        cordinated: coordinates,
        timezone: timezone);
  }
}

class LocationStreet {
  final int number;
  final String name;
  LocationStreet({
    required this.name,
    required this.number,
  });

  factory LocationStreet.fromMap(Map<String, dynamic> json) {
    return LocationStreet(name: json['name'], number: json['number']);
  }
}

class LocationTimezone {
  final String offset;
  final String description;
  LocationTimezone({required this.description, required this.offset});
  factory LocationTimezone.fromMap(Map<String, dynamic> json) {
    return LocationTimezone(
        description: json['description'], offset: json['offset']);
  }
}

class LocationCordinates {
  final String longitude;
  final String latitude;
  LocationCordinates({required this.latitude, required this.longitude});

  factory LocationCordinates.fromMap(Map<String, dynamic> json) {
    return LocationCordinates(
        latitude: json['latitude'], longitude: json['longitude']);
  }
}

