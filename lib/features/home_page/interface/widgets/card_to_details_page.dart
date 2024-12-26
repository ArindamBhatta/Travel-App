import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/destination_card.dart';
import 'package:travel_app/features/home_page/interface/widgets/destination_details.dart';
import 'package:travel_app/features/home_page/module/model/destination_model.dart';

class CardToDetailsPage extends StatelessWidget {
  final DestinationModel destination;
  CardToDetailsPage(this.destination);

  @override
  Widget build(BuildContext context) {
    String? imageUri = destination.imageUrl;
    String? name = destination.name;
    String? continent = destination.continent;
    String? country = destination.country;
    String? knowFor = destination.knownFor;

    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, action) {
        return DestinationCard(
          imageUri: imageUri,
          name: name,
          country: country,
          continent: continent,
        );
      },
      openBuilder: (context, action) {
        return DestinationDetails(
          imageUri: imageUri,
          name: name,
          country: country,
          continent: continent,
          knowFor: knowFor,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
