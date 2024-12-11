import 'dart:developer';

import 'package:curved_nav/view/utils/Expense/expense_add_screen.dart';
import 'package:curved_nav/view/utils/color_constant/color_constant.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>
    with SingleTickerProviderStateMixin {
  var selectedDate = DateTime.now();
  var focusdDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: focusdDate,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != focusdDate) {
      setState(() {
        focusdDate = pickedDate;
        selectedDate = pickedDate;
      });
    }
  }

  late String date;
  @override
  void initState() {
    super.initState();
    date = DateFormat.yMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstant.defBlue,
        title: const Text(
          "Track Your Expense here",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseScreen(),
                    ));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: white,
            child: TableCalendar(
              calendarFormat: CalendarFormat.week,
              availableCalendarFormats: {
                CalendarFormat.week: 'weeks',
              },
              calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: focusdDate != DateTime.now()
                        ? primaryColorBlue.withOpacity(0.5)
                        : primaryColorBlue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: primaryColorBlue,
                    shape: BoxShape.circle,
                  )),
              focusedDay: focusdDate,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  focusdDate = focusedDay;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                selectedDate = selectedDay;
                final moDate = DateFormat.yMd().format(selectedDate);
                if (selectedDay.isBefore(DateTime.now()) ||
                    isSameDay(selectedDay, DateTime.now())) {
                  setState(() {
                    focusdDate = focusedDay;
                    final day = moDate;
                    date = day;
                    final modifiedDate = DateFormat.yMd().format(selectedDay);
                    date = modifiedDate;
                    log(date);
                  });
                }
              },
              enabledDayPredicate: (day) {
                return day.isBefore(DateTime.now()) ||
                    isSameDay(day, DateTime.now());
              },
              onHeaderTapped: (focusedDay) {
                _selectDate(context);
              },
            ),
          ),
          Expanded(
              flex: 8,
              child: Container(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      tileColor: primaryColorBlue.withOpacity(0.2),
                      title: Text('Category Name - - - Date: $date'),
                      subtitle: Text('Amount/- (${index + 1})'),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    ),
                  );
                },
              ))),
          Expanded(
              flex: 1,
              child: Container(
                color: white,
                child: Center(child: Text('Total Expense: 100/-')),
              ))
        ],
      ),
    );
  }
}
