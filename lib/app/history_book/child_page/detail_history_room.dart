import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import '/model/model.dart';
import '../../booking/booking.dart';

class DetailsRoomHistoryPage extends StatefulWidget {
  final Room? room;

  const DetailsRoomHistoryPage({super.key, this.room});

  @override
  State<DetailsRoomHistoryPage> createState() => _DetailHomeStayScreenState();
}

class _DetailHomeStayScreenState extends State<DetailsRoomHistoryPage> {
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
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.room!.urlImage),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
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
          Column(
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
                        'Booking Hotels'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
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
                          Text(
                            '${widget.room!.address}, ${widget.room!.city}',
                            maxLines: 2,
                            style: const TextStyle(letterSpacing: .6),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                Text(
                                  '4.5',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
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
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(.3),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ItemDetailsTax(
                              title: 'Per night',
                              price: 230,
                              number: 1,
                              isShowNumber: true,
                            ),
                            SizedBox(height: 10),
                            ItemDetailsTax(
                              title: 'Car',
                              price: 230,
                              number: 2,
                              isShowNumber: true,
                            ),
                            SizedBox(height: 10),
                            ItemDetailsTax(
                              title: 'Discount',
                              price: -22,
                              number: 1,
                            ),
                            SizedBox(height: 10),
                            ItemDetailsTax(
                              title: 'Per night',
                              price: 0,
                              number: 1,
                            ),
                            SizedBox(height: 10),
                            ItemDetailsTax(
                              title: 'Per night',
                              price: 0,
                              number: 1,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.room!.nameRoom,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.room!.desc,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: const TextStyle(letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.47,
            right: 25,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeData.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 5,
                    spreadRadius: 6,
                  ),
                ],
              ),
              child: const Icon(Icons.favorite, color: AppColors.red),
            ),
          )
        ],
      ),
    );
  }
}
