List<int> dayCountForMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
List<String> monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
List<String> dayNames = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
List hours() {
  var hours = [];
  for (var i = 0; i <= 23; i++) {
    hours.add(addZeroPrefix(i));
  }
  return hours;
}

List minutes() {
  var minutes = [];
  for (var i = 0; i < 60; i++) {
    minutes.add(addZeroPrefix(i));
  }
  return minutes;
}

int relatedWeekday({int? month, int? year, int? day}) {
  var _monthToString = addZeroPrefix(month);
  var _dayToString = addZeroPrefix(day);
  return DateTime.parse('$year-$_monthToString-$_dayToString').weekday;
  // thứ hai là số 1
}

bool isEqualTwoDate(DateTime date1, DateTime date2) {
  return date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;
}

String addZeroPrefix(number) => '00'.substring(number.toString().length) + '$number';

int dayCountForFebruary(year) {
  return year % 4 == 0 ? 29 : 28;
}

List dayToWeekday({int? month, int? year}) {
  final dayToWeekday = [];
  var _dayCountForMonth = month == 2 ? dayCountForFebruary(year) : dayCountForMonth[month! - 1];
  // vì hiển thị lịch từ chủ nhật, ta thêm 0 vào những ngày trong tuần trước ngày 1
  var fistDayRelatedWeekday = relatedWeekday(day: 1, month: month, year: year);
  if (fistDayRelatedWeekday != 7) {
    // nếu ngày đầu tháng là chủ nhật thì không thêm
    for (var i = 0; i < fistDayRelatedWeekday; i++) {
      dayToWeekday.add(0);
    }
  }

  for (var i = 1; i <= _dayCountForMonth; i++) {
    dayToWeekday.add(i);
  }
  return dayToWeekday;
}

List generateDays(dayCountForMonth) {
  var dayList = [];
  for (var i = 1; i <= dayCountForMonth; i++) {
    dayList.add(i);
  }
  return dayList;
}

List allowedAppointmentDates() {
  var thisMonthList = [];
  var nextMonthList = [];
  for (var i = 0; i <= 365; i++) {
    thisMonthList.add(DateTime.now().subtract(Duration(days: i)).day);
  }
  return [thisMonthList, nextMonthList];
}

bool isShowTime(DateTime currentTime, DateTime prevTime) {
  return currentTime.difference(prevTime).inMinutes >= 20;
}
