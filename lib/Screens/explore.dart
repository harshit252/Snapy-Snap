import 'package:college_project/Screens/video_screen.dart';
import 'package:college_project/builders/ImageBuild.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

List videoList = [
  {
    'title': 'Big Buck Bunny',
    'media_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'thumb_url': 'https://i.ytimg.com/vi/wWla97L1wng/maxresdefault.jpg',
  },
  {
    'title': 'Elephant Dream',
    'media_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'thumb_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg'
  },
  {
    'title': 'Rain and Nature',
    'media_url':
        'https://vod-progressive.akamaized.net/exp=1677230574~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F553%2F15%2F377769527%2F1578621354.mp4~hmac=9a00842effc0732ccb6b3cee29d20b4c49857f4f1418a46250402490c6108481/vimeo-prod-skyfire-std-us/01/553/15/377769527/1578621354.mp4',
    'thumb_url':
        'https://www.lanternstay.com/wp-content/uploads/2016/08/lanternstay-wooden-cottage-6-2.jpg'
  },
  {
    'title': 'For Bigger Fun',
    'media_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'thumb_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg',
  },
  {
    'title': 'For Bigger Joyrides',
    'media_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'thumb_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg'
  },
  {
    'title': 'For Bigger Meltdowns',
    'media_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    'thumb_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerMeltdowns.jpg'
  },
  {
    'title': 'Wind Chime',
    'media_url':
        'https://vod-progressive.akamaized.net/exp=1677230161~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4951%2F11%2F299756227%2F1144339526.mp4~hmac=85b41ec01d154d686c7c913e8d4eaa7eeb8721a9045d4331105325a5fee03ffd/vimeo-prod-skyfire-std-us/01/4951/11/299756227/1144339526.mp4',
    'thumb_url':
        'https://www.chessingtongardencentre.co.uk/media/catalog/product/cache/fe488c779dd51f5a2d8b487b042e148e/3/0/3000386213_pic01.jpg',
  },
  {
    'title': 'Subaru Outback On Street And Dirt',
    'media_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
    'thumb_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/images/SubaruOutbackOnStreetAndDirt.jpg',
  },
  {
    'title': 'Tears Of Steel',
    'media_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    'thumb_url':
        'https://storage.googleapis.com/gtv-videos-bucket/sample/images/TearsOfSteel.jpg',
  },
];

class Explore extends StatelessWidget {
  Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.deepPurple[200],
        title: Text(
          'Explore',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 40.0,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.account_circle_rounded,
            size: 35.0,
            color: Colors.black26,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.account_circle_outlined,
                size: 35.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), // Set the corner radius
        ),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: videoList
              .map((e) => GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoScreen(
                                name: e['title'], mediaUrl: e['media_url']))),
                    child: Image.network(e['thumb_url']!),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
