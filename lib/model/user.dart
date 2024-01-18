class UserModel {
  String? name;
  String? id;
  String? phone;
  String? wifeEmail;
  String? husbandEmail;
  String? type;

  UserModel(
      {this.name,
      this.wifeEmail,
      this.id,
      this.husbandEmail,
      this.phone,});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
        'wifeEmail': wifeEmail,
        'husbandEmail': husbandEmail,
      };
}