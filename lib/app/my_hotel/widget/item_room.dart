import 'package:flutter/material.dart';

import '/ui/ui.dart';
import '../my_hotel.dart';
import '/model/model.dart';

class ItemMyRoom extends StatelessWidget {
  final ThemeData themeData;
  final Room room;
  final HotelBloc hotelBloc;

  const ItemMyRoom({
    super.key,
    required this.themeData,
    required this.room,
    required this.hotelBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                    image: NetworkImage(room.urlImage), fit: BoxFit.cover),
              ),
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
                        child: Text(
                          room.nameRoom.toUpperCase(),
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditRoomPage(room: room);
                                },
                              ),
                            );
                            // hotelBloc.getMyRoom();
                          },
                          child: const Icon(
                            Icons.mode_edit,
                            color: AppColors.primaryColor,
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
                          '${room.numberAdults} Adults - ${room.numberChild} Children',
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'x${room.numberRoom} Room',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
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
                      Text(
                        '${DateTime.parse(room.startDay).day}/${DateTime.parse(room.startDay).month}/${DateTime.parse(room.startDay).year}',
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 15,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${DateTime.parse(room.endDay).day}/${DateTime.parse(room.endDay).month}/${DateTime.parse(room.endDay).year}',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      room.discount != 0
                          ? Text(
                              '${room.money.toInt()}\$',
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.lineThrough,
                                letterSpacing: 1,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 10),
                      Text(
                        '${(room.money - room.money * room.discount / 100).toInt()}\$',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
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
