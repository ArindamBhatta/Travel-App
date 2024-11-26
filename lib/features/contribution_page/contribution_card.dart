import 'package:flutter/material.dart';

class SpecificUserDetailsFromCommunity extends StatelessWidget {
  final String imageUri;
  final String country;
  final String location;
  final String state;
  SpecificUserDetailsFromCommunity({
    super.key,
    required this.imageUri,
    required this.country,
    required this.location,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Card(
        color: Colors.white,
        elevation: 1.5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(
            color: Color.fromARGB(255, 13, 13, 13),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: width * 0.4,
              height: height * 0.2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/bookmark_img_6.jpg',
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  state,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/* 
CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imageUri,
              imageBuilder: (context, imageProvider) => Container(
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const SizedBox(
                height: 200.0,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.black,
                  ),
                ),
              ),
              errorWidget: (context, url, error) {
                debugPrint('Image failed to load: $url, Error: $error');
                return const Icon(Icons.error, size: 50);
              },
            ),


 */