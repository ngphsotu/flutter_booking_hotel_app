class ItemModel {
  String id;
  String name;

  ItemModel({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory ItemModel.formJson(Map<String, dynamic> json) {
    return ItemModel(id: json['id'], name: json['name']);
  }
}
