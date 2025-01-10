import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/filtering_option_for_user.dart';
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
    final homePageProvider = context.read<HomePageProvider>();

    /* when the bottom sheet is their every time init State is called
    if selectedContinents is Empty them loop through all Continent.
    else create a shallow copy of Provider userSelectedContinents and store in selectedContinents
   */
    selectedContinents = homePageProvider.userSelectedContinents.isEmpty
        ? Continent.values.map((continent) => continent.name).toList()
        : List.from(
            homePageProvider.userSelectedContinents,
          );

    selectedTags = homePageProvider.userSelectedTags.isEmpty
        ? Tags.values.map((tag) => tag.name).toList()
        : List.from(
            homePageProvider.userSelectedTags,
          );
  }

  @override
  Widget build(BuildContext context) {
    final homePageProvider = context.read<HomePageProvider>();

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
              FilteringOptionForUser(
                heading: 'Select Continents',

                // mapping through every enum and change it a string.
                totalItem: Continent.values
                    .map(
                      (continent) => continent.name,
                    )
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
                        homePageProvider.userSelectedContinents.clear();
                      } else {
                        // Reset to default selection when toggled back on
                        selectedContinents = Continent.values
                            .map((continent) => continent.name)
                            .toList();
                        homePageProvider.userSelectedContinents =
                            List.from(selectedContinents);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              FilteringOptionForUser(
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
                        homePageProvider.userSelectedTags.clear();
                      } else {
                        // Reset to default selection when toggled back on
                        selectedTags =
                            Tags.values.map((tag) => tag.name).toList();
                        homePageProvider.userSelectedTags =
                            List.from(selectedTags);
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
                      onPressed:
                          context.watch<HomePageProvider>().allPublisherData ==
                                  null
                              ? null
                              : () {
                                  homePageProvider.userSelectedContinents =
                                      List.from(selectedContinents);
                                  homePageProvider.userSelectedTags =
                                      List.from(selectedTags);

                                  homePageProvider.filterPublisherData(
                                    homePageProvider.userSelectedContinents,
                                    homePageProvider.userSelectedTags,
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
/* 
void main() {
  List<int> number = [1, 2, 3, 4, 5, 6];
  List<int> deepCopy = List.from(number);
  List<int> shallowCopy = number;

  print('deepCopy $deepCopy');

  //number = [6, 7, 8, 9, 10]; //create a new List with &address.
  number.add(23);

  print('shallowCopy $shallowCopy');

  print(number);
}
 */
