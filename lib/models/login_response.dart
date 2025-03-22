class LoginResponse {
  final String message;
  final int status;
  final String token;
  final Admin admin;

  LoginResponse({
    required this.message,
    required this.status,
    required this.token,
    required this.admin,
  });

  // Create LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      status: json['status'],
      token: json['token'],
      admin: Admin.fromJson(json['admin']),
    );
  }

  // Convert LoginResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'token': token,
      'admin': admin.toJson(),
    };
  }
}

class Admin {
  final int id;
  final String name;
  final String email;
  final int userGroupId;
  final int? storeId;
  final String createdAt;
  final String updatedAt;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.userGroupId,
    this.storeId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create Admin from JSON
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      userGroupId: json['user_group_id'],
      storeId: json['store_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Convert Admin to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'user_group_id': userGroupId,
      'store_id': storeId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
