import 'dart:developer';

import 'package:curved_nav/view/utils/Navigation/nav_screen.dart';
import 'package:curved_nav/view/utils/color_constant/color_constant.dart';
import 'package:flutter/material.dart';

class AddCardDaolog extends StatefulWidget {
  const AddCardDaolog({super.key});

  @override
  State<AddCardDaolog> createState() => _AddCardDaologState();
}

class _AddCardDaologState extends State<AddCardDaolog>
    with TickerProviderStateMixin {
  bool isMoneyLendingSelected = false;
  bool isWeeklySelected = false;
  bool isMonthSelected = false;
  String? selectedWeekday;
  List<DateTime> matchingDates = [];

  final List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  double? height;

  void calculateMatchingDates(String weekday) {
    int selectedWeekdayIndex = weekdays.indexOf(weekday) + 1;
    DateTime today = DateTime.now();
    List<DateTime> dates = [];

    DateTime current = today;
    while (dates.length < 20) {
      if (current.weekday == selectedWeekdayIndex) {
        dates.add(current);
      }
      current = current.add(Duration(days: 1));
    }

    setState(() {
      matchingDates = dates;
    });
  }

  @override
  Widget build(BuildContext context) {
    late TabController _tabController = TabController(length: 2, vsync: this);
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              bool isSelected = true;
              // return
              // alertWidget(
              //     isSelected,
              //     context,
              //     _tabController,
              //     isMoneyLendingSelected,
              //     height,
              //     weekdays,
              //     selectedWeekday,
              //     calculateWeekDays,
              //     weekDays);
              return AlertDialog(
                backgroundColor: white,
                title: Center(
                  child: Text('Add new card'),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DefaultTabController(
                        initialIndex: 0,
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding:
                                  EdgeInsets.symmetric(horizontal: 22),
                              indicatorColor: primaryColorBlue,
                              indicatorWeight: 4.0,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              dividerColor: white,
                              unselectedLabelStyle: TextStyle(fontSize: 12),
                              tabs: [
                                Tab(text: "Create"),
                                Tab(text: "Join"),
                              ],
                            ),
                            StatefulBuilder(
                              builder: (context, setState) {
                                log(isSelected.toString());
                                _tabController.addListener(() {
                                  if (_tabController.index == 0) {
                                    setState(
                                      () {
                                        isSelected = true;
                                      },
                                    );
                                  } else if (_tabController.index == 1) {
                                    setState(
                                      () {
                                        isSelected = false;
                                        // controller.index = 0;
                                      },
                                    );
                                  }
                                });

                                setState(
                                  () {
                                    if (isMoneyLendingSelected) {
                                      height = 400;
                                      _tabController.addListener(
                                        () {
                                          if (isMoneyLendingSelected) {
                                            _tabController.index = 0;
                                          } else {
                                            null;
                                          }
                                        },
                                      );
                                    } else if (!isSelected) {
                                      height = 120;
                                    } else {
                                      height = 550;
                                    }
                                  },
                                );

                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: height,
                                  //  isSelected ? 550 : 120,
                                  width: 600,
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Money Lender",
                                              ),
                                              Switch(
                                                activeColor:
                                                    ColorConstant.defBlue,
                                                value: isMoneyLendingSelected,
                                                thumbColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.white),
                                                inactiveThumbColor:
                                                    ColorConstant.defBlue,
                                                focusColor:
                                                    ColorConstant.defBlue,
                                                trackColor:
                                                    WidgetStatePropertyAll(
                                                  ColorConstant.defBlue,
                                                ),
                                                onChanged: (value) {
                                                  setState(
                                                    () {
                                                      isMoneyLendingSelected =
                                                          value;
                                                    },
                                                  );
                                                },
                                              ),
                                              Text(
                                                "To Give",
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText: "Name",
                                              floatingLabelStyle: TextStyle(
                                                  color: primaryColorBlue),
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColorBlue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText: "Phone (Optional)",
                                              floatingLabelStyle: TextStyle(
                                                  color: primaryColorBlue),
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColorBlue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          TextField(
                                            maxLines: 4,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 50, top: 30),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColorBlue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              hintText:
                                                  "Description (Optional)",
                                              floatingLabelStyle: TextStyle(
                                                  color: primaryColorBlue),
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          TextField(
                                            decoration: InputDecoration(
                                              floatingLabelStyle: TextStyle(
                                                  color: primaryColorBlue),
                                              hintText:
                                                  "Amount (With interest if any)",
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColorBlue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                          SizedBox(height: 15),
                                          isMoneyLendingSelected
                                              ? SizedBox()
                                              : TextField(
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Installment Amount",
                                                    floatingLabelStyle: TextStyle(
                                                        color:
                                                            primaryColorBlue),
                                                    hintStyle:
                                                        TextStyle(fontSize: 15),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColorBlue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                          SizedBox(height: 15),
                                          isMoneyLendingSelected
                                              ? SizedBox()
                                              : DropdownButtonFormField<String>(
                                                  dropdownColor: white,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Installment Type",
                                                    hintStyle:
                                                        TextStyle(fontSize: 15),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColorBlue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  items: const [
                                                    DropdownMenuItem(
                                                      value: "1",
                                                      child: Text("Daily"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "2",
                                                      child: Text("Weekly"),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "3",
                                                      child: Text("Monthly"),
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if (value == '2') {
                                                        isWeeklySelected = true;
                                                        isMonthSelected = false;
                                                      } else if (value == '3') {
                                                        isMonthSelected = true;
                                                        isWeeklySelected =
                                                            false;
                                                      } else {
                                                        isWeeklySelected =
                                                            false;
                                                        isMonthSelected = false;
                                                      }
                                                    });
                                                  },
                                                ),
                                          SizedBox(height: 15),
                                          isWeeklySelected
                                              ? DropdownButtonFormField<String>(
                                                  dropdownColor: white,
                                                  decoration: InputDecoration(
                                                    hintText: "Pick which week",
                                                    hintStyle:
                                                        TextStyle(fontSize: 15),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColorBlue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  items: weekdays
                                                      .map((day) =>
                                                          DropdownMenuItem(
                                                            value: day,
                                                            child: Text(day),
                                                          ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      setState(() {
                                                        selectedWeekday = value;
                                                      });
                                                      calculateMatchingDates(
                                                          value);
                                                    }
                                                  },
                                                )
                                              : SizedBox(),
                                          isMonthSelected
                                              ? TextField(
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Pick date of the month",
                                                    floatingLabelStyle: TextStyle(
                                                        color:
                                                            primaryColorBlue),
                                                    hintStyle:
                                                        TextStyle(fontSize: 15),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                primaryColorBlue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                  onTap: () {
                                                    showDatePicker(
                                                        builder: (context, _) {
                                                          return Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                              colorScheme: ColorScheme
                                                                  .light(
                                                                      primary:
                                                                          ColorConstant
                                                                              .defBlue,
                                                                      onPrimary:
                                                                          Colors
                                                                              .white, // header text color
                                                                      onSurface:
                                                                          Colors
                                                                              .black),
                                                              textButtonTheme:
                                                                  TextButtonThemeData(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  foregroundColor:
                                                                      ColorConstant
                                                                          .defBlue, // button text color
                                                                ),
                                                              ),
                                                            ),
                                                            child: _!,
                                                          );
                                                        },
                                                        context: context,
                                                        firstDate: DateTime(
                                                            2000, 1, 1),
                                                        lastDate: DateTime(
                                                            2100, 31, 12));
                                                  },
                                                )
                                              : SizedBox(),
                                        ]),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText: "Enter code",
                                              floatingLabelStyle: TextStyle(
                                                  color: primaryColorBlue),
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: primaryColorBlue),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (matchingDates.isNotEmpty) {
                        log(matchingDates.toString());
                      }
                      isSelected
                          ? Navigator.pop(context)
                          : Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavScreen(),
                              ),
                              (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      isSelected
                          ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavScreen(),
                              ),
                              (Route<dynamic> route) => false)
                          : showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Center(child: Text('Code details')),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Name: Name'),
                                      Text('Amount: 30000/-')
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                          foregroundColor:
                                              WidgetStatePropertyAll(black)),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ButtonStyle(
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                    primaryColorBlue)),
                                        child: Text('Add'))
                                  ],
                                );
                              });
                    },
                    child: Text(
                      isSelected ? 'Create' : 'Add',
                      style: TextStyle(
                        color: ColorConstant.defBlue,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ));
  }
}

// AlertDialog alertWidget(
//     bool isSelected,
//     BuildContext context,
//     TabController controller,
//     bool isMoneyLending,
//     double? height,
//     List<String> weekdays,
//     String? selectedWeekday,
//     void Function(String) calculateWeekDays,
//     List<DateTime> weekDays) {
//   return AlertDialog(
//     backgroundColor: white,
//     title: Center(
//       child: Text('Add new card'),
//     ),
//     content: SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           DefaultTabController(
//             initialIndex: 0,
//             length: 2,
//             child: Column(
//               children: [
//                 TabBar(
//                   controller: controller,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   indicatorPadding: EdgeInsets.symmetric(horizontal: 22),
//                   indicatorColor: primaryColorBlue,
//                   indicatorWeight: 4.0,
//                   labelColor: Colors.black,
//                   unselectedLabelColor: Colors.grey,
//                   dividerColor: white,
//                   unselectedLabelStyle: TextStyle(fontSize: 12),
//                   tabs: [
//                     Tab(text: "Create"),
//                     Tab(text: "Join"),
//                   ],
//                 ),
//                 StatefulBuilder(
//                   builder: (context, setState) {
//                     log(isSelected.toString());
//                     controller.addListener(() {
//                       if (controller.index == 0) {
//                         setState(
//                           () {
//                             isSelected = true;
//                           },
//                         );
//                       } else if (controller.index == 1) {
//                         setState(
//                           () {
//                             isSelected = false;
//                             // controller.index = 0;
//                           },
//                         );
//                       }
//                     });

//                     setState(
//                       () {
//                         if (isMoneyLending) {
//                           height = 400;
//                           controller.addListener(
//                             () {
//                               if (isMoneyLending) {
//                                 controller.index = 0;
//                               } else {
//                                 null;
//                               }
//                             },
//                           );
//                         } else if (!isSelected) {
//                           height = 120;
//                         } else {
//                           height = 550;
//                         }
//                       },
//                     );

//                     return AnimatedContainer(
//                       duration: Duration(milliseconds: 200),
//                       height: height,
//                       //  isSelected ? 550 : 120,
//                       width: 600,
//                       child: TabBarView(
//                         controller: controller,
//                         children: [
//                           SingleChildScrollView(
//                             child: Column(children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     "Money Lender",
//                                   ),
//                                   Switch(
//                                     activeColor: ColorConstant.defBlue,
//                                     value: isMoneyLending,
//                                     thumbColor:
//                                         WidgetStatePropertyAll(Colors.white),
//                                     inactiveThumbColor: ColorConstant.defBlue,
//                                     focusColor: ColorConstant.defBlue,
//                                     trackColor: WidgetStatePropertyAll(
//                                       ColorConstant.defBlue,
//                                     ),
//                                     onChanged: (value) {
//                                       setState(
//                                         () {
//                                           isMoneyLending = value;
//                                         },
//                                       );
//                                     },
//                                   ),
//                                   Text(
//                                     "To Give",
//                                   ),
//                                 ],
//                               ),
//                               TextField(
//                                 decoration: InputDecoration(
//                                   hintText: "Name",
//                                   floatingLabelStyle:
//                                       TextStyle(color: primaryColorBlue),
//                                   hintStyle: TextStyle(fontSize: 15),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: primaryColorBlue),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                               ),
//                               SizedBox(height: 15),
//                               TextField(
//                                 decoration: InputDecoration(
//                                   hintText: "Phone (Optional)",
//                                   floatingLabelStyle:
//                                       TextStyle(color: primaryColorBlue),
//                                   hintStyle: TextStyle(fontSize: 15),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: primaryColorBlue),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                               ),
//                               SizedBox(height: 15),
//                               TextField(
//                                 maxLines: 4,
//                                 decoration: InputDecoration(
//                                   contentPadding:
//                                       EdgeInsets.only(left: 50, top: 30),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: primaryColorBlue),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                   hintText: "Description (Optional)",
//                                   floatingLabelStyle:
//                                       TextStyle(color: primaryColorBlue),
//                                   hintStyle: TextStyle(fontSize: 15),
//                                 ),
//                               ),
//                               SizedBox(height: 15),
//                               TextField(
//                                 decoration: InputDecoration(
//                                   floatingLabelStyle:
//                                       TextStyle(color: primaryColorBlue),
//                                   hintText: "Amount (With interest if any)",
//                                   hintStyle: TextStyle(fontSize: 15),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: primaryColorBlue),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                                 keyboardType: TextInputType.number,
//                               ),
//                               SizedBox(height: 15),
//                               isMoneyLending
//                                   ? SizedBox()
//                                   : TextField(
//                                       decoration: InputDecoration(
//                                         hintText: "Installment Amount",
//                                         floatingLabelStyle:
//                                             TextStyle(color: primaryColorBlue),
//                                         hintStyle: TextStyle(fontSize: 15),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: primaryColorBlue),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                       ),
//                                       keyboardType: TextInputType.number,
//                                     ),
//                               SizedBox(height: 15),
//                               isMoneyLending
//                                   ? SizedBox()
//                                   : DropdownButtonFormField<String>(
//                                       dropdownColor: white,
//                                       decoration: InputDecoration(
//                                         hintText: "Installment Type",
//                                         hintStyle: TextStyle(fontSize: 15),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: primaryColorBlue),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                       ),
//                                       items: const [
//                                         DropdownMenuItem(
//                                           value: "1",
//                                           child: Text("Daily"),
//                                         ),
//                                         DropdownMenuItem(
//                                           value: "2",
//                                           child: Text("Weekly"),
//                                         ),
//                                         DropdownMenuItem(
//                                           value: "3",
//                                           child: Text("Monthly"),
//                                         ),
//                                       ],
//                                       onChanged: (value) {},
//                                     ),
//                               SizedBox(height: 15),
//                               DropdownButtonFormField<String>(
//                                 dropdownColor: white,
//                                 decoration: InputDecoration(
//                                   hintText: "Pick which week",
//                                   hintStyle: TextStyle(fontSize: 15),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: primaryColorBlue),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                                 items: weekdays
//                                     .map((day) => DropdownMenuItem(
//                                           value: day,
//                                           child: Text(day),
//                                         ))
//                                     .toList(),
//                                 onChanged: (value) {
//                                   if (value != null) {
//                                     setState(() {
//                                       selectedWeekday = value;
//                                     });
//                                     calculateWeekDays(value);
//                                   }
//                                 },
//                               ),
//                               SizedBox(height: 20),
//                               if (weekDays.isNotEmpty)
//                                 Text(
//                                   'Dates of the selected week:',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               SizedBox(height: 10),
//                               for (var day in weekDays)
//                                 ListTile(
//                                   title: Text(
//                                       DateFormat('EEEE, MMM dd').format(day)),
//                                 ),
//                             ]),
//                           ),
//                           Column(
//                             children: [
//                               SizedBox(
//                                 height: 30,
//                               ),
//                               TextField(
//                                 decoration: InputDecoration(
//                                   hintText: "Enter code",
//                                   floatingLabelStyle:
//                                       TextStyle(color: primaryColorBlue),
//                                   hintStyle: TextStyle(fontSize: 15),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           BorderSide(color: primaryColorBlue),
//                                       borderRadius: BorderRadius.circular(10)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//     actions: [
//       TextButton(
//         onPressed: () {
//           isSelected
//               ? Navigator.pop(context)
//               : Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NavScreen(),
//                   ),
//                   (Route<dynamic> route) => false);
//         },
//         child: const Text(
//           "Cancel",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       TextButton(
//         onPressed: () {
//           isSelected
//               ? Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NavScreen(),
//                   ),
//                   (Route<dynamic> route) => false)
//               : showDialog(
//                   barrierDismissible: false,
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Center(child: Text('Code details')),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [Text('Name: Name'), Text('Amount: 30000/-')],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           style: ButtonStyle(
//                               foregroundColor: WidgetStatePropertyAll(black)),
//                           child: Text('Cancel'),
//                         ),
//                         TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             style: ButtonStyle(
//                                 foregroundColor:
//                                     WidgetStatePropertyAll(primaryColorBlue)),
//                             child: Text('Add'))
//                       ],
//                     );
//                   });
//         },
//         child: Text(
//           isSelected ? 'Create' : 'Add',
//           style: TextStyle(
//             color: ColorConstant.defBlue,
//           ),
//         ),
//       ),
//     ],
//   );
// }
