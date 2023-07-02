extension Extension on String? {
  bool isNotNullOrEmpty() => this != null && this != '';

  String getExtensionFromUrl(){
    List<String> splits = (this??"").split(".");
    return splits.isNotEmpty ? (splits[splits.length - 1]) : "";
  }
}

