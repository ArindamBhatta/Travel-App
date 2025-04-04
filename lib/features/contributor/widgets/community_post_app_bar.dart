import 'package:flutter/material.dart';
import 'package:travel_app/common/utils/theme/colors.dart';

class CommunityPostAppBar extends StatelessWidget {
  CommunityPostAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/1435517/pexels-photo-1435517.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Wanderly",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.baseColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(height: 4),
              Center(
                child: Text(
                  'all contributed data',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(0),
          ),
          onPressed: () {},
          child: Icon(
            Icons.notifications_none_sharp,
          ),
        ),
      ],
    );
  }
}
