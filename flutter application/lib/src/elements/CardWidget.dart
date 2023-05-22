import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../utils/color.dart';
import '../helpers/helper.dart';
import '../models/restaurant.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  Restaurant restaurant;
  String heroTag;

  CardWidget({Key key, this.restaurant, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      margin: EdgeInsets.symmetric(horizontal: 13),

      // margin: EdgeInsets.only(left: 20, right: 4, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Image of the card
          Stack(
            fit: StackFit.loose,
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Hero(
                tag: this.heroTag + restaurant.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: restaurant.image.url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              // Row(
              //   children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              //       decoration: BoxDecoration(
              //           color: restaurant.closed ? Colors.grey : Colors.green,
              //           borderRadius: BorderRadius.circular(24)),
              //       child: restaurant.closed
              //           ? Text(
              //               S.of(context).closed,
              //               style: Theme.of(context).textTheme.caption.merge(
              //                   TextStyle(
              //                       color: Theme.of(context).primaryColor)),
              //             )
              //           : Text(
              //               S.of(context).open,
              //               style: Theme.of(context).textTheme.caption.merge(
              //                   TextStyle(
              //                       color: Theme.of(context).primaryColor)),
              //             ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              //       decoration: BoxDecoration(
              //           color: Helper.canDelivery(restaurant)
              //               ? Colors.green
              //               : Colors.orange,
              //           borderRadius: BorderRadius.circular(24)),
              //       child: Helper.canDelivery(restaurant)
              //           ? Text(
              //               S.of(context).delivery,
              //               style: Theme.of(context).textTheme.caption.merge(
              //                   TextStyle(
              //                       color: Theme.of(context).primaryColor)),
              //             )
              //           : Text(
              //               S.of(context).pickup,
              //               style: Theme.of(context).textTheme.caption.merge(
              //                   TextStyle(
              //                       color: Theme.of(context).primaryColor)),
              //             ),
              //     ),
              //   ],
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        Helper.skipHtml(restaurant.description),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        itemSize: 18,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                kPrimaryColororange,
                                kPrimaryColorLiteorange
                              ],
                            ).createShader(bounds);
                          },
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 60.0,
                          ),
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      // Row(
                      //   children: Helper.getStarsList(
                      //     double.parse(restaurant.rate),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("750m"),
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    kPrimaryColororange,
                                    kPrimaryColorLiteorange
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(100)),
                            child:
                            // Image.asset("assets/img/")
                            Icon(
                              Icons.turn_right_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "AED",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).hintColor,
                              fontSize: 10,
                            ),
                            children: [
                              TextSpan(
                                text: '15-25',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ]),
                      ),
                      Text(
                        "Avg.for one",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      // MaterialButton(
                      //   padding: EdgeInsets.all(0),
                      //   onPressed: () {
                      //     Navigator.of(context).pushNamed('/Pages',
                      //         arguments: new RouteArgument(
                      //             id: '1', param: restaurant));
                      //   },
                      //   child: Icon(Icons.directions,
                      //       color: Theme.of(context).primaryColor),
                      //   color: Theme.of(context).accentColor,
                      //   shape: CircleBorder(),
                      // //   shape: RoundedRectangleBorder(
                      // //       borderRadius: BorderRadius.circular(100)),
                      // ),
                      restaurant.distance > 0
                          ? Text(
                              Helper.getDistance(
                                  restaurant.distance,
                                  Helper.of(context)
                                      .trans(setting.value.distanceUnit)),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            )
                          : SizedBox(height: 0)
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
