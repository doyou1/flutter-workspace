import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:todolist_youtube/utils/utils.dart';
import 'package:todolist_youtube/widgets/widgets.dart';
import 'package:todolist_youtube/providers/providers.dart';
import 'package:intl/intl.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    return Row(
      children: [
        Expanded(
            child: CommonTextField(
                title: "Date",
                hintText: DateFormat.yMMMd().format(date),
                readOnly: true,
                suffixIcon: IconButton(
                    onPressed: () => _selectDate(context, ref),
                    icon: FaIcon(FontAwesomeIcons.calendar)))),
        Gap(10),
        Expanded(
            child: CommonTextField(
                title: "Time",
                hintText: Helpers.timeToString(time),
                readOnly: true,
                suffixIcon: IconButton(
                    onPressed: () => _selectTime(context, ref),
                    icon: FaIcon(FontAwesomeIcons.clock)))),
      ],
    );
  }
}

void _selectDate(BuildContext context, WidgetRef ref) async {
  final initialDate = ref.read(dateProvider); // get
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2090));
  if (pickedDate != null) {
    ref.read(dateProvider.notifier).state = pickedDate;
  }
}

void _selectTime(BuildContext context, WidgetRef ref) async {
  final initialTime = ref.read(timeProvider); // get
  TimeOfDay? pickedTime =
      await showTimePicker(context: context, initialTime: initialTime);
  if (pickedTime != null) {
    ref.read(timeProvider.notifier).state = pickedTime;
  }
}
