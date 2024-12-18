import 'package:flutter/material.dart';
import 'package:travel_app/features/all_contributor_page/widgets/community_post_app_bar.dart';

class CommunityPostBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: false,
          expandedHeight: 200.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CommunityPostAppBar(),
            background: Image.network(
              "https://images.pexels.com/photos/3361480/pexels-photo-3361480.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  color: Colors.teal[400],
                  child: Center(
                    child: Text(
                      'all contributor',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
            ),
          ),
        ),
      ],
    );
  }
}
