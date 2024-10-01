class Users {
  int id;
  String firstName;
  String lastName;
  String maidenName;
  int age;
  String gender;
  String email;
  String phone;
  String username;
  String password;
  String birthDate;
  String image;
  String bloodGroup;
  num height;
  double weight;
  String eyeColor;
  Map hair;
  String domain;
  String ip;
  Map address;
  String macAddress;
  String university;
  Map bank;
  Map company;
  String ein;
  String ssn;
  String userAgent;

//<editor-fold desc="Data Methods">
  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.domain,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
  });


  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      maidenName: map['maidenName'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      birthDate: map['birthDate'] as String,
      image: map['image'] as String,
      bloodGroup: map['bloodGroup'] as String,
      height: map['height'] as num,
      weight: map['weight'] as double,
      eyeColor: map['eyeColor'] as String,
      hair: map['hair'] as Map,
      domain: map['domain'] as String,
      ip: map['ip'] as String,
      address: map['address'] as Map,
      macAddress: map['macAddress'] as String,
      university: map['university'] as String,
      bank: map['bank'] as Map,
      company: map['company'] as Map,
      ein: map['ein'] as String,
      ssn: map['ssn'] as String,
      userAgent: map['userAgent'] as String,
    );
  } //

//</editor-fold>
}