import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/newa_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsModel newsModel;
  NewsDetailsScreen({
    Key? key,
    required this.newsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          newsModel.title.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20,
          color: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 220,
                width: 400,
                child: buildImage(
                  MediaQuery.of(context).size,
                  newsModel.image.toString(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsModel.title.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        newsModel.publisher.toString(),
                        style: const TextStyle(color: Colors.black26),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        newsModel.text.toString(),
                        style: const TextStyle(wordSpacing: 2),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      Text("Author: ${newsModel.author}"),
                      const SizedBox(height: 12),
                      Text(
                        "Date: ${newsModel.date}",
                        style: const TextStyle(fontSize: 20, color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Full store at :",
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () async{
                         await _launchUrl(Uri.parse(newsModel.url.toString()));
                        },
                        child: Text(
                          newsModel.url.toString(),
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
  Widget buildImage(Size size, String imgUrl) {
    return Container(
      child: Center(
          child: imgUrl == null || imgUrl.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported,
                      size: size.height * 0.1,
                    ),
                  ],
                )
              : CachedNetworkImage(
                  imageUrl: "$imgUrl",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.black.withOpacity(0.5),
                      //       offset: const Offset(0.0, 2.0),
                      //       blurRadius: 5)
                      // ],
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.black12, BlendMode.colorBurn),
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
    );
  }
}
