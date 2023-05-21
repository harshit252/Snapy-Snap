import 'dart:convert';
import 'dart:developer';

import 'package:college_project/models/chat_user.dart';
import 'package:college_project/widget/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/apis.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
   Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          leading: const Icon(CupertinoIcons.profile_circled),
          title: const Text('Chat'),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.person_add_solid)),
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.ellipsis_vertical)),
          ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:10),
        child: FloatingActionButton(
          onPressed: () async{},
          backgroundColor: Colors.pink,
          child: const Icon(Icons.add_comment_rounded),
        ),
      ),

      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {

          switch(snapshot.connectionState){
            //if data is loading
            case  ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

              //if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:


              final data = snapshot.data?.docs;
              list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
               /*log('Data: $data');*/

            if( list.isNotEmpty){
              return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    return ChatUserCard(user: list[index],);
                    /*return Text('Name: ${list[index]}');*/
                  }
              );
            }else {
              return const Center(child: Text('No Connections Found!', style: TextStyle(fontSize: 20)));
            }
          }


        }
      ),
    );
  }
}
