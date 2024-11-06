import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookingButton extends StatelessWidget {
  final String? buttonText;
  bool isSelected;
  Function onPressed;

  BookingButton({
    required this.buttonText,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: isSelected
            ? WidgetStateProperty.all(
                Colors.teal[500],
              )
            : WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 2,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              color: isSelected ? Colors.teal : Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        buttonText!,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
