import 'dart:convert';
import 'package:flutter_news_app/model/newa_model.dart';
import 'package:http/http.dart'as http;
class ApiServices{
 bool _isLoading=false;


 Future<List<NewsModel>> getNews(String url)async{
   final response=await http.get(Uri.parse(url));
   List<NewsModel> news=[];
   try{
     _isLoading=true;
     if(response.statusCode==200){
       var jsonNotes=json.decode(response.body);
       print(jsonNotes);
       for(var note  in jsonNotes){
         news.add(NewsModel.fromJson(note));
       }
     }
     return news;
   }catch(e){
     _isLoading=false;
     throw Exception();
   }

 }
}