import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check All Animations'),
      ),
      body: Center(
        child: Column(
          children: [
            OpenContainerButton(),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OpenContainerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 5.0,
      transitionType: ContainerTransitionType.fade,
      openColor: Colors.green,
      openElevation: 5.0,
      closedColor: Colors.yellow,
      closedBuilder: (context, action) {
        return TextButton(
          onPressed: action,
          child: Text('Open Container'),
        );
      },
      openBuilder: (context, action) {
        return Scaffold(
          appBar: AppBar(title: Text('Opened Container')),
          body: Center(child: Text('Here is the opened container!')),
        );
      },
      transitionDuration: Duration(milliseconds: 700),
    );
  }
}
