import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import '../booking.dart';
import '/model/model.dart';
import '/utils/utils.dart';
import '../../fire_auth/fire_auth.dart';
import '/components/components.dart';
import '../../history_book/history_book.dart';

class BookingPage extends StatefulWidget {
  final Room room;
  final MyHotel myHotel;

  const BookingPage({super.key, required this.room, required this.myHotel});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late final ThemeData themeData;
  late final TextEditingController controllerCheckIn;
  late final TextEditingController controllerCheckOut;
  late final TextEditingController controllerNight;
  late final TextEditingController controllerNumberRoom;
  late final TextEditingController controllerType;

  @override
  void initState() {
    super.initState();
    controllerCheckIn = TextEditingController(
        text:
            '${DateTime.parse(OrderUtils().startDay as String).day}/${DateTime.parse(OrderUtils().startDay as String).month}/${DateTime.parse(OrderUtils().startDay as String).year}');
    controllerCheckOut = TextEditingController(
        text:
            '${DateTime.parse(OrderUtils().endDay as String).day}/${DateTime.parse(OrderUtils().endDay as String).month}/${DateTime.parse(OrderUtils().endDay as String).year}');
    controllerNight = TextEditingController(
        text:
            '${DateTime.parse(OrderUtils().endDay as String).difference(DateTime.parse(OrderUtils().startDay as String)).inDays}');
    controllerNumberRoom =
        TextEditingController(text: '${OrderUtils().numberRoom}');
    controllerType = TextEditingController(
        text:
            '${widget.room.numberAdults} Adults - ${widget.room.numberChild} Child');
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
        backgroundColor: themeData.scaffoldBackgroundColor,
        leading: GestureDetector(
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
                  Icons.arrow_back_ios_rounded,
                  size: 15,
                  color: themeData.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        titleSpacing: 1,
        title: Text(
          widget.myHotel.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
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
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.room.urlImage),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.room.nameRoom.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star, color: Colors.yellow),
                                Icon(Icons.star_half, color: Colors.yellow),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Check In',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ReuseduceTextFormField(
                          enable: false,
                          controller: controllerCheckIn,
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Check Out',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ReuseduceTextFormField(
                          enable: false,
                          controller: controllerCheckOut,
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Night',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ReuseduceTextFormField(
                          enable: false,
                          controller: controllerNight,
                          prefixIcon: const Icon(
                            Icons.nights_stay,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Number Rooms',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ReuseduceTextFormField(
                          enable: false,
                          controller: controllerNumberRoom,
                          prefixIcon: const Icon(
                            Icons.room_preferences,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Adults & Children',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ReuseduceTextFormField(
                enable: false,
                controller: controllerType,
                hintText: 'Two Adults - One Children',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 50),
              const Divider(color: Colors.grey, height: 2),
              const SizedBox(height: 10),
              const Text(
                'Fee and tax details:',
                style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemDetailsTax(
                      title: 'Per night',
                      isShowNumber: true,
                      number: OrderUtils().numberRoom,
                      price: (widget.room.money -
                          widget.room.money * widget.room.discount / 100),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const Divider(color: Colors.grey, height: 5),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '${(widget.room.money - widget.room.money * widget.room.discount / 100) * OrderUtils().numberRoom * int.parse(controllerNight.text)}\$',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ReuseduceButton(
          title: 'Book Now',
          onPressed: () {
            _showBankTransfer(themeData);
          },
        ),
      ),
    );
  }

  void _showBankTransfer(ThemeData themeData) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Center(
          child: PopUpBankTransfer(
            myHotel: widget.myHotel,
            themeData: themeData,
            totalPrice: (widget.room.money -
                    widget.room.money * widget.room.discount / 100) *
                OrderUtils().numberRoom *
                int.parse(controllerNight.text),
            onOK: () {
              FireAuth().createOrder(
                  widget.room.idRoom,
                  controllerCheckIn.text,
                  controllerCheckOut.text,
                  int.parse(controllerNight.text),
                  int.parse(controllerNumberRoom.text),
                  (widget.room.money -
                          widget.room.money * widget.room.discount / 100) *
                      OrderUtils().numberRoom *
                      int.parse(controllerNight.text), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HistoryBookPage();
                    },
                  ),
                );
              }, (val) {});
            },
          ),
        );
      },
    );
  }
}
