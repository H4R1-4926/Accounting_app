import 'package:curved_nav/view/utils/Home/Widgets/calender.dart';
import 'package:curved_nav/view/utils/Home/Widgets/infoAlert.dart';
import 'package:curved_nav/view/utils/Home/Widgets/popUpMenu.dart';
import 'package:curved_nav/view/utils/Home/selection_card/history_screen.dart';
import 'package:curved_nav/view/utils/color_constant/color_constant.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatelessWidget {
  final bool isCreator;
  const SelectionCard({super.key, required this.isCreator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => InfoWidget(),
                );
              },
              icon: Icon(Icons.info_outline)),
          isCreator ? MenuButtonWidget() : SizedBox(),
        ],
        surfaceTintColor: primaryColorBlue,
        foregroundColor: white,
        title: Text("Person Name"),
        backgroundColor: ColorConstant.defBlue,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: Container(
            decoration: BoxDecoration(color: white),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Amount"), Text("10000/-")],
                  ),
                ),
                Text("Weekly Pay")
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalenderWidget(),
            Container(
              height: 20,
              color: white,
            ),
            isCreator
                ? ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        foregroundColor: WidgetStatePropertyAll(white),
                        backgroundColor:
                            WidgetStatePropertyAll(primaryColorBlue)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Enter Amount"),
                        ),
                      );
                    },
                    child: Text("Add Payment"))
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: lightBlue,
                  leading: Text("Selected date Event"),
                  trailing: Text("No Data"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(),
                    ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                color: white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "History",
                      style: TextStyle(color: primaryColorBlue),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: lightGreen,
                leading: Text('01/01/2000'),
                trailing: Text('-2000/-'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: lightGreen,
                leading: Text('01/01/2000'),
                trailing: Text('-2000/-'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: lightGreen,
                leading: Text('01/01/2000'),
                trailing: Text('-2000/-'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: lightGreen,
                leading: Text('01/01/2000'),
                trailing: Text('-2000/-'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    foregroundColor: WidgetStatePropertyAll(white),
                    backgroundColor: WidgetStatePropertyAll(primaryColorBlue)),
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HistoryScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var tween = Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeIn));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ));
                },
                child: Text("Show more")),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColorBlue,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance amount:',
                      style: TextStyle(color: white),
                    ),
                    Text(
                      "4000\\-",
                      style: TextStyle(color: white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
