import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/common/widgets/custom_card_widget.dart';

import 'package:travel_app/features/details_page/details_page.dart';

import '../../module/data/home_page_provider.dart';

class CardContainer extends StatelessWidget {
  final int id;
  final String image;
  final bool bookMark;
  final String location;
  final String state;
  final String country;

  const CardContainer({
    super.key,
    required this.id,
    required this.image,
    required this.bookMark,
    required this.location,
    required this.state,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    //* toggle wish list also done from details page pass to child card container
    void toggleWishList(int dataId) {
      context.read<HomePageProvider>().toggleWishList(
            dataId,
          );
    }
    //no tap able container is needed open container do this staff for us

    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, action) {
        return CustomCardWidget(
          id: id,
          image: image,
          bookMark: bookMark,
          location: location,
          state: state,
          country: country,
          toggleWishList: toggleWishList,
        );
      },
      openBuilder: (context, action) {
        return DetailsPage(
          id: id,
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
