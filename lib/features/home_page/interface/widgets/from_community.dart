import 'package:flutter/material.dart';

import 'package:travel_app/common/widgets/custom_card_widget.dart';

class FromCommunity extends StatelessWidget {
  final String allContributorsImage;
  FromCommunity({
    super.key,
    required this.allContributorsImage,
  });
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2;
    return CustomCardWidget(
      width: width,
      id: 1,
      imageUri: allContributorsImage,
      bookMark: false,
      location: 'Darjeeling',
      state: 'Kolkata',
      country: 'India',
      toggleWishList: () {},
    );
  }
}
