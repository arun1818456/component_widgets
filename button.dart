import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool? isBorderEnable;
  final Color? color;
  final bool? loading;
  final double? width;
  final Color? textColor;
  final Color? borderColor;
  final Function() onPressed;
  final Widget? buttonCenter;
  final double? buttonHeight;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final double? radius;
  const CustomButton({
    super.key,
    this.color = Colors.blue, // primary Color App Button default.
    this.width,
    this.isBorderEnable=false,
    this.textColor,
    this.buttonCenter,
    this.buttonHeight,
    required this.text,
    this.loading = false,
    this.borderColor,
    required this.onPressed,
    this.textStyle, this.margin, this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius??10),
        color: Colors.transparent,
      ),
      height: buttonHeight ?? 48, // Default height
      margin: margin ??EdgeInsets.zero,
      width: width?? MediaQuery.of(context).size.width, // Default to full width
      child: ElevatedButton(
        onPressed: loading == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent, // Text color
          backgroundColor: color ?? Colors.blue, // Button background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius??10), // Rounded corners
            side: isBorderEnable == true
                ? BorderSide(color: borderColor ?? Colors.black, width: 1)
                : BorderSide.none, // No border by default
          ),
          elevation: 5, // Shadow effect
        ),
        child: loading == true
            ? const CircularProgressIndicator(color: Colors.blueAccent)
            : buttonCenter ??
                  Text(
                    text,
                    style:
                        textStyle ??
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor ?? Colors.white, // Text color
                        ),
                  ),
      ),
    );
  }
}
