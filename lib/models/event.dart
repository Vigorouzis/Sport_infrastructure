class Event {
  final String uid;
  final String name;
  final String description;
  final String dates;
  final String time;
  final int visitorNum;
  final int visitorLimit;
  final String placeUID;
  String creatorUID;
  final bool isPrivate;
  final String eventPassword;
  final bool isOver;

  Event(
      {this.uid,
      this.name,
      this.description,
      this.dates,
      this.time,
      this.visitorNum,
      this.visitorLimit,
      this.placeUID,
      this.creatorUID,
      this.isPrivate,
      this.eventPassword,
      this.isOver});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
      dates: json['dates'],
      time: json['time'],
      visitorNum: json['visitorNum'],
      visitorLimit: json['visitorLimit'],
      placeUID: json['placeUid'],
      creatorUID: json['creatorUid'],
      isPrivate: json['isPrivate'],
      eventPassword: json['eventPassword'],
      isOver: json['isOver'],
    );
  }
}
