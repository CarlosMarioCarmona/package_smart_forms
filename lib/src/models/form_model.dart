import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_forms/src/enums/form_control_type.dart';



class FormFieldBuilderProperties
{
  FormControlField formBuilderType;
  dynamic formBuilder;
  FormFieldBuilderProperties(this.formBuilderType, this.formBuilder);
}

class FormFieldText
{
  String name;
  String labelText;
  String icon;
  TextInputType inputType;
  dynamic initialValue;
  dynamic validators;
  bool enable;
  bool isNumeric;
  int maxLength;
  bool autoCorrect;
  bool autoFocus;
  bool obscureText;
  dynamic textInputAction;
  dynamic textCapitalization;
  FormFieldText({required this.name, required this.labelText, required this.icon, required this.inputType, required this.initialValue, required this.enable,
    required this.isNumeric, required this.validators, required this.maxLength, required this.autoCorrect, required this.autoFocus, required this.obscureText, required this.textInputAction, required this.textCapitalization});
}

class FormFieldCombo
{
  String name;
  String labelText;
  String icon;
  int initialValue;
  bool allowClear;
  String hint;
  dynamic items;
  String valueName;
  String childName;
  bool enabled=true;
  FormFieldCombo({required this.name, required this.labelText, required this.icon,  required this.initialValue, required this.allowClear, required this.hint, required this.items, required this.valueName, required this.childName,  this.enabled=true});
}


class FormFieldCheckbox
{
  String name;
  String labelText;
  String icon;
  bool initialValue;
  bool enable;
  FormFieldCheckbox({required this.name, required this.labelText, required this.icon,  required this.initialValue,  required this.enable});
}

class FormFieldCheckboxInteger
{
  String name;
  String labelText;
  String icon;
  int initialValue;
  bool enable;
  FormFieldCheckboxInteger({required this.name, required this.labelText, required this.icon,  required this.initialValue,  required this.enable});
}