import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'All Contributors Data',
          ),
        ),
      ),
      body: Center(
        child: Row(
          children: [
            Text(
              'Hello',
            ),
          ],
        ),
      ),
    );
  }
}
