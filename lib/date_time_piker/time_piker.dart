// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSelectorUltra extends StatefulWidget {
  int selectedHour;
  int selectedMint;
  bool isAm;
  Color color;
  Color iconColor;
  Color textColor;
  Function(TimeOfDay) onChange;
  double borderRadius;
  double textBoxwidth;
  TimeSelectorUltra(
      {super.key,
      this.selectedHour = 1,
      this.selectedMint = 1,
      this.isAm = true,
      required this.onChange,
      this.iconColor = Colors.grey,
      this.color = Colors.orangeAccent,
      this.textColor = Colors.black,
      this.borderRadius = 2,
      this.textBoxwidth = 60});

  @override
  State<TimeSelectorUltra> createState() => _TimeSelectorUltraState();
}

class _TimeSelectorUltraState extends State<TimeSelectorUltra> {
  void _incrementHour() {
    setState(() {
      widget.selectedHour = (widget.selectedHour % 12) + 1;
    });
  }

  void _decrementHour() {
    setState(() {
      widget.selectedHour =
          widget.selectedHour == 1 ? 12 : widget.selectedHour - 1;
    });
  }

  void _incrementMint() {
    setState(() {
      widget.selectedMint = (widget.selectedMint % 60) + 1;
    });
  }

  void _decrementMint() {
    setState(() {
      widget.selectedMint =
          widget.selectedMint == 1 ? 60 : widget.selectedMint - 1;
    });
  }

  void _toggleAmPm() {
    setState(() {
      widget.isAm = !widget.isAm;
    });
    getStringToTimeOfDay();
  }

  TimeOfDay getStringToTimeOfDay() {
    DateTime date = DateFormat("hh:mma", 'en').parse(
        "${widget.selectedHour}:${widget.selectedHour}${widget.isAm ? 'AM' : 'PM'}");
    widget.onChange(TimeOfDay.fromDateTime(date));
    return TimeOfDay.fromDateTime(date);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ColorScheme.light(primary: widget.color),
          iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(widget.iconColor))),
          iconTheme: IconThemeData(color: widget.iconColor)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.color, width: 1),
                  color: widget.color.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: widget.textBoxwidth,
                      child: Center(
                        child: Text(
                          '${widget.selectedHour}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    Container(
                      color: widget.color,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: _incrementHour,
                            child: const Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          InkWell(
                            onTap: _decrementHour,
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.color, width: 1),
                  color: widget.color.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: widget.textBoxwidth,
                      child: Center(
                        child: Text(
                          '${widget.selectedMint}',
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    Container(
                      color: widget.color,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: _incrementMint,
                            child: const Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          InkWell(
                            onTap: _decrementMint,
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.color, width: 1),
                  color: widget.color.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: widget.textBoxwidth - 20,
                      child: Center(
                        child: Text(
                          widget.isAm ? 'AM' : 'PM',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      color: widget.color,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: _toggleAmPm,
                            child: const Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          InkWell(
                            onTap: _toggleAmPm,
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ],
                      ),
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
}
