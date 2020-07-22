import 'package:flutter/material.dart';
import 'package:flutteronline/widgets/menu.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int totalResults  = 0;
  bool isLoading = true;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  int page =1;
  int pageSize = 5;

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      articles.clear();
      page = 1 ;
    });
    _getData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(page < (totalResults / pageSize).ceil()){
      if(mounted){
        setState(() {
          page = ++page;
        });
       _getData();
       _refreshController.loadComplete();
      }
    }else{
      _refreshController.loadNoData();
      _refreshController.resetNoData();
    }

    
   
  }

  _getData() async{
    try {
    setState(() {
      page == 1 ? isLoading = true : isLoading = false;
    });  
    var url = 'https://newsapi.org/v2/top-headlines?country=th&apiKey=ade89f88ca4647448cf1de72b7d0220f&page=$page&pageSize=$pageSize';
    var response = await http.get(url);
    if(response.statusCode == 200){
      //print(response.body);
      final Map<String, dynamic> news =  convert.jsonDecode(response.body);
      setState(() {
        totalResults = news['totalResults'];
        articles.addAll(news['articles']);
        isLoading = false;
      });
    }else{
      //error 400,500
       setState(() {
        isLoading = false;
      });
      print('error from backend ${response.statusCode}');
    }
    } catch(e) {
        setState(() {
        isLoading = false;
      });
    } 
  }

  @override
  void initState() { 
    super.initState();
    _getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        centerTitle: true,
        title: totalResults > 0 ? Text('news $totalResults news') : null
      ),
      body: isLoading == true ?  
        Center(
          child: CircularProgressIndicator(), 
        ) : SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(
          refreshStyle: RefreshStyle.Follow,
          refreshingText: 'download data...',
          completeText: 'finish',
        ),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CircularProgressIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }else if(mode == LoadStatus.noMore){
              body = Text("not found");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:  ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'newsstack/webview', arguments: {
                  'url' : articles[index]['url'],
                  'name' : articles[index]['source']['name']
                });
              },
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : <Widget>[
                SizedBox(
                  height : 200,
                  child : Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: articles[index]['urlToImage'] != null ? 
                        Ink.image(image: NetworkImage(articles[index]['urlToImage']), fit: BoxFit.cover) : 
                        Ink.image(image: NetworkImage('https://picsum.photos/500/200'), fit: BoxFit.cover)
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        top: 16,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.bottomLeft,
                          child :Text(articles[index]['source']['name'], style: TextStyle(color: Colors.white70)),
                        ),
                      )
                    ]
                  )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        articles[index]['title']
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            articles[index]['author'] != null ? 
                            Chip(
                              avatar: Icon(Icons.person_pin),
                              label: articles[index]['author'].length < 20 ? 
                              Text(articles[index]['author']) :
                              Text(articles[index]['author'].substring(0,20))
                              ,
                            )
                            : Text(''),
                            Text(DateFormat.yMd().add_Hms().format(DateTime.parse(articles[index]['publishedAt'])))
                          ])
                    ]),
                )
              
              ])
            )
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(), 
        itemCount: articles.length
        )
      ),
        
        
        
        
        
        
        
        
        
        
        
        
        
       
    );
  }
}
