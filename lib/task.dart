import 'package:flutter/material.dart';

class Task5 extends StatefulWidget {
  const Task5({Key? key}) : super(key: key);

  @override
  State<Task5> createState() => _Task5State();
}

class _Task5State extends State<Task5> {
  String sort = '';
  String order = '';
  bool fav = false;
  String message =' ';

  static String choose1 = '';
  static String choose2 = '';
  static String choose3 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort Task'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {

                setState(() {

                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Sort by',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        activeColor: Colors.deepOrange,
                                        value: 'title',
                                        groupValue: sort,
                                        onChanged: (val) {
                                          setState(() {
                                            sort = val!;
                                          });
                                        }),
                                    const Text('Title',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        activeColor: Colors.deepOrange,
                                        value: 'create',
                                        groupValue: sort,
                                        onChanged: (val) {
                                          setState(() {
                                            sort = val!;
                                          });
                                        }),
                                    const Text('Date of Create',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        activeColor: Colors.deepOrange,
                                        value: 'modify',
                                        groupValue: sort,
                                        onChanged: (val) {
                                          setState(() {
                                            sort = val!;
                                          });
                                        }),
                                    const Text('Date Modified',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                const Text(
                                    "order .........................................................",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey)),
                                Row(
                                  children: [
                                    Radio(
                                        activeColor: Colors.deepOrange,
                                        value: 'Ascending',
                                        groupValue: order,
                                        onChanged: (val) {
                                          setState(() {
                                            order = val!;
                                          });
                                        }),
                                    const Text('Ascending',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        activeColor: Colors.deepOrange,
                                        value: 'Descending',
                                        groupValue: order,
                                        onChanged: (val) {
                                          setState(() {
                                            order = val!;
                                          });
                                        }),
                                    const Text('Descending',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                const Text(
                                    "...................................................................",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey)),
                                SwitchListTile(
                                    activeColor: Colors.white,
                                    activeTrackColor: Colors.deepOrange,
                                    title: const Text('Pin favorites to top'),
                                    value: fav,
                                    onChanged: (val) {
                                      setState(() {
                                        fav = val;
                                      });
                                    }),
                                Text(
                                  ' $message',
                                  style:
                                  const TextStyle(color: Colors.deepOrange),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Text(
                                      '|',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey[300]),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            print('$sort -- $order -- $fav');

                                            if(fav == true){
                                              if(sort.isEmpty){
                                                message = 'please you should choose all';
                                              }
                                              else{
                                                if( order.isEmpty){
                                                  message = 'please you should choose all';
                                                }
                                                else {
                                                  choose1 = 'Sorted by $sort';
                                                  choose2 = 'Ordered by $order';
                                                  choose3 = 'Pinned it to Favorite';
                                                  Navigator.of(context).pushNamedAndRemoveUntil('home',(route) => false,);
                                                }
                                              }
                                            }
                                            else{
                                              message =
                                              'please you should choose all';
                                            }

                                          });
                                        },
                                        child: const Text(
                                          'Done',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.deepOrange,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                });
              },
              color: Colors.deepOrange,
              textColor: Colors.white,
              height: 60,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              minWidth: 200,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Filter',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.filter_list_alt,
                    size: 30,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              ' $choose1',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              ' $choose2',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              ' $choose3',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
