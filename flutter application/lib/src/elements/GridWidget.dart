import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../elements/GridItemWidget.dart';
import '../models/restaurant.dart';
import '../models/route_argument.dart';
import 'CardsCarouselLoaderWidget.dart';

class GridWidget extends StatelessWidget {
  final List<Restaurant> restaurantsList;
  final String heroTag;

  GridWidget({Key key, this.restaurantsList, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return  restaurantsList.isEmpty
        ? CardsCarouselLoaderWidget()
        : Container(
      height: 288,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restaurantsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/Details',
                  arguments: RouteArgument(
                    id: '0',
                    param: restaurantsList.elementAt(index).id,
                    heroTag: heroTag,
                  ));
            },
            child: GridItemWidget(
              restaurant: restaurantsList.elementAt(index),
              heroTag: heroTag,
            ),
          );
        },
      ),
    );
    //   new StaggeredGridView.countBuilder(
    //   primary: false,
    //   shrinkWrap: true,
    //   crossAxisCount: 4,
    //   itemCount: restaurantsList.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return GridItemWidget(
    //         restaurant: restaurantsList.elementAt(index), heroTag: heroTag);
    //   },
    //   staggeredTileBuilder: (int index) => new StaggeredTile.fit(
    //       MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4),
    //   mainAxisSpacing: 15.0,
    //   crossAxisSpacing: 15.0,
    // );
  }
}
