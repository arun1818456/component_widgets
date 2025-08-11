import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isBorderEnable;
  final Color color;
  final bool loading;
  final double? width;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback onPressed;
  final Widget? buttonCenter;
  final double? buttonHeight;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final double radius;
  final Color? loaderColor;
  final double loaderSize;
  final IconData? icon; // NEW: Optional icon
  final double iconSpacing; // NEW: Space between icon & text

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.width,
    this.isBorderEnable = false,
    this.textColor,
    this.buttonCenter,
    this.buttonHeight,
    this.loading = false,
    this.borderColor,
    this.textStyle,
    this.margin,
    this.radius = 10,
    this.loaderColor,
    this.loaderSize = 22,
    this.icon,
    this.iconSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    final double h = buttonHeight ?? 48;
    final double targetWidth = loading ? h : (width ?? MediaQuery.of(context).size.width);
    final Color effectiveLoaderColor = loaderColor ??
        (color.computeLuminance() > 0.5 ? Colors.black : Colors.white);
    final double currentRadius = loading ? h / 2 : radius;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: margin ?? EdgeInsets.zero,
      width: targetWidth,
      height: h,
      decoration: BoxDecoration(
        color: loading ? color.withOpacity(0.6) : color,
        borderRadius: BorderRadius.circular(currentRadius),
        border: isBorderEnable
            ? Border.all(color: borderColor ?? Colors.black, width: 1)
            : null,
      ),
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(currentRadius),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: ScaleTransition(scale: anim, child: child),
          ),
          child: loading
              ? SizedBox(
            key: const ValueKey('loader'),
            width: loaderSize,
            height: loaderSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveLoaderColor),
            ),
          )
              : buttonCenter ??
              Row(
                key: const ValueKey('label'),
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: textColor ?? Colors.white, size: 20),
                    SizedBox(width: iconSpacing),
                  ],
                  Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor ?? Colors.white,
                        ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
