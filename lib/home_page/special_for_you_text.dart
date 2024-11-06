import 'package:flutter/material.dart';

class SpecialForYouText extends StatefulWidget {
  final List<String> itemButtonList;

  SpecialForYouText({
    super.key,
    required this.itemButtonList,
  });

  @override
  State<SpecialForYouText> createState() => _SpecialForYouTextState();
}

class _SpecialForYouTextState extends State<SpecialForYouText> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.itemButtonList[0];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special For You',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    iconEnabledColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(color: Colors.teal),
                    underline: SizedBox(),
                    items: widget.itemButtonList
                        .map<DropdownMenuItem<String>>((String button) {
                      return DropdownMenuItem<String>(
                        value: button,
                        child: Text(button),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  )
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
