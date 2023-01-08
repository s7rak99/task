import 'package:flutter/material.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  bool? apply;
  String? post;
  File? image;
  MainPage({Key? key,this.apply , this.post , this.image}) : super(key: key);





  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(15.0),
              width: double.infinity,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20.00)

              ),
              child: Column(
              children: [
                MaterialButton(onPressed: (){
                  Navigator.pushNamed(context, 'second');
                },child: const Text("What's on your mind?", style: TextStyle(fontSize: 20.0, color: Colors.grey),),),
                const SizedBox(height: 15.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.tag_faces , color: Colors.black54,),
                    Icon(Icons.notifications_active_outlined, color: Colors.black54,),
                    Icon(Icons.person_outline_outlined, color: Colors.black54,),

                  ],
                )
              ],
              ),
            ),
            const SizedBox(height: 20.0,),

            Visibility(
              visible: widget.apply ==false ? false : true,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(15.0),
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(20.00)

                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.post == null ? Text(' '): Text(" ${widget.post}", style: TextStyle(fontSize: 20.0, color: Colors.grey),),
                    const SizedBox(height: 15.0,),
                    widget.image == null ? Text(' ') : Image.file(widget.image! ,  height: 200, fit: BoxFit.cover),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       TextButton(onPressed: (){}, child: const Text('Like' ,style: TextStyle(fontSize: 18.0),)),
                        const SizedBox(width: 15.0,),
                        TextButton(onPressed: (){}, child: const Text('Comment',style :TextStyle(fontSize: 18.0),))


                      ],
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
