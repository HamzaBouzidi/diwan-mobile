import 'dart:convert';
import 'package:app/src/providers/userProvider.dart';
import 'package:app/src/screens/auth_screens/login.dart';
import 'package:app/src/screens/home.dart';
import 'package:app/src/utils/constants/urls.dart';
import 'package:app/src/utils/helpers/dialog_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> registerUser(
      BuildContext context,
      String userName,
      String userEmail,
      String password,
      String userRefEmp,
      String userPhone) async {
    try {
      final url = Uri.parse('$baseUrl/register');
      //final url = Uri.parse('http://192.168.1.104:3000/api/register');

      // Prepare request body
      final body = json.encode({
        'user_name': userName,
        'user_email': userEmail,
        'password': password,
        'user_ref_emp': userRefEmp,
        'user_phone': userPhone,
      });

      // Send POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Handle different status codes
      if (response.statusCode == 201) {
        // Registration success
        DialogHelper.showDialogWithIcon(
          context,
          'تم التسجيل بنجاح',
          'تم إنشاء حسابك بنجاح، الرجاء انتظار موافقة الإدارة.',
          true, // Show green tick
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginScreen()), // Redirect to login screen
          ),
        );
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        DialogHelper.showDialogWithIcon(
          context,
          'خطأ في التسجيل',
          responseData['message'] ??
              'حدث خطأ أثناء التسجيل. يرجى المحاولة مرة أخرى.',
          false, // Show red cross
        );
      } else if (response.statusCode == 500) {
        DialogHelper.showDialogWithIcon(
          context,
          'خطأ داخلي في الخادم',
          'حدث خطأ داخلي في الخادم. يرجى المحاولة لاحقًا.',
          false, // Show red cross
        );
      } else {
        DialogHelper.showDialogWithIcon(
          context,
          'خطأ غير معروف',
          'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.',
          false, // Show red cross
        );
      }
    } catch (error) {
      print('Error during registration: $error');
      DialogHelper.showDialogWithIcon(
        context,
        'خطأ في الاتصال',
        'حدث خطأ أثناء الاتصال بالخادم. يرجى التحقق من الاتصال الخاص بك والمحاولة مرة أخرى.',
        false, // Show red cross
      );
    }
  }

  // Login function
  Future<void> loginUser(
      BuildContext context, String userEmail, String password) async {
    try {
      // API URL for login (replace with your actual endpoint)
      //final url = Uri.parse('http://192.168.1.104:3000/api/login');
      final url = Uri.parse('$baseUrl/login');

      // Prepare request body
      final body = json.encode({
        'user_email': userEmail,
        'password': password,
      });

      // Send POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Handle different status codes
      if (response.statusCode == 200) {
        // Login successful, extract the token and user info
        final responseData = json.decode(response.body);
        final token = responseData['token'];

        // Decode JWT token using jwt_decoder
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        String userName = decodedToken['name'];
        String userEmail = decodedToken['email'];
        String userRefEmp = decodedToken['ref_emp'];

        // Save the token and user info in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userName', userName);
        await prefs.setString('userEmail', userEmail);
        await prefs.setString('userRefEmp', userRefEmp);

        // Update the user provider
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userName, userEmail, userRefEmp);

        // Show success dialog and navigate to home or dashboard screen
        DialogHelper.showDialogWithIcon(
          context,
          'تسجيل الدخول ناجح',
          'مرحبًا $userName، تم تسجيل الدخول بنجاح!',
          true, // Show green tick
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home()), // Navigate to your home or dashboard screen
            );
          },
        );
      } else if (response.statusCode == 404) {
        DialogHelper.showDialogWithIcon(
          context,
          'خطأ',
          'المستخدم غير موجود',
          false, // Show red cross
        );
      } else if (response.statusCode == 401) {
        DialogHelper.showDialogWithIcon(
          context,
          'خطأ في تسجيل الدخول',
          'كلمة المرور غير صحيحة',
          false, // Show red cross
        );
      } else if (response.statusCode == 403) {
        DialogHelper.showDialogWithIcon(
          context,
          'الحساب غير نشط',
          'حسابك غير نشط، يرجى التواصل مع الإدارة',
          false, // Show red cross
        );
      } else {
        DialogHelper.showDialogWithIcon(
          context,
          'خطأ غير معروف',
          'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.',
          false, // Show red cross
        );
      }
    } catch (error) {
      print('Error during login: $error');
      DialogHelper.showDialogWithIcon(
        context,
        'خطأ في الاتصال',
        'حدث خطأ أثناء الاتصال بالخادم. يرجى التحقق من الاتصال الخاص بك والمحاولة مرة أخرى.',
        false, // Show red cross
      );
    }
  }
}
