import 'package:flutter/material.dart';

import '/ui/ui.dart';
import '../admin.dart';
import '/model/model.dart';
import '/components/components.dart';
import '../../history_book/history_book.dart';

class ItemNewRoom extends StatelessWidget {
  final Room room;
  final ThemeData themeData;
  final AdminBloc adminBloc;

  const ItemNewRoom({
    super.key,
    required this.room,
    required this.themeData,
    required this.adminBloc,
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
                  fit: BoxFit.cover,
                  image: NetworkImage(room.urlImage),
                ),
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
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsRoomHistoryPage(room: room);
                                },
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.error,
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
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'x${room.numberRoom} Room',
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      room.discount != 0
                          ? Expanded(
                              flex: 1,
                              child: Text(
                                "${room.money.toInt()}\$",
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.lineThrough,
                                  letterSpacing: 1,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${(room.money - room.money * room.discount / 100).toInt()}\$',
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ReuseduceButton(
                          title: 'Ok'.toUpperCase(),
                          color: AppColors.primaryColor,
                          height: 40,
                          onPressed: () {
                            adminBloc.updateStatusRoomById(room.idRoom, 2);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ReuseduceButton(
                          title: 'Cancel',
                          color: Colors.grey,
                          height: 40,
                          onPressed: () {
                            adminBloc.updateStatusRoomById(room.idRoom, 0);
                          },
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
