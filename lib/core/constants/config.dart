// colors that we use in our app
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:color_hex/class/hex_to_color.dart';

// Temp file to be deleted

const Color primaryColorLight = Color(0xFF254EDB); // #254EDB
const double defaultPadding = 16;
const double appbarDividerHeight = 0.5;
const double defaultInputBorderRadius = 12;
const Duration kDefaultDuration = Duration(milliseconds: 250);
const int defaultSnackBarDuration = 5;
const double defaultAlertDialogCornerRadius = 12;
const int maxFileSizeLimitInMB = 20;
const int bottomTabsIconsDuration = 300;
const int subscriptionPlanIdFamilyPlan = 4;

const TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const EdgeInsets kTextFieldPadding = EdgeInsets.symmetric(
  horizontal: defaultPadding,
  vertical: defaultPadding,
);

// Text Field Decoration
final OutlineInputBorder kDefaultOutlineInputBorder = OutlineInputBorder(
  borderRadius:
      const BorderRadius.all(Radius.circular(defaultInputBorderRadius)),
  borderSide: BorderSide(
    color: hexToColor("#D2D6DB"),
  ),
);

const InputDecoration otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.zero,
  counterText: "",
  errorStyle: TextStyle(height: 0),
);

const kErrorBorderSide = BorderSide(color: Colors.red, width: 1);

const defaultOtpLength = 6;
const defaultOtpResendDuration = 60; // seconds

class EmiratesIdInputDashFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (oldValue.text.length > newValue.text.length) {
      // Handle backspace: if the last character was a dash, remove the preceding digit
      final endOffset = newValue.selection.end;
      if (oldValue.text.length >= endOffset + 1 &&
          oldValue.text[endOffset] == '-') {
        return TextEditingValue(
          text: newValue.text.substring(0, endOffset - 1) +
              newValue.text.substring(endOffset),
          selection: TextSelection.collapsed(offset: endOffset - 1),
        );
      }
    }

    final StringBuffer newText = StringBuffer();
    var digitCount = 0;
    for (int i = 0; i < newValue.text.length; i++) {
      if (newValue.text[i] != '-') {
        newText.write(newValue.text[i]);
        digitCount++;
        if (digitCount == 3 || digitCount == 7 || digitCount == 14) {
          newText.write('-');
        }
      }
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

final List<TextInputFormatter> emiratesIdInputFormatters = [
  LengthLimitingTextInputFormatter(18),
  EmiratesIdInputDashFormatter()
];

final List<TextInputFormatter> nationalIdInputFormatters = [
  LengthLimitingTextInputFormatter(10)
];
