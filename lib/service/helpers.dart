class Helpers {
  static String createStringFromItemsList(List<String> list) {
    String res = '';
    for (String item in list) {
      res += item;
    }
    return res;
  }
}