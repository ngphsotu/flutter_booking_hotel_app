import 'package:flutter/material.dart';

import '/ui/ui.dart';
import '/model/model.dart';
import '../../fire_auth/fire_auth.dart';
import '../history_book.dart';
import '/components/components.dart';

class ItemHistory extends StatefulWidget {
  final bool isCancel;
  final ThemeData themeData;
  final Transactions transactions;
  final HistoryBookingBloc historyBookingBloc;

  const ItemHistory({
    super.key,
    this.isCancel = false,
    required this.themeData,
    required this.transactions,
    required this.historyBookingBloc,
  });

  @override
  State<ItemHistory> createState() => _ItemHistoryState();
}

class _ItemHistoryState extends State<ItemHistory> {
  @override
  void initState() {
    widget.historyBookingBloc.getRoom(widget.transactions.idRoom);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.themeData.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder<Room>(
              stream: widget.historyBookingBloc.myRoomStream,
              builder: (context, snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    image: snapshot.hasData
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(snapshot.data!.urlImage),
                          )
                        : const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/travel.png'),
                          ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: StreamBuilder<Room>(
                          stream: widget.historyBookingBloc.myRoomStream,
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.hasData
                                  ? snapshot.data!.nameRoom.toUpperCase()
                                  : '',
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.6,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'x${widget.transactions.numberRoom} Rooms  x${widget.transactions.night} Nights',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.transactions.checkIn,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.transactions.checkOut,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${widget.transactions.totalMoney.toInt()}\$',
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: widget.isCancel
                            ? ReuseduceButton(
                                color: Colors.grey,
                                title: 'Cancel',
                                height: 30,
                                onPressed: () {
                                  FireAuth().updateOrderStatus(
                                      3, widget.transactions.id, () {
                                    widget.historyBookingBloc
                                        .getHistoryBooking();
                                  });
                                },
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Create: ${DateTime.parse(widget.transactions.createDay).day}/${DateTime.parse(widget.transactions.createDay).month}/${DateTime.parse(widget.transactions.createDay).year}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
