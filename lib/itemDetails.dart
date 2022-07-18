import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:fetch/main.dart';



class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;

    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.network(args['picture']),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(args['title'],textScaleFactor: 2,),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(args['content']),
        )
      ]),
    );
  }
}

