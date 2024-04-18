// ignore_for_file: must_be_immutable
import 'package:date_time_piker_plus/date_time_piker/time_piker.dart';
import 'package:flutter/material.dart';

import 'date_piker.dart';

class DateTimePickerPlusDropdown extends StatefulWidget {
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

  DateTimePickerPlusDropdown({
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
  State<DateTimePickerPlusDropdown> createState() =>
      _DateTimePickerPlusDropdownState();
}

class _DateTimePickerPlusDropdownState
    extends State<DateTimePickerPlusDropdown> {
  OverlayEntry? _overlayEntry;

  void _toggleDropdown(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  DateTime mergeDateTimeAndTimeOfDay() {
    DateTime dateTime = widget.selectedDate;
    TimeOfDay timeOfDay = widget.initialTime;
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.initialTime = time;
                            if (widget.onChangeTime != null) {
                              DateTime dateTime = mergeDateTimeAndTimeOfDay();
                              widget.onChangeDate!(dateTime);
                            }
                          },
                        ),
                      if (widget.showDatePiker)
                        DatePickerPlus(
                          selectedDate: widget.selectedDate,
                          onChange: (DateTime date) {
                            widget.selectedDate = date;
                            if (widget.onChangeDate != null) {
                              DateTime dateTime = mergeDateTimeAndTimeOfDay();
                              widget.onChangeDate!(dateTime);
                            }
                          },
                        )
                    ],
                  ),
                  if (widget.onPress != null)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton(
                        onPressed: () {
                          DateTime dateTime = mergeDateTimeAndTimeOfDay();
                          widget.onPress!(dateTime);
                          _toggleDropdown(context);
                        },
                        child: const Text('Done'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleDropdown(context),
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
