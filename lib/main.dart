import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'itemDetails.dart';

class News {
  String? title;
  String? picture;
  String? content;
  String? id;

  News({this.title, this.picture, this.content, this.id});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    picture = json['picture'];
    content = json['content'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['picture'] = this.picture;
    data['content'] = this.content;
    data['id'] = this.id;
    return data;
  }
}


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/itemdetails': (context) => ItemDetailsPage(),
    },
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(body:  const MyHomePage(title: 'Fetch data example',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<News> listArray = [];
  var url =
      Uri.parse('https://62d4154fcd960e45d452f790.mockapi.io/api/article');
  var response;
  fetch() async {
    var res = await http.get(url);
    var result =
        (convert.jsonDecode(res.body )as List).map((e) => News.fromJson(e)).toList();
    return result;
  }

  var jsonResponse;

  @override
  void initState() {
    Future<dynamic> res = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
        future: fetch(),
        builder: (BuildContext _context2, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            listArray = snapshot.data;
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext _context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    
                    child: ListTile(
                        
                        leading:  Image.network(listArray[index].picture!),
                        trailing: Text(
                          listArray[index].title!,
                        ),
                        onTap: ()=>{
                          Navigator.pushNamed(
                          context,
                          '/itemdetails',
                          arguments: <String,String>{
                            "title": listArray[index].title!,
                            "content":listArray[index].content!,
                            "picture":listArray[index].picture!,
                          
                        }
                          
                        ),
                        
                        
                        },
                        ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Text('something else entirely');
          }
        },
      )),
    );
  }
}
