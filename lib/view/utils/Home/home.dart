import 'package:curved_nav/application/Lender/lender_bloc.dart';
import 'package:curved_nav/domain/Debounce/debouncer.dart';
import 'package:curved_nav/view/utils/Home/Widgets/alertDialog_widget.dart';
import 'package:curved_nav/view/utils/Home/home_idle_page.dart';
import 'package:curved_nav/view/utils/Home/search_result_page.dart';
import 'package:curved_nav/view/utils/color_constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final _debouncer = Debouncer(milliseconds: 1 * 1000);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LenderBloc>().add(LenderEvent.getData());
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.defBlue,
        title: Text(
          "LENDO",
          style: TextStyle(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
        ),
        actions: [AddCardDaolog()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              backgroundColor: WidgetStatePropertyAll(
                  const Color.fromARGB(255, 235, 235, 235)),
              elevation: WidgetStatePropertyAll(0),
              hintText: 'Search',
              leading: Icon(
                Icons.search_outlined,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  HomeIdlePage();
                }
                _debouncer.run(() {
                  context.read<LenderBloc>().add(Search(query: value));
                });
              },
            ),
          ),
          Expanded(child: BlocBuilder<LenderBloc, LenderState>(
            builder: (context, state) {
              if (state.searchData.isEmpty) {
                return HomeIdlePage();
              }
              return SearchResultPage();
            },
          ))
        ],
      ),
    );
  }
}
