import 'package:flutter/material.dart';

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
                Container(
                  decoration: IconDecoration(
                    iconSize: iconSize,
                    lineWidth: 1,
                    firstData: index == 0,
                    lastData: index == _eventList.length - 1,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            color: Color(0x20000000),
                            blurRadius: 5)
                      ],
                    ),
                    child: Icon(
                        _eventList[index].isFinish
                            ? Icons.fiber_manual_record
                            : Icons.radio_button_unchecked,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Container(
                  width: 70,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(_eventList[index].time),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x20000000),
                              blurRadius: 5,
                              offset: Offset(0, 3))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_eventList[index].task),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(_eventList[index].desc),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class IconDecoration extends Decoration {
  final double iconSize;
  final double lineWidth;
  final bool firstData;
  final bool lastData;

  const IconDecoration({
    required double iconSize,
    required double lineWidth,
    required bool firstData,
    required bool lastData,
  })  : this.iconSize = iconSize,
        this.lineWidth = lineWidth,
        this.firstData = firstData,
        this.lastData = lastData;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return IconLine(
        iconSize: iconSize,
        lineWidth: lineWidth,
        firstData: firstData,
        lastData: lastData);
  }
}

class IconLine extends BoxPainter {
  final double iconSize;
  final bool firstData;
  final bool lastData;

  final Paint paintLine;

  IconLine({
    required double iconSize,
    required double lineWidth,
    required bool firstData,
    required bool lastData,
  })  : this.iconSize = iconSize,
        this.firstData = firstData,
        this.lastData = lastData,
        paintLine = Paint()
          ..color = Colors.red
          ..strokeCap = StrokeCap.round
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // TODO: implement paint
    final leftOffset = Offset((iconSize / 2) + 24, offset.dy);
    final Offset top = configuration.size!.topLeft(Offset(leftOffset.dx, 0.0));
    final Offset centerTop =
        configuration.size!.centerLeft(Offset(leftOffset.dx, leftOffset.dy));

    final Offset centerBottom =
        configuration.size!.centerLeft(Offset(leftOffset.dx, leftOffset.dy));
    final Offset end = configuration.size!
        .bottomLeft(Offset(leftOffset.dx, leftOffset.dy * 2));

    if (!firstData) canvas.drawLine(top, centerTop, paintLine);
    if (!lastData) canvas.drawLine(centerBottom, end, paintLine);
  }
}
