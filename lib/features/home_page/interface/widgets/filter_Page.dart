import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class FilterPage extends StatefulWidget {
  FilterPage();

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
    // Call provider without context
    WidgetsBinding.instance.addPostFrameCallback(
      (ctx) {
        context.read<HomePageProvider>().showPublisherData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where Do You Want To Go',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select Continents',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: Continent.values.map(
              (continent) {
                return FilterChip(
                  label: Text(continent.name),
                  selected: context
                      .read<HomePageProvider>()
                      .userSelectedContinents
                      .contains(continent.name),
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
          SizedBox(height: 8),
          Text(
            'Select Tags',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
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
              Consumer<HomePageProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 36),
                    ),
                    onPressed: provider.allPublisherData == null
                        ? null
                        : () {
                            provider.filterPublisherData();
                            Navigator.pop(context);
                          },
                    child: const Text('submit'),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
