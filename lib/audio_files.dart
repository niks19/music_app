import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:test1/homePage.dart';

class Tracks extends StatefulWidget {
  @override
  _TracksState createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  int curr_index = 0;

  //final GlobalKey<MusicPlayerState> key = GlobalKey<MusicPlayerState>();

  void initState() {
    super.initState();
    getFiles();
  }

  void getFiles() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        leading: Icon(
          Icons.music_note,
          color: Colors.black,
        ),
        title: Text('Dyeus Music App', style: TextStyle(color: Colors.black)),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundImage: songs[index].albumArtwork == null
                ? AssetImage('images/img1.jpg')
                : AssetImage('images/img1.jpg'),
          ),
          title: Text(songs[index].title),
          subtitle: Text(songs[index].artist),
          onTap: (){
            curr_index = index;
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MusicApp(songsInfo: songs[curr_index],)));
          },
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: songs.length, 
      ),
    );
  }
}
