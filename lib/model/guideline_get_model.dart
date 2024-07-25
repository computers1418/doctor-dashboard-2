class GuidelineGetModel {
  String id;
  String content;

  GuidelineGetModel({
    required this.id,
    required this.content,
  });

  factory GuidelineGetModel.fromJson(Map<String, dynamic> json) {
    return GuidelineGetModel(
      id: json['_id'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
    };
  }
}
