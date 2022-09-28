class Helpers {
  List<String> addElementBetweenItems(List<String> items, String element) {
    final List<String> newList = [];
    for (String item in items) {
      newList.add(item + element);
    }
    return newList;
  }

  //TODO: доделать
}