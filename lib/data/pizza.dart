class Pizza {
  String name;
  String imagePath;
  String description;
  double cost;
  int backgroundColor;

  Pizza({this.name, this.imagePath, this.description, this.cost, this.backgroundColor});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Pizza &&
              runtimeType == other.runtimeType &&
              name == other.name;

  @override
  int get hashCode => name.hashCode;

}