import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/home_page/provider/home_page_provider.dart';

class BookingButton extends StatelessWidget {
  final int id;
  final String? buttonText;

  BookingButton({
    required this.id,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    bool buttonTextIsSelected = false;
    int? index = context.watch<HomePageProvider>().textVisibilityIndex;
    if (index == id) {
      buttonTextIsSelected = true;
    }

    return TextButton(
      style: ButtonStyle(
        backgroundColor: buttonTextIsSelected
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
              color: buttonTextIsSelected ? Colors.teal : Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onPressed: () {
        context.read<HomePageProvider>().toggleTextVisibility(id);
      },
      child: Text(
        buttonText!,
        style: TextStyle(
          color: buttonTextIsSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
