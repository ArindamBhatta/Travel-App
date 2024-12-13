import 'package:flutter/material.dart';

class SpecificationList extends StatelessWidget {
  final Map<String, dynamic> data;
  SpecificationList(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${data['avatar']}',
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    '${data['email']}',
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
