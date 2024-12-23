import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class FilterData extends StatefulWidget {
  FilterData();

  @override
  State<FilterData> createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {
  Continent? selectedContinent = Continent.asia;
  Tags selectedTags = Tags.Mountain;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Filter Your Dream Destinations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text('Select a Continent'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<Continent>(
                value: selectedContinent,
                items: Continent.values.map((continent) {
                  return DropdownMenuItem(
                    value: continent,
                    child: Text(continent.name),
                  );
                }).toList(),
                onChanged: (Continent? value) {
                  if (value == null) return;
                  setState(
                    () {
                      selectedContinent = value;
                    },
                  );
                },
              ),
              DropdownButton<Tags>(
                value: selectedTags,
                items: Tags.values.map((tag) {
                  return DropdownMenuItem(
                    value: tag,
                    child: Text(tag.name),
                  );
                }).toList(),
                onChanged: (Tags? tagsValue) {
                  if (tagsValue == null) return;
                  setState(
                    () {
                      selectedTags = tagsValue;
                    },
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36,
                  ),
                  backgroundColor: Theme.of(context).dialogTheme.iconColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'cancel',
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 36,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'submit',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
