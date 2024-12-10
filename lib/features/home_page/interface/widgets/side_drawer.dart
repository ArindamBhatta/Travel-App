import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/features/home_page/module/data/theme_switching_provider.dart';

class SideDrawer extends StatelessWidget {
  final Map<String, dynamic>? userLoginData;
  SideDrawer(this.userLoginData);

  //* global scope
  @override
  Widget build(BuildContext context) {
    //* functional scope

    return Drawer(
      backgroundColor: Colors.white,
      shape: Border.symmetric(
        horizontal: BorderSide.none,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SwitchListTile(
                    value: context.watch<ThemeSwitchingProvider>().themeMode ==
                        ThemeMode.light,
                    onChanged: (bool value) {
                      context.read<ThemeSwitchingProvider>().toggleTheme();
                    },
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      '${userLoginData?['photoUrl']}',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${userLoginData?['name']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
                    child: Expanded(
                      child: Text(
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        '${userLoginData?['email']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
