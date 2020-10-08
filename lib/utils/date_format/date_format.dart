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

  return '${DateTime.now().year} ${DateTime.now().day} ${monthInYears[DateTime.now().month]} ${DateTime.now().hour}:${DateTime.now().minute}';
}
