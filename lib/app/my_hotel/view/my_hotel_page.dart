import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import '../my_hotel.dart';
import '/model/model.dart';
import '/components/components.dart';

class MyHotelPage extends StatefulWidget {
  const MyHotelPage({super.key});

  @override
  State<MyHotelPage> createState() => _MyHotelPageState();
}

class _MyHotelPageState extends State<MyHotelPage> {
  late final MyHotel myHotel;
  late final ThemeData themeData;
  late final HotelBloc hotelBloc;

  @override
  void initState() {
    super.initState();
    hotelBloc = HotelBloc()..init();
  }

  @override
  void dispose() {
    super.dispose();
    hotelBloc.dispose();
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
          'My Hotel'.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: themeData.textSelectionTheme.selectionColor,
            fontWeight: FontWeight.bold,
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
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.home,
                    size: 15,
                    color: themeData.scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          StreamBuilder<MyHotel>(
            stream: hotelBloc.myHotelStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: const Icon(
                    Icons.mode_edit,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditHotel(myHotel: myHotel);
                        },
                      ),
                    );
                    hotelBloc.getMyHotel();
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder<MyHotel>(
            stream: hotelBloc.myHotelStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                myHotel = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data!.urlImage),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.data!.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: AppColors.primaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    snapshot.data!.phone,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Room list'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: 200,
                        child: Divider(
                          height: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            StreamBuilder<List<Room>>(
                              initialData: const [],
                              stream: hotelBloc.listRoomStream,
                              builder: (context, snapshot1) {
                                return Column(
                                  children: snapshot1.data!
                                      .map((e) => ItemMyRoom(
                                          themeData: themeData,
                                          room: e,
                                          hotelBloc: hotelBloc))
                                      .toList(),
                                );
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ReuseduceButton(
                                title: 'New Room',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const NewRoom();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 200,
                        height: 200,
                        child: NoFoundWidget(title: 'Don\'t have hotel'),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ReuseduceButton(
                          title: 'Create New',
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const NewHotel();
                                },
                              ),
                            );
                            hotelBloc.getMyHotel();
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          StreamBuilder<UIState>(
            stream: hotelBloc.myHotelStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING) {
                return const LoadingBar();
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }
}
