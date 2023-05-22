import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../../utils/color.dart';
import '../controllers/home_controller.dart';
import '../elements/CardsCarouselWidget.dart';
import '../elements/CaregoriesCarouselWidget.dart';
import '../elements/FoodsCarouselWidget.dart';
import '../elements/GridWidget.dart';
import '../elements/HomeSliderWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;
import '../repository/user_repository.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;
  var size, height, width;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
            onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: ValueListenableBuilder(
            valueListenable: settingsRepo.setting,
            builder: (context, value, child) {
              return Text(
                "COME EAT HOME" ?? S.of(context).home,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .merge(TextStyle(letterSpacing: 1.3)),
              );
            },
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
          ],
          bottom: TabBar(
            indicatorWeight: 14,

            indicator: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColororange, kPrimaryColorLiteorange],
              ),
              border: Border.all(width: 50.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),

            indicatorPadding: EdgeInsets.only(top: 37),
            // indicator: TabBarGradientIndicator(
            //             gradientColor: [Color(0xff579CFA) , Color(0xff2FDEE7)],
            //             indicatorWidth: 2)),
//             indicator: UnderlineTabIndicator(
// //todo
//                 borderSide: BorderSide(
//                   width: 5.0,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//                 insets: EdgeInsets.symmetric(horizontal: 22.0)),
            // indicatorSize: TabBarIndicatorSize,
            tabs: [
              Text(
                "Dine-In",
                // S.of(context).pickup,
                style: TextStyle(
                    color: settingsRepo.deliveryAddress.value?.address == null
                        ? Theme.of(context).hintColor
                        : Theme.of(context).primaryColor,
                    fontSize: 20),
              ),
              Text(
                S.of(context).delivery,
                style: TextStyle(
                    color: settingsRepo.deliveryAddress.value?.address == null
                        ? Theme.of(context).hintColor
                        : Theme.of(context).primaryColor,
                    fontSize: 20),
              ),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       settingsRepo.deliveryAddress.value?.address = null;
              //     });
              //   },
              //   child: Text(
              //     "Dine-In",
              //     // S.of(context).pickup,
              //     style: TextStyle(
              //         color:settingsRepo.deliveryAddress.value?.address== null ? Theme.of(context).hintColor : Theme.of(context).primaryColor,fontSize: 20),
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     if (currentUser.value.apiToken == null) {
              //       _con.requestForCurrentLocation(context);
              //     }
              //     // else {
              //     //   var bottomSheetController = widget.parentScaffoldKey.currentState.showBottomSheet(
              //     //         (context) => DeliveryAddressBottomSheetWidget(scaffoldKey: widget.parentScaffoldKey),
              //     //     shape: RoundedRectangleBorder(
              //     //       borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              //     //     ),
              //     //   );
              //     //   bottomSheetController.closed.then((value) {
              //     //     _con.refreshHome();
              //     //   });
              //     // }
              //   },
              //   child: Text(
              //     S.of(context).delivery,
              //     style: TextStyle(
              //         color:
              //         settingsRepo.deliveryAddress.value?.address == null ? Theme.of(context).hintColor : Theme.of(context).primaryColor,fontSize: 20),
              //   ),
              // ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Dine In
            RefreshIndicator(
              onRefresh: _con.refreshHome,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         if (currentUser.value.apiToken == null) {
                    //           _con.requestForCurrentLocation(context);
                    //         } else {
                    //           var bottomSheetController = widget.parentScaffoldKey.currentState.showBottomSheet(
                    //                 (context) => DeliveryAddressBottomSheetWidget(scaffoldKey: widget.parentScaffoldKey),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    //             ),
                    //           );
                    //           bottomSheetController.closed.then((value) {
                    //             _con.refreshHome();
                    //           });
                    //         }
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.all(Radius.circular(5)),
                    //           color: settingsRepo.deliveryAddress.value?.address == null
                    //               ? Theme.of(context).focusColor.withOpacity(0.1)
                    //               : Theme.of(context).accentColor,
                    //         ),
                    //         child: Text(
                    //           S.of(context).delivery,
                    //           style: TextStyle(
                    //               color:
                    //               settingsRepo.deliveryAddress.value?.address == null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 7),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           settingsRepo.deliveryAddress.value?.address = null;
                    //         });
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.all(Radius.circular(5)),
                    //           color: settingsRepo.deliveryAddress.value?.address != null
                    //               ? Theme.of(context).focusColor.withOpacity(0.1)
                    //               : Theme.of(context).accentColor,
                    //         ),
                    //         child: Text(
                    //           S.of(context).pickup,
                    //           style: TextStyle(
                    //               color:
                    //               settingsRepo.deliveryAddress.value?.address != null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    //---------------------------end row---------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(
                          settingsRepo.setting.value.homeSections.length,
                          (index) {
                        String _homeSection = settingsRepo
                            .setting.value.homeSections
                            .elementAt(index);
                        switch (_homeSection) {
                          case 'slider':
                            return HomeSliderWidget(slides: _con.slides);
                          case 'search':
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: SearchBarWidget(
                                    onClickFilter: (event) {
                                      widget.parentScaffoldKey.currentState
                                          .openEndDrawer();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 10.5),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            // width:235,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 12,
                                                      spreadRadius: -9)
                                                ]),
                                            child: TextButton(
                                              onPressed: () {
                                                //todo
                                              },
                                              child: GestureDetector(
                                                onTap:  () {
                                                  _openDialog(context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset("assets/img/cuisine.png",height: 25,width: 25,),

                                                    // Image.asset("assets/img/cash.png"),
                                                    // Icon(
                                                    //   Icons.food_bank,
                                                    //   color: Theme.of(context)
                                                    //       .hintColor,
                                                    // ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Cuisine",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Theme.of(context)
                                                              .hintColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.grey.shade100,
                                          thickness: 1,
                                          indent: 0,
                                          width: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            // width:237,

                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 12,
                                                      spreadRadius: -9)
                                                ]),
                                            child: TextButton(
                                              onPressed: () {
                                                //todo
                                              },
                                              child: GestureDetector(
                                                onTap :(){
                                                  _openDialog(context);
                                                  },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Icon(
                                                    //   Icons.location_on_outlined,
                                                    //   color: Theme.of(context)
                                                    //       .hintColor,
                                                    // ),
                                                    Image.asset("assets/img/location.png",height: 25,width: 25,),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Location",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Theme.of(context)
                                                              .hintColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          case 'categories_heading':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                minLeadingWidth: 2,
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                leading: Icon(

                                  Icons.category,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(S.of(context).food_categories,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)
                                    // style: Theme.of(context).textTheme.headline4,
                                    ),
                              ),
                            );
                          case 'categories':
                            return CategoriesCarouselWidget(
                              categories: _con.categories,
                            );
                          case 'trending_week':
                            return FoodsCarouselWidget(
                                foodsList: _con.trendingFoods,
                                heroTag: 'home_food_carousel');

                          case 'categories':
                            return CategoriesCarouselWidget(
                              categories: _con.categories,
                            );
                          case 'top_restaurants_heading':
                            return ListTile(
                              dense: true,
                              minLeadingWidth: 2,

                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              leading:
                              // SvgPicture.asset("assets/img/locationarrow.svg"),
                              Image.asset("assets/img/top-home-kitchen.png",height: 27,width: 27,),
                              // Icon(
                              //   Icons.star,
                              //   color: Theme.of(context).hintColor,
                              // ),
                              title: Text(
                                S.of(context).top_home_kitchens,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                S.of(context)
                                    .clickOnTheFoodToGetMoreDetailsAboutIt,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            );
                          case 'top_restaurants':
                            return CardsCarouselWidget(
                                restaurantsList: _con.topRestaurants,
                                heroTag: 'home_top_restaurants');
                          case 'trending_week_heading':
                            return ListTile(
                              dense: true,
                              minLeadingWidth: 2,

                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              leading: Icon(
                                Icons.trending_up,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                S.of(context).trending_this_week,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                S
                                    .of(context)
                                    .clickOnTheFoodToGetMoreDetailsAboutIt,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            );
                          case 'trending_week':
                            return FoodsCarouselWidget(
                                foodsList: _con.trendingFoods,
                                heroTag: 'home_food_carousel');
                          case 'categories_heading':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                leading: Icon(
                                  Icons.category,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(
                                  S.of(context).food_categories,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            );
                          case 'categories':
                            return CategoriesCarouselWidget(
                              categories: _con.categories,
                            );
                          case 'popular_heading':
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 0),
                              child: ListTile(
                                dense: true,
                                minLeadingWidth: 2,

                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                leading: Icon(
                                  Icons.trending_up,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(S.of(context).most_popular,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                            );
                          case 'popular':
                            return GridWidget(
                              restaurantsList: _con.popularRestaurants,
                              heroTag: 'home_restaurants',
                            );
                          case 'recent_reviews_heading':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                leading: Icon(
                                  Icons.recent_actors,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(
                                  S.of(context).recent_reviews,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            );
                          case 'recent_reviews':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ReviewsListWidget(
                                  reviewsList: _con.recentReviews),
                            );
                          default:
                            return SizedBox(height: 0);
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
            //Delivery
            RefreshIndicator(
              onRefresh: _con.refreshHome,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         if (currentUser.value.apiToken == null) {
                    //           _con.requestForCurrentLocation(context);
                    //         } else {
                    //           var bottomSheetController = widget.parentScaffoldKey.currentState.showBottomSheet(
                    //                 (context) => DeliveryAddressBottomSheetWidget(scaffoldKey: widget.parentScaffoldKey),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: new BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    //             ),
                    //           );
                    //           bottomSheetController.closed.then((value) {
                    //             _con.refreshHome();
                    //           });
                    //         }
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.all(Radius.circular(5)),
                    //           color: settingsRepo.deliveryAddress.value?.address == null
                    //               ? Theme.of(context).focusColor.withOpacity(0.1)
                    //               : Theme.of(context).accentColor,
                    //         ),
                    //         child: Text(
                    //           S.of(context).delivery,
                    //           style: TextStyle(
                    //               color:
                    //               settingsRepo.deliveryAddress.value?.address == null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 7),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           settingsRepo.deliveryAddress.value?.address = null;
                    //         });
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.all(Radius.circular(5)),
                    //           color: settingsRepo.deliveryAddress.value?.address != null
                    //               ? Theme.of(context).focusColor.withOpacity(0.1)
                    //               : Theme.of(context).accentColor,
                    //         ),
                    //         child: Text(
                    //           S.of(context).pickup,
                    //           style: TextStyle(
                    //               color:
                    //               settingsRepo.deliveryAddress.value?.address != null ? Theme.of(context).hintColor : Theme.of(context).primaryColor),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // ---------------------------end row---------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(
                          settingsRepo.setting.value.homeSections.length,
                          (index) {
                        String _homeSection = settingsRepo
                            .setting.value.homeSections
                            .elementAt(index);
                        switch (_homeSection) {
                          case 'slider':
                            return HomeSliderWidget(slides: _con.slides);
                          case 'search':
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SearchBarWidget(
                                    onClickFilter: (event) {
                                      widget.parentScaffoldKey.currentState
                                          .openEndDrawer();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10.5),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            // width:235,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 12,
                                                      spreadRadius: -9)
                                                ]),
                                            child: TextButton(
                                              onPressed: () {
                                                //todo
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.food_bank,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Cuisine",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Theme.of(context)
                                                            .hintColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color: Colors.grey.shade100,
                                          thickness: 1,
                                          indent: 0,
                                          width: 2,
                                        ),
                                        Expanded(
                                          child: Container(
                                            // width:237,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4)),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey,
                                                      blurRadius: 12,
                                                      spreadRadius: -9)
                                                ]),
                                            child: TextButton(
                                              onPressed: () {
                                                //todo
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Location",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Theme.of(context)
                                                            .hintColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          case 'categories_heading':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                                leading: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.category,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                title: Text(S.of(context).food_categories,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)
                                    // style: Theme.of(context).textTheme.headline4,
                                    ),
                              ),
                            );
                          case 'categories':
                            return CategoriesCarouselWidget(
                              categories: _con.categories,
                            );
                          case 'trending_week':
                            return FoodsCarouselWidget(
                                foodsList: _con.trendingFoods,
                                heroTag: 'home_food_carousel');

                          case 'categories':
                            return CategoriesCarouselWidget(
                              categories: _con.categories,
                            );
                          case 'top_restaurants_heading':
                            return ListTile(
                              dense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              leading: Icon(
                                Icons.star,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                S.of(context).top_home_kitchens,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            );
                          case 'top_restaurants':
                            return CardsCarouselWidget(
                                delivery: true,
                                restaurantsList: _con.topRestaurants,
                                heroTag: 'home_top_restaurants');
                          case 'trending_week_heading':
                            return ListTile(
                              dense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                              leading: Icon(
                                Icons.trending_up,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                S.of(context).trending_this_week,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                S
                                    .of(context)
                                    .clickOnTheFoodToGetMoreDetailsAboutIt,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            );
                          case 'trending_week':
                            return FoodsCarouselWidget(
                                foodsList: _con.trendingFoods,
                                heroTag: 'home_food_carousel');
                          case 'categories_heading':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                leading: Icon(
                                  Icons.category,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(
                                  S.of(context).food_categories,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            );
                          case 'categories':
                            return CategoriesCarouselWidget(
                              categories: _con.categories,
                            );
                          case 'popular_heading':
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 0),
                                leading: Icon(
                                  Icons.trending_up,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(S.of(context).most_popular,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500)),
                              ),
                            );
                          case 'popular':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GridWidget(
                                restaurantsList: _con.popularRestaurants,
                                heroTag: 'home_restaurants',
                              ),
                            );
                          case 'recent_reviews_heading':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 20),
                                leading: Icon(
                                  Icons.recent_actors,
                                  color: Theme.of(context).hintColor,
                                ),
                                title: Text(
                                  S.of(context).recent_reviews,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            );
                          case 'recent_reviews':
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ReviewsListWidget(
                                  reviewsList: _con.recentReviews),
                            );
                          default:
                            return SizedBox(height: 0);
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
List checkListItems = [
  {
    "id": 0,
    "value": false,
    "title": "Sunday",
  },
  {
    "id": 1,
    "value": false,
    "title": "Monday",
  },
  {
    "id": 2,
    "value": false,
    "title": "Tuesday",
  },
  {
    "id": 3,
    "value": false,
    "title": "Wednesday",
  },
  {
    "id": 4,
    "value": false,
    "title": "Thursday",
  },
  {
    "id": 5,
    "value": false,
    "title": "Friday",
  },
  {
    "id": 6,
    "value": false,
    "title": "Saturday",
  },
];
   _openDialog(BuildContext context) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          title: Column(
            children: [
              Text('Select Cuisine'),

            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 1,
                child:  Container(
                  height: 34,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: -8,
                        blurRadius: 10,
                        // offset: Offset(0, 3), // changes the shadow position
                      ),
                    ],
                  ),
                  child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(

                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10
                          ),
                          prefixIcon: Icon(Icons.search)
                      ),
                    ),
                ),
                ),
              
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),

                width:  MediaQuery.of(context).size.width/3,
                height: MediaQuery.of(context).size.height/3,
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) => CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      checkListItems[index]["title"],
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    value: checkListItems[index]["value"],
                    onChanged: (value) {

                        for (var element in checkListItems) {
                          element["value"] = false;
                        }
                        checkListItems[index]["value"] = value;
                        // selected =
                        // "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";

                    },
                  ),
                  // const SizedBox(height: 100.0),
                  // Text(
                  //   selected,
                  //   style: const TextStyle(
                  //     fontSize: 22.0,
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Apply'),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            )

          ],
        );
      },
    );
  }
