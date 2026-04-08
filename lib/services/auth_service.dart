import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<String?> login(String email, String password) async {
    final url = Uri.parse("https://sowlab.com/assignment/user/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "role": "farmer",
        "device_token": "test_token",
        "type": "email",
        "social_id": "test_id",
      }),
    );

    print("LOGIN STATUS: ${response.statusCode}");
    print("LOGIN BODY: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data["token"];
    } else {
      return null;
    }
  }

  static Future<bool> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String businessName,
    required String informalName,
    required String address,
    required String city,
    required String zipcode,
    required String document,
    required Map<String, dynamic> businessHours,
  }) async {
    var uri = Uri.parse("https://sowlab.com/assignment/user/register");

    var request = http.MultipartRequest("POST", uri);

    request.fields['full_name'] = fullName;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['password'] = password;
    request.fields['role'] = "farmer";

    request.fields['business_name'] = businessName;
    request.fields['informal_name'] = informalName;
    request.fields['address'] = address;
    request.fields['city'] = city;
    request.fields['state'] = "Delhi";
    request.fields['zip_code'] = "110001";

    request.fields['business_hours'] = jsonEncode(businessHours);

    var response = await request.send();

    print("REGISTER STATUS: ${response.statusCode}");

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> sendOtp(String phone) async {
    final url = Uri.parse("https://sowlab.com/assignment/user/forgot-password");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": phone}),
    );

    print("SEND OTP STATUS: ${response.statusCode}");
    print("SEND OTP BODY: ${response.body}");

    return response.statusCode == 200;
  }

  static Future<bool> verifyOtp(String otp) async {
    final url = Uri.parse("https://sowlab.com/assignment/user/verify-otp");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"otp": otp}),
    );

    print("VERIFY OTP STATUS: ${response.statusCode}");
    print("VERIFY OTP BODY: ${response.body}");

    return response.statusCode == 200;
  }

  static Future<bool> resetPassword(
    String phone,
    String otp,
    String password,
  ) async {
    final url = Uri.parse("https://sowlab.com/assignment/user/reset-password");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": phone, "otp": otp, "password": password}),
    );

    print("RESET PASSWORD STATUS: ${response.statusCode}");
    print("RESET PASSWORD BODY: ${response.body}");

    return response.statusCode == 200;
  }
}
