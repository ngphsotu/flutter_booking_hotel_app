import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import '/model/model.dart';
import '../../home/home.dart';
import 'widget/item_search.dart';
import '../../profile/profile.dart';
import '/components/components.dart';

class OutputSearchPage extends StatefulWidget {
  final HomeBloc homeBloc;

  const OutputSearchPage({super.key, required this.homeBloc});

  @override
  State<OutputSearchPage> createState() => _OutputSearchPageState();
}

class _OutputSearchPageState extends State<OutputSearchPage> {
  late ThemeData themeData;

  @override
  void initState() {
    super.initState();
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
        elevation: 0,
        centerTitle: true,
        backgroundColor: themeData.scaffoldBackgroundColor,
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
                  Icons.arrow_back_ios_rounded,
                  size: 15,
                  color: themeData.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          'Search'.toUpperCase(),
          style: TextStyle(
            color: themeData.textSelectionTheme.selectionColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<Account>(
              stream: widget.homeBloc.accountStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ProfilePage();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(snapshot.data!.avatar),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const LoadingBar();
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Room>>(
              stream: widget.homeBloc.listRoomStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemSearch(room: snapshot.data![index]);
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return const NoFoundWidget(title: '');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
