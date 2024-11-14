import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import '../../../../common/utils/remote_data.dart';

class TextButtonNavigation extends StatelessWidget {
  final int id;
  final String buttonText;

  TextButtonNavigation({
    required this.id,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    //* this method is used for toggle between buttons
    bool buttonTextIsSelected = false;

    int? index = context.watch<HomePageProvider>().textVisibilityIndex;
    if (index == id) {
      buttonTextIsSelected = true;
    }
    //* give us the enum value by using index value index is passing from parent class enum.values[0] == 'All'
    final selectedFilter = allButtonText.values[id];

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
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: () {
        context.read<HomePageProvider>().toggleTextVisibility(
            id); //* parameter is id which is coming in parent class
        context.read<HomePageProvider>().updateFilter(
            selectedFilter); //* call function with enum index 0 == 'All'
      },
      child: Text(
        buttonText,
        style: TextStyle(
          color: buttonTextIsSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
