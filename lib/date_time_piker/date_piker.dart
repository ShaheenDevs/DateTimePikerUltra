// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class DatePickerUltra extends StatefulWidget {
  Color color;
  Color iconColor;
  DateTime selectedDate;
  Function(DateTime) onChange;
  DatePickerUltra({
    super.key,
    required this.onChange,
    this.iconColor = Colors.grey,
    this.color = Colors.orangeAccent,
    DateTime? selectedDate,
  }) : selectedDate = selectedDate ?? DateTime.now();
  @override
  State<DatePickerUltra> createState() => _DatePickerUltraState();
}

class _DatePickerUltraState extends State<DatePickerUltra> {
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme(
        data: ThemeData(
            colorScheme: ColorScheme.light(primary: widget.color),
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(widget.iconColor))),
            iconTheme: IconThemeData(color: widget.iconColor)),
        child: CalendarDatePicker(
            initialDate: widget.selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            onDateChanged: (picked) {
              if (picked != widget.selectedDate) {
                setState(() {
                  widget.selectedDate = picked;
                });

                widget.onChange(picked);
              }
            }),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
