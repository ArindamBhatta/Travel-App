import 'package:flutter/material.dart';
import 'package:travel_app/destination_page/destination_description.dart';

class DestinationPage extends StatefulWidget {
  @override
  State<DestinationPage> createState() {
    return _DestinationPageState();
  }
}

class _DestinationPageState extends State<DestinationPage> {
  bool isToggleBookMark = false;

  void toggleIcon() {
    setState(() {
      isToggleBookMark = !isToggleBookMark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: isToggleBookMark
                ? Icon(
                    Icons.favorite,
                    color: Colors.blue,
                  )
                : Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
            onPressed: toggleIcon,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: Image.asset(
              'assets/images/travel_img_5.jpg',
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DestinationDescription(),
            ),
          ),
        ],
      ),
    );
  }
}
