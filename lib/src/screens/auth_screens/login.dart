import 'package:app/src/screens/home.dart';
import 'package:app/src/services/authService.dart';
import 'package:app/src/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:app/src/widgets/custom_btn.dart';
import 'package:app/src/utils/constants/colors.dart';
import 'package:app/src/utils/regex/regex.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late bool _isObscured;
  String _emailError = '';
  String _passwordError = '';
  //AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isObscured = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  child:
                      Image.asset('assets/logo.png', width: 200, height: 200),
                ),
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'البريد الإلكتروني ',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _emailError = 'البريد الإلكتروني مطلوب';
                                } else if (!emailRegEx.hasMatch(value)) {
                                  _emailError =
                                      'صيغة البريد الإلكتروني غير صحيحة';
                                } else {
                                  _emailError = "";
                                }
                              });
                            },
                          ),
                          if (_emailError.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                _emailError,
                                style: const TextStyle(
                                    color: AppColors.primaryBlue, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'كلمة المرور',
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscured,
                            suffixIcon: IconButton(
                              icon: _isObscured
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _passwordError = 'كلمة المرور مطلوبة';
                                } else {
                                  _passwordError = "";
                                }
                              });
                            },
                          ),
                          if (_passwordError.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                _passwordError,
                                style: const TextStyle(
                                    color: AppColors.primaryBlue, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        btnText: 'تسجيل الدخول',
                        onTap: () async {
                          await AuthService().loginUser(
                            context,
                            _emailController.text,
                            _passwordController.text,
                          );
                        }, /*  onTap: () async {
                          try {
                            // Call the AuthService login function
                            final result = await _authService.loginUser(
                              context,
                              _emailController.text,
                              _passwordController.text,
                            );
                            

                            if (result['success']) {
                              print(
                                  "تم تسجيل الدخول بنجاح، الرمز: ${result['token']}");

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            } else {
                              // Show failure notification in Arabic
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(result['message'] ??
                                        "فشل تسجيل الدخول")),
                              );
                            }
                          } catch (e) {
                            // Show error message if an exception occurred, also in Arabic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("حدث خطأ أثناء تسجيل الدخول: $e")),
                            );
                          }
                        },*/
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لديك حساب؟ ',
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Navigate to create account screen");
                            },
                            child: Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
