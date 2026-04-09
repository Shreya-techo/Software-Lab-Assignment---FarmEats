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

    print("LOGIN BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (data["success"] == true || data["success"] == "true") {
      return data["token"];
    }

    if (data["message"] != null &&
        data["message"].toString().toLowerCase().contains("success")) {
      return data["token"];
    }

    print("LOGIN ERROR: ${data["message"]}");
    return null;
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
    request.fields['zip_code'] = zipcode;

    request.fields['business_hours'] = jsonEncode(businessHours);

    var response = await request.send();

    var responseData = await http.Response.fromStream(response);
    final data = jsonDecode(responseData.body);

    print("REGISTER BODY: ${responseData.body}");

    return data["success"] == true || data["success"] == "true";
  }

  static Future<bool> sendOtp(String phone) async {
    final url = Uri.parse("https://sowlab.com/assignment/user/forgot-password");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobile": phone}),
    );

    final data = jsonDecode(response.body);

    print("SEND OTP BODY: ${response.body}");

    return data["success"] == true || data["success"] == "true";
  }

  static Future<bool> verifyOtp(String otp) async {
    final url = Uri.parse("https://sowlab.com/assignment/user/verify-otp");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"otp": otp}),
    );

    final data = jsonDecode(response.body);

    print("VERIFY OTP BODY: ${response.body}");

    return data["success"] == true || data["success"] == "true";
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

    final data = jsonDecode(response.body);

    print("RESET PASSWORD BODY: ${response.body}");

    return data["success"] == true || data["success"] == "true";
  }
}
