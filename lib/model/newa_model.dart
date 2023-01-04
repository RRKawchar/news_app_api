class NewsModel {
  String id;
  String url;
  String title;
  String text;
  String publisher;
  String author;
  String image;
  String date;

  NewsModel({
    required this.id,
    required this.url,
    required this.title,
    required this.text,
    required this.publisher,
    required this.author,
    required this.image,
    required this.date,
  });

  NewsModel fromJson(Map<String, dynamic> json) {
    return NewsModel(
        id: json['id'],
        url: json['url'],
        title: json['title'],
        text: json['text'],
        publisher: json['publisher'],
        author: json['author'],
        image: json['image'],
        date: json['date']);
  }
}
