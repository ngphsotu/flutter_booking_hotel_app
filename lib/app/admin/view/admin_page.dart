import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import '/model/model.dart';
import '../bloc/bloc.dart';
import '../widget/widget.dart';
import '/components/components.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late ThemeData themeData;
  late AdminBloc adminBloc;

  @override
  void initState() {
    super.initState();
    adminBloc = AdminBloc()..init();
  }

  @override
  void dispose() {
    adminBloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leadingWidth: 70,
        titleSpacing: 1,
        backgroundColor: themeData.scaffoldBackgroundColor,
        title: Text(
          'Administrator'.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: themeData.textSelectionTheme.selectionColor,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.home,
                    size: 20,
                    color: themeData.scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: SizedBox(
                width: double.infinity,
                child: TabBar(
                  labelColor: AppColors.primaryColor,
                  indicatorColor: AppColors.primaryColor,
                  indicatorWeight: 2,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Text('Approve Room')),
                    Tab(icon: Text('Permission Account')),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StreamBuilder<List<Room>>(
                    stream: adminBloc.listRoomStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isNotEmpty) {
                          return SingleChildScrollView(
                              child: Column(
                                  children: snapshot.data!
                                      .map((e) => ItemNewRoom(
                                            room: e,
                                            adminBloc: adminBloc,
                                            themeData: themeData,
                                          ))
                                      .toList()));
                        } else {
                          return const NoFoundWidget(title: 'No news');
                        }
                      } else {
                        return const LoadingBar();
                      }
                    },
                  ),
                  StreamBuilder<List<Account>>(
                    stream: adminBloc.accountStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                            child: Column(
                                children: snapshot.data!
                                    .map((e) => ItemUser(
                                          account: e,
                                          adminBloc: adminBloc,
                                          themeData: themeData,
                                        ))
                                    .toList()));
                      } else {
                        return const LoadingBar();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
