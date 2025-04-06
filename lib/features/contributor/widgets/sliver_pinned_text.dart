import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/user_contribution_page/user_contribution_page.dart';

class SliverPinnedText extends SliverPersistentHeaderDelegate {
  final String continentName;
  SliverPinnedText(this.continentName);
  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  final double fabDimension = 56.0;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: maxExtent,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore the",
                style: TextStyle(fontSize: 24),
              ),
              Row(
                children: [
                  Text(
                    "Beauty of",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    continentName,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.amber,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          OpenContainer(
            transitionDuration: Duration(milliseconds: 800),
            transitionType: _transitionType,
            openBuilder: (BuildContext context, VoidCallback _) {
              return UserContributionPage();
            },
            closedElevation: 6.0,
            closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            closedBuilder: (BuildContext context, VoidCallback openContainer) {
              return Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/my_contribution.png',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
