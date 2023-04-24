import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'explore.dart';

class VideoScreen extends StatefulWidget{

  final String name, mediaUrl;

  VideoScreen({required this.name,required this.mediaUrl});

  // VideoScreen(this.name, this.mediaUrl);

  @override
  _VideoScreenState  createState() => _VideoScreenState();

}
class _VideoScreenState extends State<VideoScreen>{

  late VideoPlayerController _controller;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState(){
    super.initState();
    _controller=VideoPlayerController.network(widget.mediaUrl);
    _controller.initialize().then((_) => setState((){}));
    _controller.setLooping(true);
    _controller.play();

    /*
    BetterPlayerConfiguration betterPlayerConfiguration=BetterPlayerConfiguration(
    aspectRatio: 16/9,
    fit: BoxFit.contain
    );

    BetterPlayerDataSource dataSource=BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.mediaUrl
    );
    _betterPlayerController =BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);

    super.initState();

   */
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          title: Text(widget.name,)
      ),



      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

}