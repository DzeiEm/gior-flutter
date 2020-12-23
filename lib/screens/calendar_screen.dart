import 'package:flutter/material.dart';
import 'package:gior/data/holidays_dates.dart';
import 'package:gior/model/procedure.dart';
import 'package:gior/providers/procedures.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '/calendar-screen';

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<Procedures>(context);
    int length = events.procedures.length;
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: [
            CalendarContainer(),
            SizedBox(
              height: 20,
            ),
            _buildListContainer(length),
          ],
        ),
      ),
    );
  }
}

class CalendarContainer extends StatefulWidget {
  @override
  _CalendarContainerState createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  CalendarController _calendarController;
  final _selectedDay = DateTime.now();
  List _selectedEvents;
  Map<DateTime, List<Procedure>> _events = {};

  @override
  void initState() {
    _calendarController = CalendarController();
    _selectedEvents = _events[_selectedDay];
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  _onDaySelected(DateTime date, List events, List holidays) {
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.tealAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: SingleChildScrollView(
        child: TableCalendar(
          calendarController: _calendarController,
          startingDayOfWeek: StartingDayOfWeek.monday,
          initialCalendarFormat: CalendarFormat.month,
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonTextStyle: TextStyle(
              color: Colors.white,
            ),
            formatButtonDecoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(20)),
            formatButtonShowsNext: false,
          ),
          initialSelectedDay: DateTime.now(),
          onDaySelected: _onDaySelected,
          events: _events,
        ),
      ),
    );
  }
}

Widget _buildListContainer(int length) {
  bool _isEmpty = true;

  return Expanded(
    flex: 1,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        itemBuilder: (ctx, index) => ListTile(
          title: Text(_isEmpty ? 'Iam ready to you' : 'Sorry, I am busy'),
          leading: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.green[200],
            child: Text('1'),
          ),
          trailing:
              _isEmpty ? Icon(Icons.beach_access) : Icon(Icons.event_busy),
        ),
        itemCount: length,
      ),
    ),
  );
}
