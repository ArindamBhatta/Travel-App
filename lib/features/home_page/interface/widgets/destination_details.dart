import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  final GlobalKey contentKey = GlobalKey();
  double maxChildSize = 0.6; // Initial maxChildSize value

  @override
  void initState() {
    super.initState();
    bookmark = widget.bookmark;

    // Measure content height after 1st rendering using addPostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateMaxChildSize();
    });
  }

  void updateMaxChildSize() {
    final RenderBox? renderBox =
        contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final double contentHeight = renderBox.size.height;

      final double screenHeight = MediaQuery.of(context).size.height;

      // Calculate maxChildSize based on content height
      final double calculatedMaxChildSize = contentHeight / screenHeight;
      setState(
        () {
          maxChildSize = calculatedMaxChildSize.clamp(
              0.4, 1.0); // Clamp to ensure valid range
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: '${widget.imageUri}',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
                color: bookmark ? Colors.red : Colors.white,
              ),
              onPressed: () {
                widget.toggleInFireStore();
                setState(() => bookmark = !bookmark);
              },
            ),
          ),
          // Draggable Scrollable Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.3,
            maxChildSize: maxChildSize,
            builder: (context, scrollController) {
              return Container(
                key: contentKey, // Key to measure content height
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
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
                          .map((tag) => Chip(label: Text(tag)))
                          .toList(),
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
