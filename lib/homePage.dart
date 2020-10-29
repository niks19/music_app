import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:test1/colors.dart';
import 'package:test1/controlsBtn.dart';

class MusicApp extends StatefulWidget {
  SongInfo songsInfo;
  MusicApp({this.songsInfo});
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  AudioPlayer audioPlayer = AudioPlayer();
  Controls controls = Controls();
  double currValue, minValue = 0.0, maxValue = 0.0;
  String currentTime = '', endTime = '';
  bool isPlaying = false;
  void initState() {
    super.initState();
    setSong(widget.songsInfo);
  }

  void dispose() {
    // to stop playing in background
    super.dispose();
    audioPlayer?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                  color: darkPrimaryColor.withOpacity(0.5),
                  offset: Offset(5, 10),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Playing Now...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(child: Icon(Icons.list)),
              ],
            ),
          ),
          Container(
            height: height / 2.5,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  height: 300,
                  width: 260,
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Image.asset('images/img1.jpg'),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              },
              itemCount: 3,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Text(widget.songsInfo.title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          SliderTheme(
            data: SliderThemeData(
                trackHeight: 5,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6)),
            child: Slider(
              value: currValue,
              activeColor: darkPrimaryColor,
              inactiveColor: darkPrimaryColor.withOpacity(0.3),
              onChanged: (value) {
                setState(() {
                  currValue = value;
                  audioPlayer.seek(Duration(milliseconds: currValue.round()));
                });
              },
              min: minValue,
              max: maxValue,
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -15, 0),
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentTime,
                  style: TextStyle(
                      color: darkPrimaryColor,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  endTime,
                  style: TextStyle(
                      color: darkPrimaryColor,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Buttons(
                icons: Icons.skip_previous,
              ),
              isPlaying
                  ? InkWell(
                      onTap: () => changeStatus(),
                      child: Buttons(
                        icons: Icons.play_arrow_sharp,
                      ),
                    )
                  : InkWell(
                      onTap: () => changeStatus(),
                      child: Buttons(
                        icons: Icons.pause_circle_filled_sharp,
                      ),
                    ),
              Buttons(
                icons: Icons.skip_next_sharp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setSong(SongInfo songInfo) async {
    widget.songsInfo = songInfo;
    await audioPlayer.setUrl(widget.songsInfo.uri);
    currValue = minValue;
    maxValue = audioPlayer.duration.inMilliseconds.toDouble();
    setState(() {
      currentTime = getTime(currValue);
      endTime = getTime(maxValue);
    });
    isPlaying = false;
    changeStatus();
    audioPlayer.positionStream.listen((duration) {
      currValue = duration.inMilliseconds.toDouble();
      setState(() {
        currentTime = getTime(currValue);
      });
    });
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    (isPlaying) ? audioPlayer.play() : audioPlayer.pause();
  }

  String getTime(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((e) => e.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }
}
