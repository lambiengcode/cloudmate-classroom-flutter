extension StringHelper on String {
  String limitLength(int length) {
    String input = this;
    return input.toString().length <= length
        ? input
        : input.toString().substring(0, length - 2) + '..';
  }

  String formatName(int length) {
    String name = this;
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
