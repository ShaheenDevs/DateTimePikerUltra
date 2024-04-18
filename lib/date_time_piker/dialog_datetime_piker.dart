// ignore_for_file: must_be_immutable
import 'package:date_time_piker_plus/date_time_piker/time_piker.dart';
import 'package:flutter/material.dart';

import 'date_piker.dart';

class DateTimePickerPlusDialog extends StatefulWidget {
  Color color;
  Color iconColor;
  Color textColor;
  bool showDatePiker;
  String title;
  Widget? titleWidget;
  bool showTimePiker;
  Function(DateTime)? onChangeDate;
  Function(DateTime)? onChangeTime;
  Function(DateTime)? onPress;
  double borderRadius;
  double textBoxwidth;
  DateTime selectedDate;
  TimeOfDay initialTime;

  DateTimePickerPlusDialog({
    super.key,
    this.showDatePiker = true,
    this.showTimePiker = true,
    this.title = 'Tap here to open Date Time dropdown',
    this.titleWidget,
    this.onChangeDate,
    this.onChangeTime,
    this.onPress,
    this.iconColor = Colors.grey,
    this.color = Colors.orangeAccent,
    this.textColor = Colors.black,
    this.borderRadius = 2,
    this.textBoxwidth = 60,
    DateTime? selectedDate,
    TimeOfDay? initialTime,
  })  : selectedDate = selectedDate ?? DateTime.now(),
        initialTime = initialTime ?? TimeOfDay.now() {
    // Set the default value for initialTime if it's not provided
    // This code executes in the constructor body
    // This approach ensures the object is fully initialized
  }

  @override
  State<DateTimePickerPlusDialog> createState() =>
      _DateTimePickerPlusDialogState();
}

class _DateTimePickerPlusDialogState extends State<DateTimePickerPlusDialog> {
  OverlayEntry? _overlayEntry;

  DateTime mergeDateTimeAndTimeOfDay() {
    DateTime dateTime = widget.selectedDate;
    TimeOfDay timeOfDay = widget.initialTime;
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }

  _toggleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsPadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(6),
        content: SizedBox(
          width: 300,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize
                    .min, // Set the size of the column to the minimum
                children: [
                  if (widget.showTimePiker)
                    TimeSelectorPlus(
                      selectedHour: (widget.initialTime.hour % 12) + 1,
                      selectedMint: widget.initialTime.minute,
                      isAm: widget.initialTime.hour <= 12,
                      iconColor: widget.iconColor,
                      color: widget.color,
                      textColor: widget.textColor,
                      borderRadius: widget.borderRadius,
                      textBoxwidth: widget.textBoxwidth,
                      onChange: (TimeOfDay time) {
                        setState(() {
                          widget.initialTime = time;
                        });
                        if (widget.onChangeTime != null) {
                          DateTime dateTime = mergeDateTimeAndTimeOfDay();
                          widget.onChangeTime!(dateTime);
                        }
                      },
                    ),
                  if (widget.showDatePiker)
                    DatePickerPlus(
                      selectedDate: widget.selectedDate,
                      onChange: (DateTime date) {
                        setState(() {
                          widget.selectedDate = date;
                        });
                        if (widget.onChangeDate != null) {
                          DateTime dateTime = mergeDateTimeAndTimeOfDay();
                          widget.onChangeDate!(dateTime);
                        }
                      },
                    )
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.onPress != null) {
                          DateTime dateTime = mergeDateTimeAndTimeOfDay();
                          widget.onPress!(dateTime);
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleDialog(context),
      child: widget.titleWidget != null
          ? widget.titleWidget!
          : Container(
              color: Colors.transparent,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
