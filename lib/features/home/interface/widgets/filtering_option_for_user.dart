import 'package:flutter/material.dart';
import 'package:travel_app/features/home/module/data/home_page_provider.dart';

class FilteringOptionForUser extends StatefulWidget {
  final String heading;
  final List<String> totalItem;
  final List<String> selectedItems;
  final Function(bool isSelected, String item) onSelected;
  final Function(bool isCleared) onClearSwitchChanged;

  FilteringOptionForUser({
    required this.heading,
    required this.totalItem,
    required this.selectedItems,
    required this.onSelected,
    required this.onClearSwitchChanged,
  });

  @override
  _FilteringOptionForUserState createState() => _FilteringOptionForUserState();
}

class _FilteringOptionForUserState extends State<FilteringOptionForUser> {
  bool isSwitchOn = true;
  WidgetStateProperty<Icon> toggleIconForFilterTagAndContinent =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.check),
      WidgetState.any: Icon(Icons.close),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.heading,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              thumbIcon: toggleIconForFilterTagAndContinent,
              value: isSwitchOn,
              activeColor: Colors.teal,
              onChanged: (bool toggle) {
                setState(
                  () {
                    isSwitchOn = toggle;
                    widget.onClearSwitchChanged(toggle);
                  },
                );
              },
            ),
          ],
        ),
        Wrap(
          spacing: 8.0,
          children: widget.totalItem.map(
            (item) {
              return FilterChip(
                label: Text(item),
                showCheckmark: false,
                avatar: widget.selectedItems.contains(item)
                    ? Icon(Icons.check_circle)
                    : Icon(
                        tagsIcon(item),
                        size: 18,
                      ),
                selectedColor: Colors.tealAccent,
                labelStyle: TextStyle(color: Colors.black),
                checkmarkColor: Colors.teal,
                selected: widget.selectedItems.contains(item),
                onSelected: (isSelected) => widget.onSelected(
                  isSelected,
                  item,
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
