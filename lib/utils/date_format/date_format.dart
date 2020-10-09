import 'package:cloud_firestore/cloud_firestore.dart';

String toStringDate(DateTime date) {
  const Map<int, String> monthInYears = {
    1: "Января",
    2: "Февраля",
    3: "Марта",
    4: 'Апреля',
    5: 'Мая',
    6: 'Июня',
    7: 'Июля',
    8: 'Августа',
    9: 'Сентября',
    10: 'Октября',
    11: 'Ноября',
    12: 'Декабря',
  };

  return '${date.year} ${date.day} ${monthInYears[date.month]} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
