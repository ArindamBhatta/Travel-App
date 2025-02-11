import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/interface/widgets/google_log_out.dart';

class SideDrawer extends StatelessWidget {
  //*global scope
  final Map<String, dynamic>? userLoginData;
  SideDrawer(this.userLoginData);

  Widget NavigationButton(
    IconData buttonIcon,
    String buttonName,
    Function buttonPress,
  ) {
    return ListTile(
      leading: Icon(
        buttonIcon,
      ),
      title: Row(
        children: [
          Text(
            buttonName,
          ),
        ],
      ),
      onTap: () {
        buttonPress();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //* functional scope
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      shape: Border.symmetric(
        horizontal: BorderSide.none,
      ),
      child: SizedBox(
        height: 400,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                '${userLoginData?['name']}',
              ),
              accountEmail: Text(
                '${userLoginData?['email']}',
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: '${userLoginData?['photoUrl']}',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://cdn.pixabay.com/photo/2017/03/27/15/19/chairlift-2179345_1280.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            NavigationButton(
              Icons.favorite,
              'Favorites',
              () {
                Navigator.of(context).pop();
              },
            ),
            NavigationButton(
              Icons.people,
              'Friends',
              () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return LogOutDialog();
                  },
                );
              },
            ),
            NavigationButton(
              Icons.share_rounded,
              'Shear',
              () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return LogOutDialog();
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Request'),
              onTap: null,
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  height: 20,
                  width: 20,
                  child: Center(
                    child: Text(
                      '8',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            NavigationButton(
              Icons.settings,
              'Settings',
              () {
                Navigator.of(context).pop();
              },
            ),
            NavigationButton(
              Icons.policy,
              'Policies',
              () {
                Navigator.of(context).pop();
              },
            ),
            Divider(),
            NavigationButton(
              Icons.logout_outlined,
              'Exit',
              () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return LogOutDialog();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
