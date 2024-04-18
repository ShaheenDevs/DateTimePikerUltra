

### Overview:
This Flutter package provides a collection of customizable DateTime pickers, including dropdowns, dialog boxes, and widget bases. With this package, developers can easily integrate date and time selection functionality into their Flutter applications with various customization options to suit their UI needs.

### Features:

**Dropdown DateTime Picker:** A dropdown widget that allows users to select dates and times conveniently.<br>
**Dialog Box DateTime Picker:** A dialog box widget that pops up for date and time selection.<br>
**Widget Base DateTime Picker:** A basic widget that can be customized and integrated into different UI layouts for date and time selection.<br>
#### Installation:
To use this package in your Flutter project, add it to your pubspec.yaml file:

    dependencies:
      date_time_picker_plus: ^version_number
Then, run `flutter pub get` to install the package.

##### Usage:
###### Import the package in your Dart file:

    import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

### Dropdown DateTime Picker:
            DateTimePickerPlusDialog(
              selectedDate: DateTime.now(),
              initialTime: TimeOfDay.now(),
              showDatePicker: true,
              showTimePicker: true,
              onPress: (DateTime dateTime) {
                log(dateTime.toString());
              },
              iconColor: Colors.grey,
              color: Colors.orangeAccent,
            ),
![]([https://github.com/Your_Repository_Name/Your_GIF_Name.gif](https://github.com/TechProgression/DateTimePikerPlus/blob/main/assest/dropdown_datetime_picker.gif))
### Dialog Box DateTime Picker:
DatePicker.showDatePicker(
  context,
  showTitleActions: true,
  minTime: DateTime(2020, 1, 1),
  maxTime: DateTime(2030, 12, 31),
  onChanged: (date) {
    // Handle date change
  },
  onConfirm: (date) {
    // Handle date confirmation
  },
  currentTime: DateTime.now(),
  locale: LocaleType.en, // Set your preferred locale
);
### Widget Base DateTime Picker:
DatePickerWidget(
  initialDateTime: DateTime.now(),
  onDateTimeChanged: (date) {
    // Handle date change
  },
  locale: LocaleType.en, // Set your preferred locale
);
Customization:

Format: Customize the date and time format according to your application's requirements.
Locale: Set the locale to display date and time formats in different languages.
Minimum and Maximum Date/Time: Restrict the selectable date and time range.
Theme: Adjust the appearance of the DateTime picker to match your application's design.
Contributing:
Contributions are welcome! Feel free to submit issues or pull requests on GitHub.

License:
This package is licensed under the MIT License.

Author:
Mudassir Mukhtar

Contact:
03454335400
mudassirmukhtar4@gmail.com

Acknowledgments:
Thank you to the Flutter community for their contributions and support.

Support:
For any questions or assistance, please reach out to the author or open an issue on GitHub.

Disclaimer:
This package is provided as-is without any warranty. Use it at your own discretion.

Happy Coding! 🚀
# DateTimePickerPlus
