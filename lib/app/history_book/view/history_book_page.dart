import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import '/model/model.dart';
import '../history_book.dart';
import '/components/components.dart';

class HistoryBookPage extends StatefulWidget {
  const HistoryBookPage({super.key});

  @override
  State<HistoryBookPage> createState() => _HistoryBookPageState();
}

class _HistoryBookPageState extends State<HistoryBookPage> {
  late ThemeData themeData;
  late HistoryBookingBloc historyBookingBloc;

  @override
  void initState() {
    super.initState();
    historyBookingBloc = HistoryBookingBloc()..init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Provider.of<ThemeChanger>(context).getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.home,
                  color: themeData.scaffoldBackgroundColor,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 1,
        centerTitle: true,
        title: Text(
          'History Booking'.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: themeData.textSelectionTheme.selectionColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: TabBar(
                      isScrollable: false,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorWeight: 2,
                      indicatorColor: AppColors.primaryColor,
                      tabs: [
                        Tab(icon: Text('Confirmed')),
                        Tab(icon: Text('Cancelled')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      StreamBuilder<List<Transactions>>(
                        stream: historyBookingBloc.historyBookingStream1,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return SingleChildScrollView(
                                child: Column(
                                    children: snapshot.data!
                                        .map((e) => ItemHistory(
                                              isCancel: true,
                                              themeData: themeData,
                                              transactions: e,
                                              historyBookingBloc:
                                                  historyBookingBloc,
                                            ))
                                        .toList()));
                          } else {
                            return const NoFoundWidget(title: 'No data');
                          }
                        },
                      ),
                      StreamBuilder<List<Transactions>>(
                        stream: historyBookingBloc.historyBookingStream4,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return SingleChildScrollView(
                                child: Column(
                                    children: snapshot.data!
                                        .map(
                                          (e) => ItemHistory(
                                            themeData: themeData,
                                            transactions: e,
                                            historyBookingBloc:
                                                historyBookingBloc,
                                          ),
                                        )
                                        .toList()));
                          } else {
                            return const NoFoundWidget(title: 'No data');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<UIState>(
            stream: historyBookingBloc.historyBookingStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING) {
                return const LoadingBar();
              } else {
                return const Center();
              }
            },
          )
        ],
      ),
    );
  }
}
