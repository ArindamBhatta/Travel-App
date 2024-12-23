import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'package:travel_app/features/home_page/module/service/home_page_service.dart';

class FilterData extends StatefulWidget {
  FilterData();

  @override
  State<FilterData> createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {
  List<Continent> selectedContinents = [];
  List<Tags> selectedTags = [];

  Future<List<Map<String, dynamic>>?> getFilterPublisherData() async {
    //*Step 1: - Fetch all publisher data
    List<Map<String, dynamic>> allPublisherData =
        await HomePageService.fetchPublisherData();

    //* Step 2: - Filter based on selected continents
    List<Map<String, dynamic>> filteredData = allPublisherData.where(
      (publisherItem) {
        //* Step 3: - Check if the publisher's continent exists in the selectedContinents list
        return selectedContinents
            .any((continent) => publisherItem['continent'] == continent.name);
      },
    ).toList();
    return filteredData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Where Do You Want To Go',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text('Select Continents'),
          SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            children: Continent.values.map((continent) {
              return FilterChip(
                label: Text(continent.name),
                selected: selectedContinents.contains(continent),
                onSelected: (isSelected) {
                  setState(() {
                    isSelected
                        ? selectedContinents.add(continent)
                        : selectedContinents.remove(continent);
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text('Select Tags'),
          SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            children: Tags.values.map(
              (tag) {
                return FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        tagsIcon(tag.name),
                        size: 18.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(tag.name),
                    ],
                  ),
                  selected: selectedTags.contains(tag),
                  onSelected: (isSelected) {
                    setState(
                      () {
                        isSelected
                            ? selectedTags.add(tag)
                            : selectedTags.remove(tag);
                      },
                    );
                  },
                );
              },
            ).toList(),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  backgroundColor: Theme.of(context).dialogTheme.iconColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('cancel'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                ),
                onPressed: () {
                  getFilterPublisherData();
                },
                child: const Text('submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
