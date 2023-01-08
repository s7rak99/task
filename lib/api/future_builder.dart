import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FutureBuilderEx extends StatefulWidget {
  const FutureBuilderEx({Key? key}) : super(key: key);

  @override
  State<FutureBuilderEx> createState() => _FutureBuilderExState();
}

class _FutureBuilderExState extends State<FutureBuilderEx> {
  Future getPost() async {
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/posts?id=14');
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    var response = await http.get(url);
    // var responseBody = response.body;
    var responseBody = jsonDecode(response.body);

    return responseBody;
    // print(responseBody[2]);
  }


  @override
  void initState() {
    getPost();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Api'),
        ),
        body: FutureBuilder(
          future: getPost(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Container(
                      child: Text('${snapshot.data[i]['title']}'),
                    );
                  });
            }
            return CircularProgressIndicator();
          },
        ));
  }
}
