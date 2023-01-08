import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/task/main_page.dart';

String name = '';
class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  File? image;
  String? post;

  static String message = '';

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on MissingPluginException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  Future takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on MissingPluginException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          ElevatedButton(
              onPressed: () {
               setState(() {
                 if (post != null) {
                   if (image != null) {
                     Navigator.of(context)
                         .pushReplacement(MaterialPageRoute(builder: (context) {
                       return MainPage(
                         apply: true,
                         post: post,
                         image: image,
                       );
                     }));
                   } else {
                     // name = post!;
                     // print(name);
                     Navigator.of(context)
                         .pushReplacement(MaterialPageRoute(builder: (context) {
                       return MainPage(
                         apply: true,
                         post: post,
                       );
                     }));
                   }
                 } else if (image != null) {
                   Navigator.of(context)
                       .pushReplacement(MaterialPageRoute(builder: (context) {
                     return MainPage(
                       apply: true,
                       image: image,
                     );
                   }));
                 } else {
                   message = 'you cannot post empty ';
                 }
               });
              },
              child: const Text('Post'))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onFieldSubmitted: (val) {
                          post = val!;
                          print(post);
                        },
                        decoration:
                            const InputDecoration(hintText: "What's on your mind?"),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      image == null
                          ?  Text(
                              ' $message',
                              style: const TextStyle(color: Colors.grey),
                            )
                          : Stack(
                            children: [
                              Image.file(image!),
                              Positioned(
                                left: 310,
                                child: IconButton(onPressed: (){
                                  setState(() {
                                    image= null;
                                  });
                                }, icon: Icon(Icons.clear,size: 30,color: Colors.black87,)),
                              )
                            ],
                          ),

                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  IconButton(
                      onPressed: (){
                        setState(() {
                          showModalBottomSheet(
                              context: context,
                              builder: (context){
                                return StatefulBuilder(builder : (context , setState){
                                  return Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 150,
                                    child: Column(
                                      children: [
                                        const Text('please choose image', style: TextStyle(fontSize: 20, color: Colors.grey),textAlign: TextAlign.center,),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(onPressed:(){
                                              pickImage();
                                              Navigator.pop(context);
                                            }, icon: const Icon(Icons.image_search , size: 50,)),
                                            const SizedBox(width: 25,),
                                            IconButton(onPressed:(){
                                              takeImage();
                                              Navigator.pop(context);
                                            }, icon: const Icon(Icons.camera_enhance_outlined , size: 50,)),
                                          ],
                                        )
                                      ],
                                    ),
                                  );

                                });

                              });

                        });

                      },
                      icon: const Icon(
                        Icons.camera_alt_sharp,
                        size: 30.0,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
