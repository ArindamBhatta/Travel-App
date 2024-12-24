import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'package:travel_app/features/home_page/module/service/home_page_service.dart';

class FilterData extends StatefulWidget {
  FilterData();

  @override
  State<FilterData> createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {
  List<String> userSelectedContinents = []; //* [Asia, 'North America'];
  List<String> userSelectedTags = [];

  Future<List<Map<String, dynamic>>?> getFilterPublisherData() async {
    //*Step 1: - Fetch all publisher data
    List<Map<String, dynamic>> allPublisherData =
        await HomePageService.fetchPublisherData();

    //* Step 2: - Filter based on selected continents
    List<Map<String, dynamic>> continentBaseFilteredData =
        allPublisherData.where((destination) {
      return userSelectedContinents
          .any((continent) => //* check with firebase data
              destination['continent'] == continent);
    }).toList();

    //* Step 3: - Filter based on selected tags
    List<Map<String, dynamic>> filteredData = continentBaseFilteredData.where(
      (destination) {
        return userSelectedTags.any((tag) =>
            //* check with firebase tags[element1, element2, element3] contains method
            destination['tags'].contains(tag));
      },
    ).toList();
    print(filteredData.length);
    return filteredData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
            children: Continent.values.map(
              (continent) {
                return FilterChip(
                  label: Text(continent.name),
                  selected: userSelectedContinents.contains(continent.name),
                  onSelected: (isSelected
                      //* onSelected want void Function(bool); Called when the FilterChip should change between selected and de-selected states. When the FilterChip is tapped, toggle !selected.
                      ) {
                    setState(
                      () {
                        isSelected
                            ? userSelectedContinents.add(continent.name)
                            : userSelectedContinents.remove(continent.name);
                      },
                    );
                  },
                );
              },
            ).toList(),
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
                  selected: userSelectedTags.contains(tag.name),
                  onSelected: (isSelected) {
                    setState(
                      () {
                        isSelected
                            ? userSelectedTags.add(tag.name)
                            : userSelectedTags.remove(tag.name);
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
                  print(userSelectedContinents);
                  print(userSelectedTags);
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
