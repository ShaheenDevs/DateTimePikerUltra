// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'time_piker.dart';
import 'date_piker.dart';

class DateTimePickerUltraDialog extends StatefulWidget {
  Color color;
  Color iconColor;
  Color dialogBoxColor;
  bool showDatePicker;
  String title;
  Widget? titleWidget;
  bool showTimePicker;
  Function(DateTime)? onChangeDate;
  Function(DateTime)? onChangeTime;
  Function(DateTime)? onPress;
  double borderRadius;
  double textBoxwidth;
  DateTime selectedDate;
  TimeOfDay initialTime;

  DateTimePickerUltraDialog({
    super.key,
    this.showDatePicker = true,
    this.showTimePicker = true,
    this.title = 'Tap here to open Date Time Dialog',
    this.titleWidget,
    this.onChangeDate,
    this.onChangeTime,
    this.onPress,
    this.iconColor = Colors.grey,
    this.color = Colors.orangeAccent,
    this.dialogBoxColor = Colors.white,
    this.borderRadius = 6,
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
  State<DateTimePickerUltraDialog> createState() =>
      _DateTimePickerUltraDialogState();
}

class _DateTimePickerUltraDialogState extends State<DateTimePickerUltraDialog> {
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
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius))),
        backgroundColor: widget.dialogBoxColor,
        actionsPadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(6),
        content: SizedBox(
          width: 300,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showTimePicker)
                    TimeSelectorUltra(
                      selectedHour: (widget.initialTime.hour % 12) + 1,
                      selectedMinute: widget.initialTime.minute,
                      isAm: widget.initialTime.hour <= 12,
                      iconColor: widget.iconColor,
                      color: widget.color,
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
                  if (widget.showDatePicker)
                    DatePickerUltra(
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
