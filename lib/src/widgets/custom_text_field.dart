import 'package:flutter/material.dart';
import 'package:app/src/utils/constants/colors.dart'; // Adjust the path

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? obscureCharacter;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.obscureCharacter = '*',
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: height * 0.02, vertical: height * 0.01),
      child: Material(
        elevation: 2.0, // Adding elevation for depth effect
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText!,
          obscuringCharacter: obscureCharacter!,
          style: const TextStyle(
            fontSize: 16.0, // Slightly larger font size for readability
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w500, // Adding some weight for clearer text
          ),
          decoration: InputDecoration(
            fillColor: AppColors.whiteColor,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14.0,
              color: AppColors.mediumBlue, // Use a lighter hint color
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0), // Consistent padding for prefix icon
              child: prefixIcon,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                  right: 8.0), // Consistent padding for suffix icon
              child: suffixIcon,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), // More rounded corners
              borderSide: const BorderSide(
                color: Colors.transparent, // No border by default, only shadow
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue, // Highlighted border when focused
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: AppColors.mediumBlue, // Border when not focused
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.red, // Error color
                width: 1.5,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
