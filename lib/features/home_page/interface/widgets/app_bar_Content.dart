import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/interface/widgets/google_log_out.dart';

import '../../../../common/utils/google_login_provider.dart';

class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? userData =
        context.watch<GoogleLoginProvider>().userData;

    if (userData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              '${userData['photoUrl']}',
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userData['name']}',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Where do you want to go?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
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
            onPressed: () => logoutPopup(context),
            child: Icon(
              Icons.logout_sharp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
