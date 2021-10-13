class StringHelper {
  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  String limitString(String input, int length) {
    return input.toString().length <= length
        ? input
        : input.toString().substring(0, length - 2) + '..';
  }

  String formatName(String name, int length) {
    List<String> names = name.split(' ');
    switch (names.length) {
      case 1:
        return name;
      case 2:
        return name;
      case 3:
        if (name.length > length) {
          names.removeAt(1);
          return names.join(' ');
        } else {
          return name;
        }
      case 4:
        if (name.length > length) {
          names.removeAt(1);
          names.removeAt(1);
          return names.join(' ');
        } else {
          return name;
        }
      default:
        if (name.length > length) {
          names.removeAt(1);
          names.removeAt(1);
          names.removeAt(1);
          return names.join(' ');
        } else {
          return name;
        }
    }
  }
}
