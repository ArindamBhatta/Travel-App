import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class FilterPageChip extends StatefulWidget {
  final String heading;
  final List<String> totalItem;
  final List<String> selectedItems;
  final Function(bool isSelected, String item) onSelected;
  final Function(bool isCleared) onClearSwitchChanged;

  FilterPageChip({
    required this.heading,
    required this.totalItem,
    required this.selectedItems,
    required this.onSelected,
    required this.onClearSwitchChanged,
  });

  @override
  _FilterPageChipState createState() => _FilterPageChipState();
}

class _FilterPageChipState extends State<FilterPageChip> {
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
