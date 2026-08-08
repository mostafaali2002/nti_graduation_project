import 'package:nti_graduation_project/features/account/domain/entities/account_entity.dart';

class ProfileDto {
  String? name;
  String? phone;
  String? email;
  String? image;
  String? address;

  ProfileDto({this.name, this.phone, this.email, this.image, this.address});

  ProfileEntity toEntity() {
    return ProfileEntity(
      email: email ?? '',
      image: image ?? '',
      name: name ?? '',
      phone: phone ?? '',
      address: address ?? '',
    );
  }

  ProfileDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['address'] = address;

    return data;
  }
}
