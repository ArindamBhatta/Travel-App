import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/filter_page_chip.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class FilterPage extends StatefulWidget {
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedContinents = [
    'Asia',
    'Africa',
    'North America',
    'South America',
    'Antarctica',
    'Europe',
    'Australia',
    'Oceania'
  ];

  List<String> selectedTags = [
    'Adventure sports',
    'Beach',
    'City',
    'Cultural experiences',
    'Foodie',
    'Hiking',
    'Historic',
    'Island',
    'Luxury',
    'Mountain',
    'Nightlife',
    'Off-the-beaten-path',
    'Romantic',
    'Rural',
    'Secluded',
    'Sightseeing',
    'Skiing',
    'Wine tasting',
    'Winter destination'
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomePageProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Where Do You Want To Go',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              FilterPageChip(
                title: 'Select Continents',
                items: Continent.values
                    .map((continent) => continent.name)
                    .toList(),
                selectedItems: selectedContinents,
                onSelected: (isSelected, item) {
                  setState(
                    () {
                      isSelected
                          ? selectedContinents.add(item)
                          : selectedContinents.remove(item);
                    },
                  );
                },
                onClearSwitchChanged: (isCleared) {
                  setState(
                    () {
                      if (!isCleared) {
                        // Clear the content
                        selectedContinents.clear();
                        homeProvider.userSelectedTags.clear();
                      } else {
                        // Reset to default selection when toggled back on
                        selectedContinents.addAll(
                          Continent.values.map(
                            (continent) => continent.name,
                          ),
                        );
                        homeProvider.userSelectedContinents.addAll(Continent
                            .values
                            .map((continent) => continent.name));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              FilterPageChip(
                title: 'Select Tags',
                items: Tags.values.map((tag) => tag.name).toList(),
                selectedItems: selectedTags,
                onSelected: (isSelected, item) {
                  setState(
                    () {
                      isSelected
                          ? selectedTags.add(item)
                          : selectedTags.remove(item);
                    },
                  );
                },
                onClearSwitchChanged: (isCleared) {
                  setState(
                    () {
                      if (!isCleared) {
                        // Clear the content
                        selectedTags.clear();
                        homeProvider.userSelectedTags.clear();
                      } else {
                        // Reset to default selection when toggled back on
                        selectedTags.addAll(
                          Tags.values.map(
                            (tag) => tag.name,
                          ),
                        );
                        homeProvider.userSelectedTags
                            .addAll(Tags.values.map((tag) => tag.name));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: homeProvider.allPublisherData == null
                        ? null
                        : () {
                            homeProvider.filterPublisherData(
                              selectedContinents,
                              selectedTags,
                            );
                            Navigator.pop(context);
                          },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
