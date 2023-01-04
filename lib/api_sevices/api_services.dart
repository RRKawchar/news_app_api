import 'dart:convert';

import 'package:flutter_news_app/model/newa_model.dart';
import 'package:http/http.dart'as http;
class ApiServices{
 bool _isLoading=false;
 String url="http://www.mocky.io/v2/5ecfddf13200006600e3d6d0";

 Future<List<NewsModel>> getNews()async{

   try{
     _isLoading=true;
     final response=await http.get(Uri.parse(url));
     if(response.statusCode==200){

       var data= response.body;
       var jsonData=json.decode(data);

       return jsonData;
     }else{
       return json.decode(response.body);
     }
   }catch(e){
     _isLoading=false;
     throw Exception();
   }

 }
}