import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../my_widget/people_count_dailog.dart';

import '../src/models/restaurant.dart';
import '../src/models/route_argument.dart';
import '../utils/color.dart';

class CalendarDialog extends StatefulWidget {
  @override
  _CalendarDialogState createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  DateTime _selectedDate = DateTime.now();
  DateTime _firstDay = DateTime(2023, 1, 1);
  DateTime _lastDay = DateTime(2023, 12, 31);
  DateTime _focusedDay = DateTime.now();
  List<Restaurant> restaurantsList;
  String heroTag;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _firstDay = DateTime(2023, 1, 1);
    _lastDay = DateTime(2023, 12, 31);
    _focusedDay = _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 4,bottom: 18,left: 8,right: 8),
      titlePadding: EdgeInsets.only(top: 18,left: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Icon(Icons.food_bank),
          SizedBox(
            width: 12,
          ),
          Image.asset("assets/img/cuisine.png",height: 27,width: 27,),
          SizedBox(
            width: 16,
          ),
          Text('Schedule Dine-in',style: TextStyle(color: Theme.of(context).hintColor),),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          SizedBox(
            width:  MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.7,
            child: TableCalendar(

              shouldFillViewport: true,
              rowHeight: 30,
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (date) {
                return isSameDay(_selectedDate, date);
              },
              onDaySelected: (date, _) {
                setState(() {
                  _selectedDate = date;
                });

              },

              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                TextStyle(fontSize: 18, ),
                leftChevronIcon: Icon(Icons.chevron_left,color: kPrimaryColorLiteorange, ),
                rightChevronIcon: Icon(Icons.chevron_right,color: kPrimaryColorLiteorange,),
              ),
              calendarStyle: CalendarStyle(
                canMarkersOverflow: false,
                cellPadding: EdgeInsets.all(0),
                cellMargin: EdgeInsets.all(0),
                selectedDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kPrimaryColororange, kPrimaryColorLiteorange],
                  ),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColororange, kPrimaryColorLiteorange],
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: ElevatedButton(
              onPressed: () {
                //todo
                Navigator.pop(context);
                showProductListDialog(context);
                // Navigator.of(context).pushNamed('/Details',
                //     arguments: RouteArgument(
                //       id: '0',
                //       param: restaurantsList.elementAt,
                //       heroTag: heroTag,
                //     ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}

// Usage
void showCalendarDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CalendarDialog();
    },
  );
}
