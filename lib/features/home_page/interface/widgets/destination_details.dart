import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';

class DestinationDetails extends StatefulWidget {
  final String? imageUri;
  final String? name;
  final String? knowFor;
  final String? country;
  final String? continent;
  final List<String>? viewPoints;
  final bool bookmark;
  final void Function() toggleInFireStore;

  const DestinationDetails({
    super.key,
    required this.imageUri,
    required this.name,
    required this.knowFor,
    required this.country,
    required this.continent,
    required this.viewPoints,
    required this.bookmark,
    required this.toggleInFireStore,
  });

  @override
  State<DestinationDetails> createState() => _DestinationDetailsState();
}

class _DestinationDetailsState extends State<DestinationDetails> {
  bool bookmark = false;
  @override
  void initState() {
    bookmark = widget.bookmark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: '${widget.imageUri}',
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(255, 254, 189, 184),
                      BlendMode.colorBurn,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.black,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          // Arrow Icon
          Positioned(
            top: 60,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Heart Icon
          Positioned(
            top: 60,
            right: 20,
            child: InkWell(
              onTap: () {
                widget.toggleInFireStore();
                setState(
                  () {
                    bookmark = !bookmark;
                  },
                );
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(50),
                ),
                child: Icon(
                  Icons.favorite,
                  size: 20,
                  color: bookmark == true ? Colors.red : Colors.white,
                ),
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.4,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  controller: scrollController,
                  children: [
                    Text(
                      '${widget.name}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      '${widget.country}, ${widget.continent}',
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Text('${widget.knowFor}'),
                    SizedBox(
                      height: 16.0,
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: widget.viewPoints!.map(
                        (tag) {
                          return Chip(
                            padding: EdgeInsets.all(4),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  tagsIcon(tag),
                                  size: 16.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  tag,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
