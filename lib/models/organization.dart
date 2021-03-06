class Organization {
  final String uid;
  final String name;
  final String description;

  Organization({this.uid, this.name, this.description});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
    );
  }
}
