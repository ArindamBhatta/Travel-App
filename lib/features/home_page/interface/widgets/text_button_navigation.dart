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
    return TextButton(
      onPressed: () {
        context.read<HomePageProvider>().toggleTextVisibility(id);
      },
      child: Text(
        '$buttonText',
      ),
    );
  }
}
