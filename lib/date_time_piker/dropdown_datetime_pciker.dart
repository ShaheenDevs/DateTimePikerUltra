// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'time_piker.dart';
import 'date_piker.dart';

class DateTimePickerUltraDropdown extends StatefulWidget {
  Color color;
  Color iconColor;
  bool showDatePicker;
  String title;
  Widget? titleWidget;
  bool showTimePicker;
  Function(DateTime)? onChangeDate;
  Function(DateTime)? onChangeTime;
  Function(DateTime)? onPress;
  double borderRadius;
  double textBoxwidth;
  double towardsTop;
  double towardsBottom;
  DateTime selectedDate;
  TimeOfDay initialTime;

  DateTimePickerUltraDropdown({
    super.key,
    this.showDatePicker = true,
    this.showTimePicker = true,
    this.title = 'Tap here to open Date Time dropdown',
    this.titleWidget,
    this.onChangeDate,
    this.onChangeTime,
    this.onPress,
    this.iconColor = Colors.grey,
    this.color = Colors.orangeAccent,
    this.borderRadius = 6,
    this.textBoxwidth = 60,
    this.towardsTop = 100,
    this.towardsBottom = 0,
    DateTime? selectedDate,
    TimeOfDay? initialTime,
  })  : selectedDate = selectedDate ?? DateTime.now(),
        initialTime = initialTime ?? TimeOfDay.now() {
    // Set the default value for initialTime if it's not provided
    // This code executes in the constructor body
    // This approach ensures the object is fully initialized
  }

  @override
  State<DateTimePickerUltraDropdown> createState() =>
      _DateTimePickerUltraDropdownState();
}

class _DateTimePickerUltraDropdownState
    extends State<DateTimePickerUltraDropdown> {
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
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    bool isAboveCenter = offset.dy < screenHeight / 2;
    double topPosition;
    if (isAboveCenter) {
      topPosition = offset.dy - widget.towardsBottom + size.height;
    } else {
      topPosition = offset.dy - widget.towardsTop - screenHeight / 2;
    }

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: topPosition,
        width: size.width,
        child: Material(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          elevation: 4.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius),
              ),
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.initialTime = time;
                            if (widget.onChangeTime != null) {
                              DateTime dateTime = mergeDateTimeAndTimeOfDay();
                              widget.onChangeDate!(dateTime);
                            }
                          },
                        ),
                      if (widget.showDatePicker)
                        DatePickerUltra(
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
