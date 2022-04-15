extension StringHelper on String {
  String limitLength(int length) {
    String input = this;
    return input.toString().length <= length
        ? input
        : input.toString().substring(0, length - 2) + '..';
  }

  formatMoney({String splitBy = ','}) {
    String result = '';
    int count = 0;
    for (int i = this.length - 1; i >= 0; i--) {
      if (count == 3) {
        count = 1;
        result += splitBy;
      } else {
        count++;
      }
      result += this[i];
    }
    String formatMoney = '';
    for (int i = result.length - 1; i >= 0; i--) {
      formatMoney += result[i];
    }
    return formatMoney;
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
