import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FutureBuilder2Ex extends StatefulWidget {
  const FutureBuilder2Ex({Key? key}) : super(key: key);

  @override
  State<FutureBuilder2Ex> createState() => _FutureBuilder2ExState();
}

class _FutureBuilder2ExState extends State<FutureBuilder2Ex> {

  Future getPost() async {
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // var url = Uri.parse('https://jsonplaceholder.typicode.com/posts?id=14');
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=1');

    var response = await http.get(url);
    // var responseBody = response.body;
    var responseBody = jsonDecode(response.body);

    return responseBody;
    // print(responseBody[2]);
  }

  Future addPost() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.post(
      url,
      body: {
        'title': 'foo',
        'body': 'bar',
        'userId': '1',
      },

    );
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    return responseBody;
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
        body: Column(
          children: [
            ElevatedButton(onPressed: (){
              addPost();
            }, child: const Text('add post')),
            FutureBuilder(
              future: getPost(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Container(
                          child: Text('${snapshot.data[i]['title']}'),
                        );
                      });
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ));
  }
}



















// headers: {
//   'Content-type': 'application/json; charset=UTF-8',
// },