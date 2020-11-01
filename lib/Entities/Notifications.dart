
class Notifications {
  int id;
  int user_id;
  String Type;
  String Description;
  bool seen;
  String record_date;
  String record_time;
  Notifications.empty();
  static fromJson(Map model) {
    Notifications Not=new Notifications.empty();
    Not.id=model['id'];
    Not.user_id=model['user_id'];
    Not.Type=model['Type'];
    Not.Description=model['Description'];
    Not.seen=model['seen'];
    Not.record_date=model['record_date'];
    Not.record_time=model['record_time'];

    return Not;
  }

}