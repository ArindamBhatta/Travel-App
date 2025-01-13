import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/destination_card.dart';
import 'package:travel_app/features/home_page/interface/widgets/destination_details.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'package:travel_app/features/home_page/module/model/publisher_model.dart';

class CardToDetailsPage extends StatefulWidget {
  final PublisherModel destination;
  final List<dynamic>? userWishlist;

  CardToDetailsPage({
    super.key,
    required this.destination,
    required this.userWishlist,
  });

  @override
  _CardToDetailsPageState createState() => _CardToDetailsPageState();
}

class _CardToDetailsPageState extends State<CardToDetailsPage> {
  late bool isInWishlist;

  @override
  void initState() {
    isInWishlist = widget.userWishlist != null &&
        widget.userWishlist!.contains(widget.destination.id);
    super.initState();
  }

  void toggleWishListInFireStore(BuildContext context) async {
    final provider = Provider.of<HomePageProvider>(context, listen: false);

    if (isInWishlist) {
      await provider.removeFromWishlist('${widget.destination.id}');
    } else {
      await provider.addToWishlist('${widget.destination.id}');
    }

    setState(() {
      isInWishlist = !isInWishlist;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isInWishlist
              ? 'Wishlist added successfully.'
              : 'Wishlist removed successfully.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0.0,
      openElevation: 0.0,
      closedBuilder: (context, action) {
        return DestinationCard(
          imageUri: widget.destination.imageUrl,
          name: widget.destination.name,
          country: widget.destination.country,
          continent: widget.destination.continent,
          bookmark: isInWishlist,
          toggleInFireStore: () => toggleWishListInFireStore(context),
        );
      },
      openBuilder: (context, action) {
        return DestinationDetails(
          imageUri: widget.destination.imageUrl,
          name: widget.destination.name,
          country: widget.destination.country,
          continent: widget.destination.continent,
          knowFor: widget.destination.knownFor,
          viewPoints: widget.destination.tags,
          bookmark: isInWishlist,
          toggleInFireStore: () => toggleWishListInFireStore(context),
        );
      },
    );
  }
}
