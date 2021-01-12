class LocationInfo {
  String address;
  Coordinates coordinates;
  OpeningHours openingHours;

  LocationInfo(this.address, this.coordinates, this.openingHours);
}

class Coordinates {
  double lat;
  double lng;

  Coordinates(this.lat, this.lng);
}

class OpeningHours {
  bool openNow;
  List<String> weekdayText;

  OpeningHours(this.openNow, this.weekdayText);
}
