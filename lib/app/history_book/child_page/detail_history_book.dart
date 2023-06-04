import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import 'detail_history_room.dart';
import '../../booking/booking.dart';
import '/components/components.dart';

class DetailsHistoryBookPage extends StatefulWidget {
  const DetailsHistoryBookPage({super.key});

  @override
  State<DetailsHistoryBookPage> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<DetailsHistoryBookPage> {
  late ThemeData themeData;

  @override
  void initState() {
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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        titleSpacing: 1,
        backgroundColor: themeData.scaffoldBackgroundColor,
        title: Text(
          'Booking hotel'.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('assets/images/travel.png'),
                    fit: BoxFit.cover),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/travel.png'),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Room 2 person',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              const SizedBox(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemService(
                      title: 'Wifi',
                      widget: Icon(
                        Icons.wifi,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    ItemService(
                      title: 'Camera',
                      widget: Icon(
                        Icons.camera_rear,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    ItemService(
                      title: 'Gps',
                      widget: Icon(
                        Icons.gps_fixed,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    ItemService(
                      title: 'Alarms',
                      widget: Icon(
                        Icons.access_alarms,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    ItemService(
                      title: 'Seat',
                      widget: Icon(
                        Icons.airline_seat_recline_extra,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check-in',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        ReuseduceTextFormField(
                          enable: false,
                          hintText: '30/11/2020',
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check-out',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        ReuseduceTextFormField(
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryColor,
                          ),
                          enable: false,
                          hintText: '01/11/2020',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Night',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        ReuseduceTextFormField(
                          enable: false,
                          hintText: '1 Night',
                          prefixIcon: Icon(
                            Icons.nights_stay_outlined,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Number room',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        ReuseduceTextFormField(
                          hintText: '2',
                          enable: false,
                          prefixIcon: Icon(
                            Icons.night_shelter_outlined,
                            color: AppColors.primaryColor,
                          ),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Type room',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const ReuseduceTextFormField(
                enable: false,
                hintText: 'One adult, Two children',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(color: Colors.grey, height: 2),
              const SizedBox(height: 10),
              const Text(
                'Fee and tax details:',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
              const Divider(color: Colors.grey, height: 5),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '360\$',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '-- ${DateFormat.yMMMMd('en').format(DateTime.now())} --',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const DetailsRoomHistoryPage();
          }));
        },
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          child: const Center(
            child: Text(
              'See room details',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
