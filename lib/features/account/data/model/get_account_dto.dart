import 'package:nti_graduation_project/features/account/domain/entities/get_account_entity.dart';

class GetProfileDto {
  MessageDto? message;

  GetProfileDto({this.message});

  GetProfileDto.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null
        ? MessageDto.fromJson(json['message'])
        : null;
  }
  GetProfileEntity toEntity() {
    return GetProfileEntity(
      message: MessageEntity(
        address: message?.address ?? "",
        email: message?.email ?? "",
        image: message?.image ?? "",
        phone: message?.phone ?? "",
        name: message?.name ?? "",
      ),
    );
  }
}

class MessageDto {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? image;

  MessageDto({this.name, this.phone, this.email, this.address, this.image});

  MessageDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    image = json['image'];
  }
}
