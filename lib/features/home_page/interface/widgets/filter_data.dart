import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class FilterData extends StatefulWidget {
  FilterData();

  @override
  State<FilterData> createState() => _FilterDataState();
}

class _FilterDataState extends State<FilterData> {
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
                  selected: context
                      .read<HomePageProvider>()
                      .userSelectedContinents
                      .contains(continent.name), //* check
                  onSelected: (isSelected) {
                    setState(
                      () {
                        isSelected
                            ? context
                                .read<HomePageProvider>()
                                .userSelectedContinents
                                .add(continent.name)
                            : context
                                .read<HomePageProvider>()
                                .userSelectedContinents
                                .remove(continent.name);
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
                  selected: context
                      .read<HomePageProvider>()
                      .userSelectedTags
                      .contains(tag.name),
                  onSelected: (isSelected) {
                    setState(
                      () {
                        isSelected
                            ? context
                                .read<HomePageProvider>()
                                .userSelectedTags
                                .add(tag.name)
                            : context
                                .read<HomePageProvider>()
                                .userSelectedTags
                                .remove(tag.name);
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
                  context.read<HomePageProvider>().getFilterPublisherData();
                  Navigator.pop(context);
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
