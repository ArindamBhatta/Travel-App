import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String containerText;
  final int index;
  final int visibleButton;
  final VoidCallback onButtonPressed;

  const NavigationButton({
    super.key,
    required this.visibleButton,
    required this.index,
    required this.containerText,
    required this.onButtonPressed,
  });

  bool checkToggleValue() {
    if (visibleButton == index) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          checkToggleValue() ? Colors.teal[500] : null,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        onButtonPressed();
        checkToggleValue();
        print(checkToggleValue());
      },
      child: Text(
        containerText,
        style: TextStyle(
          color: checkToggleValue() ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
