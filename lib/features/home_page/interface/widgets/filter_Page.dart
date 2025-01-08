import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/filter_page_chip.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class FilterPage extends StatefulWidget {
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> selectedContinents = [];
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    final homeProvider = context.read<HomePageProvider>();

    // when the bottom sheet is their every time init State is called
    selectedContinents = homeProvider.userSelectedContinents.isEmpty
        ? Continent.values.map((continent) => continent.name).toList()
        : List.from(homeProvider.userSelectedContinents);

    selectedTags = homeProvider.userSelectedTags.isEmpty
        ? Tags.values.map((tag) => tag.name).toList()
        : List.from(homeProvider.userSelectedTags);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomePageProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
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
                heading: 'Select Continents',
                totalItem: Continent.values
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
                        homeProvider.userSelectedContinents.clear();
                      } else {
                        // Reset to default selection when toggled back on
                        selectedContinents = Continent.values
                            .map((continent) => continent.name)
                            .toList();
                        homeProvider.userSelectedContinents =
                            List.from(selectedContinents);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              FilterPageChip(
                heading: 'Select Tags',
                totalItem: Tags.values.map((tag) => tag.name).toList(),
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
                        selectedTags =
                            Tags.values.map((tag) => tag.name).toList();
                        homeProvider.userSelectedTags = List.from(selectedTags);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(228, 255, 255, 255)),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: homeProvider.allPublisherData == null
                          ? null
                          : () {
                              // Update provider's selected continents and tags
                              homeProvider.userSelectedContinents =
                                  List.from(selectedContinents);
                              homeProvider.userSelectedTags =
                                  List.from(selectedTags);

                              // Call the filtering logic
                              homeProvider.filterPublisherData(
                                homeProvider.userSelectedContinents,
                                homeProvider.userSelectedTags,
                              );

                              Navigator.pop(context);
                            },
                      child: const Text('Apply'),
                    ),
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
