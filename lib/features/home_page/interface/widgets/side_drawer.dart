import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/common/utils/theme_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:travel_app/features/home_page/module/data/theme_provider.dart';

class SideDrawer extends StatelessWidget {
  //*global scope
  final Map<String, dynamic>? userLoginData;
  SideDrawer(this.userLoginData);

  Widget NavigationButton(
      IconData icon, String buttonName, BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        buttonName,
        style: TextStyle(
          color: Colors.teal[400],
        ),
      ),
      onTap: () {},
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250,
            child: Center(
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Theme.of(context).drawerTheme.backgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            '${userLoginData?['photoUrl']}',
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ThemeProvider>().toggleTheme();
                          },
                          icon: Icon(
                            Icons.abc,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${userLoginData?['name']}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8,
                      ),
                      child: Text(
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        '${userLoginData?['email']}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          NavigationButton(
            Icons.home,
            'Home',
            context,
          ),
          NavigationButton(
            Icons.settings,
            'Settings',
            context,
          ),
          NavigationButton(
            Icons.logout_outlined,
            'logout',
            context,
          )
        ],
      ),
    );
  }
}
