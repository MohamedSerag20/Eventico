

class Event {
  Event({
    required this.userKey,
    required this.eventName,
    required this.discription,
    required this.story,
    required this.imagesUrl,
    required this.withWhom,
    required this.date,
  });

  String userKey;
  String eventName;
  String discription;
  String story;
  List<dynamic> imagesUrl;
  List<dynamic> withWhom;
  String date;
}
