import 'package:flutter/material.dart';

Widget specialForYou({
  required String name,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 18.0,
    ),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
