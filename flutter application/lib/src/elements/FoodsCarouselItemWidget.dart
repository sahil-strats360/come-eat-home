import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../helpers/helper.dart';
import '../models/food.dart';
import '../models/route_argument.dart';

class FoodsCarouselItemWidget extends StatelessWidget {
  final double marginLeft;
  final Food food;
  final String heroTag;

  FoodsCarouselItemWidget({Key key, this.heroTag, this.marginLeft, this.food})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed('/Food',
            arguments: RouteArgument(id: food.id, heroTag: heroTag));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: heroTag + food.id,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 13),

                  // margin: EdgeInsetsDirectional.only(
                  //     start: this.marginLeft, end: 20),
                  width: 130,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: food.image.thumb,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 25, top: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    gradient: LinearGradient(colors: [
                      kPrimaryColororange,
                      kPrimaryColorLiteorange,
                    ])
                    // color: food.discountPrice > 0
                    //     ? Colors.red
                    //     : Theme.of(context).accentColor,
                    ),
                alignment: AlignmentDirectional.topEnd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    RichText(
                      text: TextSpan(
                          text: "AED",
                          style: TextStyle(
                            // color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 8,
                          ),
                          children: [
                            TextSpan(
                              text: '15-25',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ]),
                    ),
                    Text(
                      "Avg.for one",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
                // child: Helper.getPrice(
                //   // food.price,
                //   10,
                //   context,
                //   style:Theme.of(context)
                //       .textTheme
                //       .bodyText1
                //       .merge(TextStyle(color: Theme.of(context).primaryColor)),
                // ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 100,

              margin:
                  EdgeInsetsDirectional.only(start: this.marginLeft, end: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    // this.food.name,
                    "Hydrabad...",
                    textAlign: TextAlign.start,

                    overflow: TextOverflow.fade,
                    softWrap: false,
                    // style: Theme.of(context).textTheme.bodyText2,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    // food.restaurant.name,
                    "Al Barsha",
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(fontWeight: FontWeight.w400),

                    // style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
