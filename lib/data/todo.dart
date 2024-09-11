class ToDo {
  final String title;
  final String subtitle;
  bool isDone;

  ToDo({
    this.title = ' ',
    this.subtitle = ' ',
    this.isDone = false,
  });

  ToDo copyWith({
    String? title,
    String? subtitle,
    bool? isDone,
  }){
    return ToDo(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone
    );
  }

  factory ToDo.fromJson(Map<String, dynamic> json){
    return ToDo(
      title: json['title'],
      subtitle: json['subtitle'],
      isDone: json['isDone'],
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone
    };
  }
  @override
  String toString(){
    return '''ToDo{
    title: $title\n
    subtitle: $subtitle\n
    isDone: $isDone\n
    }''';
  }
}
