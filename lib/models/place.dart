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
}
