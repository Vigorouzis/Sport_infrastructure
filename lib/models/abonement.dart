class Abonement {
  String id;
  String name;
  String description;
  String price;
  String activateTime;
  List<String> placesUIDs;
  List<String> categoriesIDs;

  Abonement(this.id, this.name, this.description, this.price, this.activateTime,
      this.placesUIDs, this.categoriesIDs);
}
