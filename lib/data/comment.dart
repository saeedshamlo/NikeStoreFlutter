import 'dart:convert';

class CommnetEntiry {
  final int id;
  final String title;
  final String content;
  final String date;
  final String email;

  CommnetEntiry(this.id, this.title, this.content, this.date, this.email);

  CommnetEntiry.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        date = json['date'],
        email = json['author']['email'];
}
