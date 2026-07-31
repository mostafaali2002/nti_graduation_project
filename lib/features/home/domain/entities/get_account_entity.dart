class GetProfileEntity {
  MessageEntity? message;

  GetProfileEntity({this.message});
}

class MessageEntity {
  String name;
  String phone;
  String email;
  String address;
  String image;

  MessageEntity({
    this.name = "",
    this.phone = "",
    this.email = "",
    this.address = "",
    this.image = "",
  });
}
