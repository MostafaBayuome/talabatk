
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

    Notifications notification=new Notifications.empty();
    notification.id=model['id'];
    notification.user_id=model['user_id'];
    notification.Type=model['Type'];
    notification.Description=model['Description'];
    notification.seen=model['seen'];
    notification.record_date=model['record_date'];
    notification.record_time=model['record_time'];
    return notification;

  }

}