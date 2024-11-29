import 'package:flutter/material.dart';
import 'package:travel_app/common/widgets/custom_card_widget.dart';

class DataCard extends StatelessWidget {
  final Map<String, dynamic> data;
  DataCard(this.data);
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      id: 1,
      imageUri: data['image'],
      bookMark: false,
      location: data['location'],
      state: data['state'],
      country: data['country'],
      toggleWishList: () {},
    );
  }
}
