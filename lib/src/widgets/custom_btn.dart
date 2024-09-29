import 'package:flutter/material.dart';
import 'package:app/src/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? btnText;
  final Color? firstColor;
  final Color? secondColor;

  const CustomButton({
    Key? key,
    required this.onTap,
    this.btnText = 'Gradient Button',
    this.firstColor = AppColors.gradientStartColor,
    this.secondColor = AppColors.gradientEndColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        splashColor: AppColors.primaryBlue.withOpacity(0.4),
        child: Ink(
          height: 40.0,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                firstColor!,
                secondColor!,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child: Text(
              btnText!,
              style: const TextStyle(
                fontSize: 20.0,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
