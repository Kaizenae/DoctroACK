class NotificationsModel {
  FirstResponseModel result = FirstResponseModel();
  NotificationsModel();
  NotificationsModel.fromJson(Map<String, dynamic> json) {
    result = FirstResponseModel.fromJson(json["result"]);
  }
}

class FirstResponseModel {
  ResultsModel responseModel = ResultsModel();
  FirstResponseModel();
  FirstResponseModel.fromJson(Map<String, dynamic> json) {
    responseModel = ResultsModel.fromJson(json["result"]);
  }
}

class ResultsModel {
  List<ResponseModel> responseModel = [];
  ResultsModel();
  ResultsModel.fromJson(Map<String, dynamic> json) {
    json["result"].forEach((element) {
      responseModel.add(ResponseModel.fromJson(element));
    });
  }
}

class ResponseModel {
  late int id;
  late String title;
  late String description;
  late String image;
  late String date;
  late String time;

  ResponseModel();
  ResponseModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    image = json["image"];
    date = json["date"];
    time = json["time"];
  }
}
