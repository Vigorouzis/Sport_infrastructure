import 'package:sport_infrastructure/models/organization.dart';

import 'abonement.dart';
import 'location_info.dart';

class Place {
  String id;
  String name;
  String description;
  Organization holderOrganization;
  List<Organization> basedOrganizations;
  bool isFreeVisit;
  List<Abonement> abonements;
  LocationInfo location;
  List<String> categoriesIDs;
  List<String> tagsUIDs;

  Place(
      {this.id,
      this.name,
      this.description,
      this.holderOrganization,
      this.basedOrganizations,
      this.isFreeVisit,
      this.abonements,
      this.location,
      this.categoriesIDs,
      this.tagsUIDs});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      holderOrganization: json['holderOrganization'],
      basedOrganizations: json['basedOrganizations'],
      isFreeVisit: json['isFreeVisit'],
      abonements: json['abonements'],
      location: json['location'],
      categoriesIDs: json['categoriesIDs'],
      tagsUIDs: json['tagsUIDs'],
    );
  }
}
