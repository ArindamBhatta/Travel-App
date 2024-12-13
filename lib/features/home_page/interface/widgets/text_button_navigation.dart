import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class TextButtonNavigation extends StatelessWidget {
  //* global scope property
  final int id;
  final String buttonText;

  //* name constructor
  TextButtonNavigation({
    required this.id,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    //* write in function scope so when widget is rerender variable is assign initial  value
    bool buttonTextIsSelected = false;

    int? index = context.watch<HomePageProvider>().textVisibilityIndex;
    if (index == id) {
      buttonTextIsSelected = true;
    }

    //* give us the enum value by using index value index is passing from parent class enum.values[0] == 'All'

    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Theme.of(context).brightness ==
                Brightness.light
            ? (buttonTextIsSelected ? Colors.teal[500] : Colors.white)
            : (buttonTextIsSelected ? Colors.teal[100] : Colors.grey.shade800)),

        ///
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 2,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              width: 0.6,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade400
                  : Colors.grey.shade700,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: () {
        context.read<HomePageProvider>().toggleTextVisibility(id);
      },
      child: Text(
        buttonText,
        style: TextStyle(
            color: (Theme.of(context).brightness == Brightness.light
                ? (buttonTextIsSelected ? Colors.white : Colors.black)
                : (buttonTextIsSelected
                    ? Colors.grey.shade900
                    : Colors.white))),
      ),
    );
  }
}
