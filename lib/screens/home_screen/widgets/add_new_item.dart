import 'dart:io';

import 'package:expenses_app/core/utils/styles.dart';

import 'package:expenses_app/main.dart';
import 'package:expenses_app/model/expenses_model.dart';
import 'package:expenses_app/screens/home_screen/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key, required this.onAddExpense});

  final void Function(ExpensesModel expenses) onAddExpense;
  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final titleController = TextEditingController();
  final shopNameController = TextEditingController();
  final amountController = TextEditingController();
  final formatter = DateFormat.yMEd();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;
  Currency _selectedCurrency = Currency.$;

  @override
  void dispose() {
    titleController.dispose();
    shopNameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsetsDirectional.only(
            bottom: MediaQuery.of(context).devicePixelRatio),
        padding: EdgeInsetsDirectional.only(
            top: MediaQuery.of(context).size.height * .01,
            start: MediaQuery.of(context).size.width * .025,
            end: MediaQuery.of(context).size.width * .025,
            bottom: MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).size.height * .025),
        child: Column(
          children: [
            Row(
              children: [
                CustomTextField(
                  controller: titleController,
                  width: MediaQuery.of(context).size.width * .35,
                  hintText: '   title...',
                  helperText: '',
                  keyboardType: TextInputType.text,
                ),
                CustomTextField(
                  controller: shopNameController,
                  width: MediaQuery.of(context).size.width * .35,
                  hintText: '   shop name...',
                  helperText: '* Not required',
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin:
                       EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * .025, 
                       bottom: MediaQuery.of(context).size.height * .02),
                  child: DropdownButton(
                  
                    alignment: Alignment.center,
                    icon: const Icon(FontAwesomeIcons.list),
                    borderRadius: BorderRadius.circular(10),
                    iconSize: 15,
                    value: _selectedCurrency,
                    onChanged: (newCurrency) {
                      if (newCurrency == null) {
                        return;
                      } else {
                        setState(() {
                          _selectedCurrency = newCurrency;
                        });
                      }
                    },
                    items: Currency.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name,
                              style: TextStyle(
                                  color: myColorScheme.onPrimaryContainer),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                 SizedBox(width: MediaQuery.of(context).size.width * .03),
                CustomTextField(
                  controller: amountController,
                  width: MediaQuery.of(context).size.width * .35,
                  hintText: '   amount...',
                  helperText: '',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                Container(
                  margin:
                       EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width * .05,
                       bottom:   MediaQuery.of(context).size.height * .01),
                  child: DropdownButton(
                      icon: const Icon(FontAwesomeIcons.list),
                      borderRadius: BorderRadius.circular(10),
                      iconSize: 15,
                      value: _selectedCategory,
                      items: Category.values
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.toUpperCase(),
                                style: TextStyle(
                                  color: myColorScheme.onPrimaryContainer,
                                ),
                              )))
                          .toList(),
                      onChanged: (
                        newCategory,
                      ) {
                        if (newCategory == null) {
                          return;
                        } else {
                          setState(() {
                            _selectedCategory = newCategory;
                          });
                        }
                      }),
                )
              ],
            ),
            Platform.isIOS ? iosDataPicker(context):
            andriodDatePicker(context),
            SizedBox(height:   MediaQuery.of(context).size.height * .025),
            Container(
              margin: EdgeInsetsDirectional.only(
                  bottom: MediaQuery.of(context).size.height * .03),
              width: MediaQuery.of(context).size.width * .8,
              height:   MediaQuery.of(context).size.height * .05,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                      myColorScheme.onPrimaryContainer),
                  foregroundColor:
                      MaterialStatePropertyAll(myColorScheme.onPrimary),
                ),
                onPressed: () {
                  onSaved();
                },
                child: Text(
                  'Save',
                  style: style18.copyWith(color: myColorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlinedButton andriodDatePicker(BuildContext context) {
    return OutlinedButton.icon(
       style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),
          ),
        )
      ),
            onPressed: () async {
              final now = DateTime.now();
              final firstDate = DateTime(now.year - 1, now.month, now.day);
              final peckedDate = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: firstDate,
                  lastDate: now);
              setState(() {
                _selectedDate = peckedDate;
              });
            },
            icon: const Icon(CupertinoIcons.calendar_circle),
            label: Text(
              _selectedDate == null
                  ? 'No Date Selected'
                  : formatter.format(_selectedDate!),
            ),
          );
  }

  OutlinedButton iosDataPicker(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),
          ),
        )
      ),
            onPressed: () async {
              final now = DateTime.now();
              final firstDate = DateTime(now.year - 1, now.month, now.day);
               await showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * .3,
                      color: Colors.white,
                      child: CupertinoDatePicker(
                        initialDateTime: now,
                        minimumDate: firstDate,
                         mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (peckedDate){
                        setState(() {
                          _selectedDate = peckedDate;
                        });
                      }),
                    );
                  },
                  );
            },
            icon: const Icon(CupertinoIcons.calendar_circle),
            label: Text(
              _selectedDate == null
                  ? 'No Date Selected'
                  : formatter.format(_selectedDate!),
            ),
          );
  }

  onSaved() async {
    final double? enteredAmount = double.tryParse(amountController.text);
    final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      adaptiveDialog();
    } else {
      widget.onAddExpense(ExpensesModel(
          title: titleController.text,
          shopName: shopNameController.text == ''
              ? 'Empty!'
              : shopNameController.text,
          amount: enteredAmount,
          category: _selectedCategory,
          currency: _selectedCurrency,
          date: _selectedDate!));
      Navigator.pop(context);
    }
  }

  adaptiveDialog() {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text(
              'Invalid Input!',
              style: style18.copyWith(fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Please make sure valid title,amount,date was entered.',
              style: style18.copyWith(fontSize: 15),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Okey',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }
}
