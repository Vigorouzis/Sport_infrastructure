import 'package:flutter/material.dart';

class Place {
  final String uid;
  final String name;
  final String buildingName;
  final String buildingType;
  final String description;
  final String address;
  final String city;
  final String openingHours;
  final String postIndex;
  final String webSite;
  final String phone;
  final String email;
  final String facebook;
  final String instagram;
  final String twitter;
  final String vk;
  final double latitude;
  final double longitude;

  Place({
    @required this.uid,
    @required this.name,
    @required this.buildingName,
    @required this.buildingType,
    @required this.description,
    @required this.address,
    @required this.city,
    @required this.openingHours,
    @required this.postIndex,
    @required this.webSite,
    @required this.phone,
    @required this.email,
    this.facebook,
    this.instagram,
    this.twitter,
    this.vk,
    @required this.latitude,
    @required this.longitude,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      uid: json['uid'],
      name: json['name'],
      buildingName: json['buildingName'],
      buildingType: json['buildingType'],
      description: json['description'],
      address: json['address'],
      city: json['city'],
      openingHours: json['openingHours'],
      postIndex: json['postIndex'],
      webSite: json['webSite'],
      phone: json['phone'],
      email: json['email'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      vk: json['vk'],
      latitude:json['lat'],
      longitude:json['lon'],
    );
  }
}
