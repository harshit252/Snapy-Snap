import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Card(
        margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
        //color: Colors.blue,
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: (){},
          child:  ListTile(
            leading: const CircleAvatar(child: Icon(CupertinoIcons.person),),
            title: Text(widget.user.name),
            subtitle: Text(widget.user.about, maxLines: 1),
            trailing: const Text('12:00 PM', style: TextStyle(color: Colors.black54),),
          ),
        ));

  }
}
