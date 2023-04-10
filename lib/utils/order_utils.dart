class OrderUtils {
  late int numberRoom;
  late int startDay;
  late int endDay;

  static final OrderUtils _singleton = OrderUtils._internal();

  OrderUtils._internal();

  factory OrderUtils() {
    return _singleton;
  }

  void setOrder(int numberRoom1, int startDay1, int endDay1) {
    numberRoom = numberRoom1;
    startDay = startDay1;
    endDay = endDay1;
  }
}
