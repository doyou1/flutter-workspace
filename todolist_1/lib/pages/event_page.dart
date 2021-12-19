import 'package:flutter/material.dart';
import 'package:todolist_1/widgets/custom_icon_decoration.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class Event {
  final String time;
  final String task;
  final String desc;
  final bool isFinish;

  const Event(this.time, this.task, this.desc, this.isFinish);
}

final List<Event> _eventList = [
  const Event("08:00", "Call Tom about appointment", "Personal", true),
  const Event("10:00", "Fix onboarding experience", "Personal", true),
  const Event("12:00", "Edit API documentation", "Work", false),
  const Event("14:00", "Setup user focus group", "Work", false),
  const Event("16:00", "Have coffe with Sam", "Personal", false),
  const Event("18:00", "Meet with sales", "Personal", false),
];

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 20;

    return ListView.builder(
        itemCount: _eventList.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Row(
              children: <Widget>[
                _lineStyle(context, iconSize, index, _eventList.length,
                    _eventList[index].isFinish),
                _displayTime(_eventList[index].time),
                _displayContent(_eventList[index]),
              ],
            ),
          );
        });
  }

  Expanded _displayContent(Event event) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x20000000), blurRadius: 5, offset: Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(event.task),
              const SizedBox(
                height: 12,
              ),
              Text(event.desc),
            ],
          ),
        ),
      ),
    );
  }

  Container _displayTime(String time) {
    return Container(
      width: 70,
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(time),
    );
  }

  Container _lineStyle(BuildContext context, double iconSize, int index,
      int listLength, bool isFinish) {
    return Container(
      decoration: CustomIconDecoration(
        iconSize: iconSize,
        lineWidth: 1,
        firstData: index == 0,
        lastData: index == listLength - 1,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3), color: Color(0x20000000), blurRadius: 5)
          ],
        ),
        child: Icon(
            isFinish ? Icons.fiber_manual_record : Icons.radio_button_unchecked,
            size: 20,
            color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
