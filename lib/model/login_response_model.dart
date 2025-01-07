class LoginResponseModel {
  final String token;
  final Parent parent;
  final List<Customer> customers;

  LoginResponseModel({
    required this.token,
    required this.parent,
    required this.customers,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    var customerList = json['customers'] as List;
    List<Customer> customers =
        customerList.map((i) => Customer.fromJson(i)).toList();

    return LoginResponseModel(
      token: json['token'],
      parent: Parent.fromJson(json['parent']),
      customers: customers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'parent': parent.toJson(),
      'customers': customers.map((e) => e.toJson()).toList(),
    };
  }
}

class Parent {
  final String loginId;
  final String firstName;
  final String lastName;
  final String email;
  final String contact;
  final String status;
  final String verificationStatus;
  final String childStatus;

  Parent({
    required this.loginId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.status,
    required this.childStatus,
    required this.verificationStatus,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      loginId: json['login_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      contact: json['contact'],
      status: json['status'],
      verificationStatus: json['verification_status'],
      childStatus: json['childStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login_id': loginId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'contact': contact,
      'status': status,
      'verification_status': verificationStatus,
      'childStatus': childStatus,
    };
  }
}

class Customer {
  final String childId;

  Customer({
    required this.childId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      childId: json['child_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
    };
  }
}
