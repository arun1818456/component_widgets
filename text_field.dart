import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFieldForm extends StatefulWidget {
  final int maxLine;
  final String label;
  final bool isQROnly;
  final bool readOnly;
  final int? maxLength;
  final bool isPassword;
  final String? hintText;
  final Color? fillColor;
  final bool isDigitsOnly;
  final Color? borderColor;
  final String? errorText;
  final bool isCouponCode;
  final double formRadius;
  final Widget? prefixIcon;
  final EdgeInsets? margin;
  final Widget? suffixIcon;
  final bool isDecimalOnly;
  final FocusNode? focusNode;
  final bool isLowercaseOnly;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final GestureTapCallback? onTap;
  final double verticalTextPadding;
  final TextInputType? keyboardType;
  final double horizontalTextPadding;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final InputCounterWidgetBuilder? buildCounter;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final bool autoFocusNextOnMaxLength;
  final bool showLabel;
  final bool showError;
  final Widget? passwordVisibleIcon;
  final Widget? passwordInvisibleIcon;

  const MyTextFieldForm({
    super.key,
    this.onTap,
    this.margin,
    this.hintText,
    this.maxLength,
    this.onChanged,
    this.focusNode,
    this.errorText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.label = "",
    this.maxLine = 1,
    this.buildCounter,
    this.keyboardType,
    this.formRadius = 8,
    this.readOnly = false,
    this.isQROnly = false,
    this.isPassword = false,
    this.isDigitsOnly = false,
    this.isDecimalOnly = false,
    this.isCouponCode = false,
    this.isLowercaseOnly = false,
    this.verticalTextPadding = 0,
    this.horizontalTextPadding = 20,
    this.fillColor,
    this.borderColor,
    this.textCapitalization = TextCapitalization.none,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.validator,
    this.autoFocusNextOnMaxLength = false,
    this.showLabel = true,
    this.showError = true,
    this.passwordVisibleIcon,
    this.passwordInvisibleIcon,
  });

  @override
  State<MyTextFieldForm> createState() => _MyTextFieldFormState();
}

class _MyTextFieldFormState extends State<MyTextFieldForm> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() => obscureText = !obscureText);
  }

  List<TextInputFormatter> _buildInputFormatters() {
    final formatters = <TextInputFormatter>[];

    if (widget.isDigitsOnly) {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    }
    if (widget.isDecimalOnly) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')));
    }
    if (widget.isLowercaseOnly) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp(r"[a-z]")));
    }
    if (widget.isQROnly) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9-]')));
    }
    if (widget.isCouponCode) {
      formatters.addAll([
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        LengthLimitingTextInputFormatter(5),
      ]);
    }
    if (widget.maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(widget.maxLength));
    }
    return formatters;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showLabel && widget.label.isNotEmpty) ...[
            Text(
              widget.label,
              style: widget.labelStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            controller: widget.controller,
            maxLength: widget.maxLength,
            autofocus: false,
            textCapitalization: widget.textCapitalization,
            obscureText: obscureText,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLine,
            buildCounter: widget.buildCounter,
            onChanged: (val) {
              widget.onChanged?.call(val);
              if (widget.autoFocusNextOnMaxLength &&
                  widget.maxLength != null &&
                  val.length == widget.maxLength) {
                FocusScope.of(context).nextFocus();
              }
            },
            inputFormatters: _buildInputFormatters(),
            style: widget.textStyle ??
                theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
            decoration: InputDecoration(
              hintStyle: widget.hintStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              filled: true,
              fillColor: widget.fillColor ??
                  theme.inputDecorationTheme.fillColor ??
                  Colors.white,
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: widget.verticalTextPadding,
                horizontal: widget.horizontalTextPadding,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon ??
                  (widget.isPassword
                      ? IconButton(
                    icon: obscureText
                        ? (widget.passwordInvisibleIcon ??
                        const Icon(Icons.visibility_off))
                        : (widget.passwordVisibleIcon ??
                        const Icon(Icons.visibility)),
                    onPressed: _toggleVisibility,
                  )
                      : null),
              errorText: widget.showError ? widget.errorText : null,
              errorMaxLines: 3,
              hintText: widget.hintText,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? theme.dividerColor,
                ),
                borderRadius: BorderRadius.circular(widget.formRadius),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? theme.dividerColor,
                ),
                borderRadius: BorderRadius.circular(widget.formRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? theme.dividerColor,
                ),
                borderRadius: BorderRadius.circular(widget.formRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? theme.colorScheme.primary,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(widget.formRadius),
              ),
            ),
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
