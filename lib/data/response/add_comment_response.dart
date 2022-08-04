

class AddCommentReposne {
  final String title;
  final String content;
  final String date;
  final int id;

  AddCommentReposne(this.title, this.content, this.date, this.id);

  AddCommentReposne.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        date = json["date"];
}
