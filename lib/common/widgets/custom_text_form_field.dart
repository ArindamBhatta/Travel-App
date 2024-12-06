import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final double textBoxHeight;
  final String labelText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CustomTextFormField({
    required this.labelText,
    required this.prefixIcon,
    this.textBoxHeight = 16.0,
    this.suffixIcon,
    this.validator,
    this.onSaved,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: widget.textBoxHeight),
        filled: false,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal[400]!),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: widget.labelText,
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}


/* 
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final double textBoxHeight;
  final String labelText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CustomTextFormField({
    required this.labelText,
    required this.prefixIcon,
    this.textBoxHeight = 16.0,
    this.suffixIcon,
    this.validator,
    this.onSaved,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(widget.textBoxHeight),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal[400]!),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        labelText: widget.labelText,
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: Icon(widget.suffixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}

 */