import 'package:flutter/material.dart';
import 'package:flutter_news_app/api_sevices/api_services.dart';
import 'package:flutter_news_app/constants.dart';
import 'package:flutter_news_app/model/newa_model.dart';
import 'package:flutter_news_app/screens/news_detaisl_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  late Future<List<NewsModel>> newsList;
  final ApiServices _apiServices = ApiServices();

  @override
  void initState() {
    newsList=_apiServices.getNews(apiUrl);
    super.initState();
  }
// Future getData()async{
//     setState(() {
//
//     });
//     newsList=await _apiServices.getNews(apiUrl);
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(97),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 32),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: Colors.white))),
              child: AppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  "News",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        key: _refreshIndicatorKey,
        onRefresh: (){
          setState(() {

          });
          return _apiServices.getNews(apiUrl);
        },
        child: FutureBuilder(
          future:newsList,
          builder: (context,AsyncSnapshot<List<NewsModel>> snapshot){
            if(snapshot.data==null){
              return const Center(child: CircularProgressIndicator(),);
            }else if(snapshot.data!.isEmpty){
              return Container(
                child:const Center(
                  child: Center(
                    child: Text('No offers'),
                  ),
                ),
              );
            }

            else{
              var randomItem=snapshot.data!.shuffle();
             return ListView.builder(
                 shrinkWrap: true,

                  itemCount:snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _listItem(snapshot,index);
                  });
            }
        },

        ),
      ),
    );
  }

  _listItem(AsyncSnapshot<List<NewsModel>> snapshot,int index) {
    var data=snapshot.data![index];
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 1, top: 1, bottom: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    snapshot.data![index].title.toString(),
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),),
                Container(
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  child: Align(
                    child: IconButton(
                      alignment: Alignment.bottomCenter,
                      onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return NewsDetailsScreen(newsModel: data,);
                       }));
                      },
                      icon:const Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black26,),
                    ),
                  ),
                )
              ],
            ),
            Text(data.publisher.toString(),style: TextStyle(
              fontSize: 17,color: Colors.grey.shade600
            ),),
           const SizedBox(height: 10,),
           const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Divider(color: Colors.black12,),
            )
          ],
        ),
      ),
    );
  }
}
