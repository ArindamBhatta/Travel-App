import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class TextButtonNavigation extends StatelessWidget {
  final int id;
  final Button continent;

  TextButtonNavigation({
    required this.id,
    required this.continent,
  });

  @override
  Widget build(BuildContext context) {
    bool buttonTextIsSelected = false;

    int? index = context.watch<HomePageProvider>().textVisibilityIndex;

    if (id == index) {
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
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: () {
        context
            .read<HomePageProvider>()
            .setCurrentContinent(this.continent, this.id);
      },
      child: Text(
        '${this.continent.name}',
        style: TextStyle(
          color: buttonTextIsSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
