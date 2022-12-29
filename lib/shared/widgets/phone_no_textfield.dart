import 'package:botim_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNoTextField extends StatelessWidget {
  const PhoneNoTextField({
    Key? key,
    required this.validator,
    required this.number,
    required this.outlineInputBorder,
    required this.controller,
  }) : super(key: key);

  final RequiredValidator validator;
  final PhoneNumber number;
  final OutlineInputBorder outlineInputBorder;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      validator: validator,
      onInputChanged: (PhoneNumber number) {},
      onInputValidated: (bool value) {},
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black),
      initialValue: number,
      inputDecoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
      ),
      textFieldController: controller,
      formatInput: false,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.w, color: blackColor),
      ),
      onSaved: (PhoneNumber number) {
        //print('On Saved: $number');
      },
    );
  }
}
