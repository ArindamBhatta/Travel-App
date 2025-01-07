import 'package:flutter/material.dart';

class FilterPageChip extends StatefulWidget {
  final String title;
  final List<String> items;
  final List<String> selectedItems;
  final Function(bool isSelected, String item) onSelected;
  final Function(bool isCleared) onClearSwitchChanged;

  FilterPageChip({
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onSelected,
    required this.onClearSwitchChanged,
  });

  @override
  _FilterPageChipState createState() => _FilterPageChipState();
}

class _FilterPageChipState extends State<FilterPageChip> {
  bool isSwitchOn = true;
  WidgetStateProperty<Icon> thumbIcon = WidgetStateProperty<Icon>.fromMap(
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
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Switch(
              thumbIcon: thumbIcon,
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
          children: widget.items.map(
            (item) {
              return FilterChip(
                label: Text(item),
                checkmarkColor: Colors.teal,
                selectedColor: Colors.tealAccent,
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
