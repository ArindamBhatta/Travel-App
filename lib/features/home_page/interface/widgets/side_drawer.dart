import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:travel_app/features/home_page/module/data/theme_provider.dart';

class SideDrawer extends StatelessWidget {
  //*global scope
  final Map<String, dynamic>? userLoginData;
  SideDrawer(this.userLoginData);

  Widget NavigationButton(IconData icon, String buttonName) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.teal[400],
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
      backgroundColor: Colors.white,
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
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          NavigationButton(Icons.home, 'Home'),
          NavigationButton(Icons.settings, 'Settings'),
          NavigationButton(Icons.logout_outlined, 'logout')
        ],
      ),
    );
  }
}
