import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String containerText;
  final int buttonId;
  final int selectedButtonId;
  final ValueChanged<int> onButtonPressed;

  const NavigationButton({
    super.key,
    required this.selectedButtonId,
    required this.buttonId,
    required this.containerText,
    required this.onButtonPressed,
  });

  bool checkToggleValue() {
    if (selectedButtonId == buttonId) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('$buttonId ... $selectedButtonId');
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          selectedButtonId == buttonId ? Colors.teal[500] : null,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () {
        onButtonPressed(buttonId);
        // checkToggleValue();
      },
      child: Text(
        containerText,
        style: TextStyle(
          color: selectedButtonId == buttonId ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
