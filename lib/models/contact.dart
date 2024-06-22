class Contact {
  String id;
  String firstName;
  String lastName;
  String email;
  String? phone;
  String? dob;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.dob,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      dob: json['dob'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'dob': dob,
    };
  }
}
