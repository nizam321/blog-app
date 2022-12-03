import 'package:blog/custom/custom_dialog.dart';
import 'package:blog/upload_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLike = false;

  final Stream<QuerySnapshot> _blogStream =
      FirebaseFirestore.instance.collection('blog').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Upload()));
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: _blogStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Container(
                          height: 440,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.tealAccent,
                                          child: Text(
                                            data['title'][0],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        data['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Image.network(
                                        data['img'],
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data['details'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.justify,
                                    maxLines: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isLike = !isLike;
                                          });
                                        },
                                        icon: Icon(
                                          isLike
                                              ? Icons.thumb_up
                                              : Icons.thumb_up_outlined,
                                          color: isLike
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          cusstomDialog(context, data['img'],
                                              data['title'], data['details']);
                                        },
                                        child: Text(
                                          'Read more',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
