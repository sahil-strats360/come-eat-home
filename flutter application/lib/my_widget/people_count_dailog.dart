import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../src/models/restaurant.dart';
import '../src/models/route_argument.dart';
import '../utils/color.dart';

class People_count_Dailog extends StatefulWidget {
  @override
  _People_count_DailogState createState() => _People_count_DailogState();
}

class _People_count_DailogState extends State<People_count_Dailog> {
  List<ProductItem> _products = [
    ProductItem(name: 'Adults', subtitle: "Ages 13 or above",quantity: 0),
    ProductItem(name: 'Children',subtitle: 'Ages 2-12', quantity: 0),
    ProductItem(name: 'Infants',subtitle: "Under 2", quantity: 0),
    ProductItem(name: 'Pets',subtitle: 'Bringing a service animal?', quantity: 0),

  ];

  List<Restaurant> restaurantsList;
  String heroTag;
  void _incrementQuantity(int index) {
    setState(() {
      _products[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_products[index].quantity > 0) {
        _products[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 4,bottom: 18,left: 8,right: 8),
      titlePadding: EdgeInsets.only(top: 18,left: 26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        children: [
          // Icon(Icons.people_alt_outlined,color:Theme.of(context).hintColor ,),
          Image.asset("assets/img/whoiscoming.png",height: 27,width: 27,),
          SizedBox(width: 8,),
          Text(
            'Who’s coming?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color:  Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ..._products
                      .map(
                        (product) => ListTile(

                          dense: true,
                          // isThreeLine: true,

                          title: Text(product.name),
                          subtitle: Text(product.subtitle),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // IconButton(
                              //   icon: Icon(Icons.remove),
                              //   onPressed: () =>
                              //       _decrementQuantity(_products.indexOf(product)),
                              // ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Theme.of(context).hintColor),
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: () => _decrementQuantity(_products.indexOf(product)),
                                  child: Icon(
                                    Icons.remove,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Text(product.quantity.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Theme.of(context).hintColor),
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: () => _incrementQuantity(_products.indexOf(product)),
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.add),
                              //   onPressed: () =>
                              //       _incrementQuantity(_products.indexOf(product)),
                              // ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  SizedBox(height: 16),

                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 10,right: 10,),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimaryColororange, kPrimaryColorLiteorange],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    //todo
                    // showProductListDialog(context);
                    Navigator.of(context).pushNamed('/Details',
                        arguments: RouteArgument(
                          id: '0',
                          param: restaurantsList.map((e) => e.id.toString()),
                          heroTag: heroTag,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String subtitle;
  int quantity;

  ProductItem({this.name,this.subtitle, this.quantity});
}

void showProductListDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return People_count_Dailog();
    },
  );
}
