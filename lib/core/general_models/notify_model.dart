class NotifyModel {
  final int id;
  final String title;
  final String body;
  final String time;

  NotifyModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'time': time,
    };
  }

  factory NotifyModel.fromMap(Map<String, dynamic> map) {
    return NotifyModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      time: map['time'],
    );
  }
}
