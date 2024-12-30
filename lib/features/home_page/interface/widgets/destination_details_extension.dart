import 'package:flutter/material.dart';

class DestinationDetailsExtension extends StatelessWidget {
  final String? name;
  final String? knowFor;
  final String? country;
  final String? continent;
  final List<String>? viewPoints;
  DestinationDetailsExtension({
    required this.name,
    required this.knowFor,
    required this.country,
    required this.continent,
    required this.viewPoints,
  });

  Widget infoAboutTrip(
    IconData icon,
    Color color,
    String textOfInfo,
    String infoText,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              textOfInfo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Text(infoText),
      ],
    );
  }

  Widget tabBarButton(bool isSelected, String buttonText) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.teal[500] : Colors.white,
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DraggableScrollableSheet(
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$country , $continent',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 36,
                          child: TabBar(
                            labelPadding: EdgeInsets.symmetric(horizontal: 2),
                            dividerColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            indicator: BoxDecoration(),
                            tabs: [
                              Tab(
                                child: Builder(
                                  builder: (context) {
                                    final TabController controller =
                                        DefaultTabController.of(context);
                                    return AnimatedBuilder(
                                      animation: controller,
                                      builder: (context, _) {
                                        final isSelected =
                                            controller.index == 0;
                                        return tabBarButton(
                                          isSelected,
                                          'Description',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Tab(
                                iconMargin: null,
                                child: Builder(
                                  builder: (context) {
                                    final TabController controller =
                                        DefaultTabController.of(context);
                                    return AnimatedBuilder(
                                      animation: controller,
                                      builder: (context, _) {
                                        final isSelected =
                                            controller.index == 1;
                                        return tabBarButton(
                                          isSelected,
                                          'Tags',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Tab(
                                child: Builder(
                                  builder: (context) {
                                    final TabController controller =
                                        DefaultTabController.of(context);
                                    return AnimatedBuilder(
                                      animation: controller,
                                      builder: (context, _) {
                                        final isSelected =
                                            controller.index == 2;
                                        return tabBarButton(
                                          isSelected,
                                          'user info',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 140,
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          '$knowFor',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          infoAboutTrip(
                                            Icons.watch_later,
                                            Colors.red,
                                            '2 Days',
                                            "Duration",
                                          ),
                                          infoAboutTrip(
                                            Icons.location_on,
                                            Colors.green,
                                            '100 KM',
                                            "Distance",
                                          ),
                                          infoAboutTrip(
                                            Icons.wb_sunny_rounded,
                                            Colors.yellow,
                                            "13 °C",
                                            "Weather",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    '$knowFor',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width:
                                                50.0, // Set the desired width
                                            height:
                                                50.0, // Set the desired height
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                'avatar',
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'name',
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'email',
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Book Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
