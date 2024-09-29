import 'package:app/src/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:app/src/widgets/custom_text_field.dart';
import 'package:app/src/widgets/custom_btn.dart';
import 'package:app/src/utils/constants/colors.dart';
import 'package:app/src/utils/regex/regex.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  late final TextEditingController _employeeIdController;

  late bool _isObscured;
  String _usernameError = '';
  String _emailError = '';
  String _passwordError = '';
  String _phoneError = '';
  String _employeeIdError = '';

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _employeeIdController = TextEditingController();
    _isObscured = true;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _employeeIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  child: Image.asset('assets/logo.png',
                      width: size.width * 0.4, height: size.width * 0.4),
                ),
                Text(
                  'إنشاء حساب',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: size.width * 0.06,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  padding: EdgeInsets.all(size.width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // User Name Field with Icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _usernameController,
                            hintText: 'اسم المستخدم',
                            keyboardType: TextInputType.text,
                            prefixIcon: Icon(Icons.person,
                                color: AppColors.primaryBlue), // Icon color
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _usernameError = 'اسم المستخدم مطلوب';
                                } else {
                                  _usernameError = "";
                                }
                              });
                            },
                          ),
                          if (_usernameError.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                _usernameError,
                                style: const TextStyle(
                                    color: AppColors.primaryBlue, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Email Field with Icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'البريد الإلكتروني',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email,
                                color: AppColors.primaryBlue), // Icon color
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

                      // Phone Number Field with Icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _phoneController,
                            hintText: 'رقم الهاتف',
                            keyboardType: TextInputType.phone,
                            prefixIcon: Icon(Icons.phone,
                                color: AppColors.primaryBlue), // Icon color
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _phoneError = 'رقم الهاتف مطلوب';
                                } else if (!phoneRegEx.hasMatch(value)) {
                                  _phoneError = 'صيغة رقم الهاتف غير صحيحة';
                                } else {
                                  _phoneError = "";
                                }
                              });
                            },
                          ),
                          if (_phoneError.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                _phoneError,
                                style: const TextStyle(
                                    color: AppColors.primaryBlue, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Employee ID (المعرف الوظيفي) with Icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _employeeIdController,
                            hintText: 'المعرف الوظيفي',
                            keyboardType: TextInputType.number,
                            prefixIcon: Icon(Icons.badge,
                                color: AppColors.primaryBlue), // Icon color
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _employeeIdError = 'المعرف الوظيفي مطلوب';
                                } else if (!RegExp(r'^[0-9]+$')
                                    .hasMatch(value)) {
                                  _employeeIdError =
                                      'المعرف الوظيفي يجب أن يكون أرقامًا فقط';
                                } else {
                                  _employeeIdError = "";
                                }
                              });
                            },
                          ),
                          if (_employeeIdError.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                _employeeIdError,
                                style: const TextStyle(
                                    color: AppColors.primaryBlue, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Password Field with Icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'كلمة المرور',
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscured,
                            prefixIcon: Icon(Icons.lock,
                                color: AppColors.primaryBlue), // Icon color
                            suffixIcon: IconButton(
                              icon: _isObscured
                                  ? Icon(Icons.visibility,
                                      color:
                                          AppColors.primaryBlue) // Icon color
                                  : Icon(Icons.visibility_off,
                                      color:
                                          AppColors.primaryBlue), // Icon color
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
                                } else if (!passwordRegEx.hasMatch(value)) {
                                  _passwordError =
                                      'كلمة المرور يجب أن تحتوي على 12 رمزًا على الأقل مع رمز خاص';
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

                      // Register Button
                      CustomButton(
                        btnText: 'إنشاء حساب',
                        onTap: () async {
                          await AuthService().registerUser(
                            context,
                            _usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _employeeIdController.text, // For المعرف الوظيفي
                            _phoneController.text,
                          );
                        },
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
