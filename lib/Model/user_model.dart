class Users {
  late String firstName;
  late String lastName;
  late num phoneNumber;
  late String email;
  late String address;

  Users(this.firstName, this.lastName, this.phoneNumber, this.email,
      this.address);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
    };
    return map;
  }

  Users.fromMap(Map<String, dynamic> map) {
    firstName = map['firstName'];
    lastName = map['lastName'];
    phoneNumber = map['phoneNumber'];
    email = map['email'];
    address = map['address'];
  }
}
