// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    this.id,
    this.url,
    this.title,
    this.text,
    this.publisher,
    this.author,
    this.image,
    this.date,
  });

  String? id;
  String? url;
  String? title;
  String? text;
  String? publisher;
  String? author;
  String? image;
  DateTime? date;


  factory NewsModel.fromJson(Map<String,dynamic> json){
    return NewsModel(
      id: json['id'],
      url: json['url'],
      title: json['title'],
      text: json['text'],
      publisher: json['publisher'],
      author: json['author'],
      image: json['image'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "title": title,
    "text": text,
    "publisher": publisher,
    "author": author,
    "image": image,
    "date": date!.toIso8601String(),
  };
}
