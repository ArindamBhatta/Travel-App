import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_app/features/all_contributor_page/widgets/card_view_to_details_page.dart';
import 'package:travel_app/features/all_contributor_page/widgets/community_post_app_bar.dart';

class CommunityPostBody extends StatelessWidget {
  final StreamController<Map<String, dynamic>> streamController;

  CommunityPostBody({required this.streamController});
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //*Sliver App bar
        SliverAppBar(
          floating: false,
          expandedHeight: 200.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CommunityPostAppBar(), //* app bar context
            background: Image.network(
              "https://images.pexels.com/photos/3361480/pexels-photo-3361480.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              fit: BoxFit.cover,
            ),
          ),
        ),
        StreamBuilder<Map<String, dynamic>>(
          stream: streamController.stream,
          builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'unable to fetch data right now, try again later .',
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              final Map<String, dynamic> comboData = snapshot.data!;
              List<Map<String, dynamic>> contributionsData =
                  comboData['contributions'];
              Map<String, dynamic> userData = comboData['user'];

              if (contributionsData.length == 0) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'No User Post yet.',
                    ),
                  ),
                );
              }
              //*sliver grid
              return SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    //* dynamically creating and managing child widgets within a SliverGrid just like SliverGrid.builder .
                    (
                      BuildContext context,
                      int index,
                    ) {
                      Map<String, dynamic> singleContributorData =
                          contributionsData[index];
                      return CardViewToDetailsPage(
                        singleContributorData,
                        userData,
                      );
                    },
                    childCount: contributionsData.length,
                  ),
                  //* gird view
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                  ),
                ),
              );
            } else {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text('Something happen'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
