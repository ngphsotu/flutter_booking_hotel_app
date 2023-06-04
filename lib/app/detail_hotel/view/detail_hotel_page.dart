import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import '/model/model.dart';
import '../detail_hotel.dart';
import '../../booking/booking.dart';
import '/components/components.dart';

class DetailHotelPage extends StatefulWidget {
  final Room room;

  const DetailHotelPage({super.key, required this.room});

  @override
  State<DetailHotelPage> createState() => _DetailHotelPageState();
}

class _DetailHotelPageState extends State<DetailHotelPage> {
  late ThemeData themeData;
  late DetailBloc detailBloc;

  @override
  void initState() {
    detailBloc = DetailBloc()..getMyHotel(widget.room.idHotel);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.room.urlImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 15, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder<MyHotel>(
            stream: detailBloc.myHotelStream,
            builder: (context, snapshot1) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: themeData.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 25, 30, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot1.data != null
                                ? snapshot1.data!.name.toUpperCase()
                                : ''.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '${widget.room.address}, ${widget.room.city}',
                                  maxLines: 2,
                                  style: const TextStyle(letterSpacing: .6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '420 Reviews',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star_half, color: Colors.yellow),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.room.nameRoom.toUpperCase(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.room.desc,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(letterSpacing: 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ReuseduceButton(
                            title: 'Book now',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BookingPage(
                                      room: widget.room,
                                      myHotel: snapshot1.data!,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
