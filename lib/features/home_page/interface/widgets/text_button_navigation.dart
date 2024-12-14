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

    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.primaryContainer,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              width: 0.6,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: () {
        context.read<HomePageProvider>().toggleTextVisibility(id);
      },
      child: Text(
        '$buttonText',
        style: buttonTextIsSelected
            ? Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                )
            : Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
      ),
    );
  }
}
