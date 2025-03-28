import 'dart:developer';
import 'package:curved_nav/Application/Advertisment/ad_bloc.dart';
import 'package:curved_nav/Application/Expense/expense_bloc.dart';
import 'package:curved_nav/Infrastructure/Expense/expense_repository.dart';
import 'package:curved_nav/view/utils/Expense/expense_add_screen.dart';
import 'package:curved_nav/view/utils/color_constant/color_constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: ColorConstant.defBlue,
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorConstant.defBlue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
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
    context.read<AdBloc>().add(AdEvent.interstatial());
    date = DateFormat.yMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => context.read<ExpenseBloc>().add(GetExpense()),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  headerPadding: EdgeInsets.symmetric(vertical: 2)),
              calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: focusdDate != DateTime.now()
                        ? primaryColorBlue.withValues(alpha: 0.5)
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
              child: Container(child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  final filteredExpenses = state.expense.where((element) {
                    return element.date.day == focusdDate.day &&
                        element.date.day == selectedDate.day;
                  }).toList();
                  if (state.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColorBlue,
                      ),
                    );
                  } else if (filteredExpenses.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                          'assets/svg/NoData.svg',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('No Expense Found'),
                      ],
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                      final data = filteredExpenses[index];
                      final date = DateFormat.yMd().format(data.date);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: white,
                                  title: Center(child: Text('Expense Details')),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Category: ${data.category}'),
                                      Text('Amount: ${data.amount}/-'),
                                      Text('Date: $date'),
                                      Text('Description: ${data.description}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStatePropertyAll(
                                                  primaryColorBlue)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close'),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.red)),
                                      onPressed: () {
                                        ExpenseFunctions()
                                            .expenseDelete(data.id!);
                                        context
                                            .read<ExpenseBloc>()
                                            .add(GetExpense());
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            tileColor: primaryColorBlue.withValues(alpha: 0.2),
                            title: Text(
                              '${data.category}',
                              style: TextStyle(color: black),
                            ),
                            subtitle: Text('${data.amount}/-'),
                            trailing: Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        ),
                      );
                    },
                  );
                },
              ))),
        ],
      ),
      bottomNavigationBar: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          final filteredExpenses = state.expense.where((element) {
            return element.date.day == focusdDate.day &&
                element.date.day == selectedDate.day;
          }).toList();
          final totalExpense = filteredExpenses.fold(0, (sum, element) {
            return sum + int.parse(element.amount);
          });
          if (filteredExpenses.isEmpty) {
            return SizedBox();
          } else {
            return Container(
              height: 50,
              color: primaryColorBlue,
              child: Center(
                  child: Text(
                'Total Expense: ${totalExpense}/-',
                style: TextStyle(color: white),
              )),
            );
          }
        },
      ),
    );
  }
}
