import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_app/features/home_page/module/data/home_page_provider.dart';
import 'dart:async';

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
  final GlobalKey<State<StatefulWidget>> columnHeightContainerKey = GlobalKey();

  double maxChildSize = 1.0; // Maximum size of sheet
  double initialChildSize = 0.4; // Start at 40% height

  @override
  void initState() {
    super.initState();
    bookmark = widget.bookmark;

    // Measure content height after 1st rendering using addPostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        updateMaxChildSize();
      },
    );

    check();

//  after UI rendering DraggableScrollableSheet bottom sheet move down slowly
  }

  void check() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        if (mounted) {
          setState(() {
            initialChildSize = 0.04; // end at 4% height.
          });
        }
      },
    );
  }

  void updateMaxChildSize() {
    final RenderBox? renderBox = columnHeightContainerKey.currentContext
        ?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final double contentHeight = renderBox.size.height; //variable

      final double screenHeight = MediaQuery.of(context).size.height; //constant

      // Calculate maxChildSize based on content height
      final double calculatedMaxChildSize = contentHeight / screenHeight;

      setState(
        () {
          maxChildSize =
              calculatedMaxChildSize.clamp(0.4, 1.0); // ensure valid range
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('--------------------------- || ------------------');
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            //enable pan and zoom in child
            child: InteractiveViewer(
              constrained: false,
              alignment: Alignment.center,
              child: ConstrainedBox(
                //give desire height to child
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: CachedNetworkImage(
                  imageUrl: '${widget.imageUri}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 60,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Bookmark Button
          Positioned(
            top: 60,
            right: 20,
            child: IconButton(
              icon: Icon(
                bookmark ? Icons.favorite : Icons.favorite_border,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () {
                widget.toggleInFireStore();
                setState(() => bookmark = !bookmark);
              },
            ),
          ),
          // Draggable Scrollable Sheet
          TweenAnimationBuilder(
            duration: Duration(seconds: 10),
            curve: Curves.easeOut,
            tween: Tween(begin: 0.4, end: initialChildSize),
            builder: (context, animatedChildSize, child) {
              return DraggableScrollableSheet(
                initialChildSize: animatedChildSize,
                minChildSize: 23 / MediaQuery.of(context).size.height,
                maxChildSize: maxChildSize,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        key: columnHeightContainerKey,
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Key to measure content height
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Center(
                              child: Container(
                                height: 7,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${widget.name}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${widget.country}, ${widget.continent}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 16),
                          Text('${widget.knowFor}'),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: widget.viewPoints!
                                .map(
                                  (tag) => Chip(
                                    label: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(tagsIcon(tag)),
                                        SizedBox(width: 4),
                                        Text(tag),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
