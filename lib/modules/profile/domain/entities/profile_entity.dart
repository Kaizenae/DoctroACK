/* {
{
    "jsonrpc": "2.0",
    "id": null,
    "result": {
        "status": 200,
        "message": "Success",
        "customer": {
            "id": 43,
            "image_url": false,
            "name": "JK",
            "email": "JK",
            "phone": "00235165"
        }
    }
}
}*/
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final ResultEntity resultEntity;

  const ProfileEntity({required this.resultEntity});

  @override
  List<Object> get props => [resultEntity];
}

class ResultEntity extends Equatable {
  final int status;
  final String message;
  final ResponseEntity response;

  const ResultEntity(
      {required this.status, required this.response, required this.message});

  @override
  List<Object> get props => [status, response, message];
}

class ResponseEntity extends Equatable {
  final int id;
  final String name;
  final String mobilePhone;
  final String email;
  final String imageUrl;

  const ResponseEntity({
    required this.id,
    required this.name,
    required this.mobilePhone,
    required this.email,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, imageUrl, name, mobilePhone, email];
}
