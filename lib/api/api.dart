import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIEX extends StatefulWidget {
  const APIEX({Key? key}) : super(key: key);

  @override
  State<APIEX> createState() => _APIEXState();
}

class _APIEXState extends State<APIEX> {

  List posts =[];
  getPost() async{
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  var response = await http.get(url);
  // var responseBody = response.body;
    var responseBody = jsonDecode(response.body);
    setState(() {
      posts.addAll(responseBody);

    });
    print(posts);

    // print(responseBody[2]);
  }
  @override
  void initState() {
    getPost();
    super.initState();
  }


  List index =[1,2,3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Api'),),
      body:
          posts == null || posts.isEmpty?
              const Center(child:CircularProgressIndicator(),):
      ListView.separated(
        itemCount: index.length,
        itemBuilder: ( context,  i) {
          return Text('${posts[i]['title']}', style: const TextStyle(fontSize: 15),);
        }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height:30);},
      ),
    );
  }
}
