import 'package:flutter/material.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage();

  @override
  State<SearchBarPage> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarPage>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0), // Start from the bottom
      end: Offset(0, 0.2), // End at the current position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleWidgets() {
    if (isExpanded == true) {
      _controller.reverse(); // Animate in
    } else {
      _controller.forward(); // Animate out
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Animated Bottom Portion
            if (isExpanded == false)
              SlideTransition(
                position: _slideAnimation,
                child: Container(
                  key: ValueKey<int>(1),
                  width: double.infinity,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            //* Second Container (large)
            if (isExpanded == true)
              SlideTransition(
                position: _slideAnimation,
                child: Container(
                  key: ValueKey<int>(2),
                  width: double.infinity,
                  height: 700,
                  color: Colors.green,
                ),
              ),
            // Toggle Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _toggleWidgets,
                child: Text('Toggle Widgets'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/* 
/* 






Container(
      height: 120,
      color: Colors.white30,
      child: 
    TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal[400]!),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        labelText: Icons.search,
       
        suffixIcon: Icons.tune_outlined,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    
    
   
    );
 */
 */