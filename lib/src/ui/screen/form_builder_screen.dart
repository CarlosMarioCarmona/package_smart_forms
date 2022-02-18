import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:smart_common_shared/smart_common_shared.dart';
import 'package:smart_forms/src/enums/form_control_type.dart';
import 'package:smart_forms/src/models/form_model.dart';

class FormBuilderScreen extends StatefulWidget {
  final List<FormFieldBuilderProperties> formBuilder;
  final Function(Map<String, dynamic>) saveButton;

  const FormBuilderScreen(
      {Key? key,
      required this.formBuilder,
      required this.saveButton})
      : super(key: key);

  @override
  _FormBuilderNewScreenState createState() => _FormBuilderNewScreenState();
}

class _FormBuilderNewScreenState extends State<FormBuilderScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late List<Widget> _listItems = <Widget>[];

  @override
  void initState() {
    super.initState();
    _listItems = _buildFormControlItems(context, widget.formBuilder);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            child: Column(
              children: _listItems,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      widget.saveButton(_formKey.currentState!.value);
                    }
                  },
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20.0)),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}

List<Widget> _buildFormControlItems(
    BuildContext context, List<FormFieldBuilderProperties> formBuilder) {
  List<Widget> _listItems = <Widget>[];
  for (FormFieldBuilderProperties element in formBuilder) {
    switch (element.formBuilderType) {
      case FormControlField.formTextField:
        FormFieldText formTextBuilder = element.formBuilder as FormFieldText;
        if (formTextBuilder.isNumeric) {
          _listItems.add(
            FormBuilderTextField(
              name: formTextBuilder.name,
              enabled: formTextBuilder.enable,
              initialValue: formTextBuilder.initialValue,
              maxLength: formTextBuilder.maxLength,
              valueTransformer: (String? text) => num.tryParse(text!),
              decoration: InputDecoration(
                icon: Icon(smartIcons[formTextBuilder.icon]),
                labelText: formTextBuilder.labelText,
              ),
              validator: formTextBuilder.validators,
              keyboardType: formTextBuilder.inputType,
            ),
          );
        } else {
          _listItems.add(
            FormBuilderTextField(
              name: formTextBuilder.name,
              enabled: formTextBuilder.enable,
              maxLength: formTextBuilder.maxLength,
              autocorrect: formTextBuilder.autoCorrect,
              autofocus: formTextBuilder.autoFocus,
              obscureText: formTextBuilder.obscureText,
              textInputAction: formTextBuilder.textInputAction,
              textCapitalization:
                  formTextBuilder.textCapitalization ?? TextCapitalization.none,
              initialValue: formTextBuilder.initialValue,
              decoration: InputDecoration(
                icon: Icon(smartIcons[formTextBuilder.icon]),
                labelText: formTextBuilder.labelText,
              ),
              validator: formTextBuilder.validators,
              keyboardType: formTextBuilder.inputType,
            ),
          );
        }
        break;
      case FormControlField.formComboField:
        FormFieldCombo formComboBuilder = element.formBuilder as FormFieldCombo;
        late int? initialValue;
        if(formComboBuilder.initialValue == -1)
        {
          initialValue = null;
        }else{
          initialValue = formComboBuilder.initialValue;
        }
        String encoded = jsonEncode(formComboBuilder.items);
        List items = jsonDecode(encoded);
        _listItems.add(FormBuilderDropdown(
          name: formComboBuilder.name,
          enabled: formComboBuilder.enabled,
          decoration: InputDecoration(
            icon: Icon(smartIcons[formComboBuilder.icon]),
            labelText: formComboBuilder.labelText,
          ),
          initialValue: initialValue,
          allowClear: formComboBuilder.allowClear,
          hint: Text(formComboBuilder.hint),
          validator: FormBuilderValidators.compose(
              [FormBuilderValidators.required(context)]),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item[formComboBuilder.valueName],
                    child: Text(item[formComboBuilder.childName]),
                  ))
              .toList(),
        ));
        break;

      ////////////////////////////Checkbox  with integer value
      case FormControlField.formFieldCheckboxInteger:
        var formCheckboxBuilder =
            element.formBuilder as FormFieldCheckboxInteger;
        _listItems.add(FormBuilderCheckbox(
          name: formCheckboxBuilder.name,
          decoration: InputDecoration(
            icon: Icon(smartIcons[formCheckboxBuilder.icon]),
            labelText: formCheckboxBuilder.labelText,
          ),
          initialValue: formCheckboxBuilder.initialValue == 1 ? true : false,
          title: const Text(''),
          enabled: formCheckboxBuilder.enable,
        ));
        break;

      ////////////////////////////Checkbox with boolean value
      case FormControlField.formFieldCheckbox:
        var formCheckboxBuilder = element.formBuilder as FormFieldCheckbox;
        _listItems.add(FormBuilderCheckbox(
          name: formCheckboxBuilder.name,
          decoration: InputDecoration(
            icon: Icon(smartIcons[formCheckboxBuilder.icon]),
            labelText: formCheckboxBuilder.labelText,
          ),
          initialValue: formCheckboxBuilder.initialValue,
          title: const Text(''),
          enabled: formCheckboxBuilder.enable,
        ));
        break;
    }
  }
  return _listItems;
}
