import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../Client/Presentation/UIManager/MusicPage/music.dart';

class RootClass extends StatefulWidget {
  final Music? music;
  final bool stop;

  const RootClass({this.music, this.stop = false});

  @override
  _RootClassState createState() => _RootClassState();
}

class _RootClassState extends State<RootClass> {
  bool isPlaying = false;
  AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (widget.stop) {
      isPlaying = false;
      _audioPlayer.stop();
    }
  }

  void togglePlay() async {
    isPlaying = !isPlaying;
    if (isPlaying) {
      await _audioPlayer.play(widget.music?.audioURL ?? '');
    } else {
      await _audioPlayer.pause();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Color.fromARGB(255, 70, 70, 70),
      height: 75,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(widget.music?.image ?? '', fit: BoxFit.cover),
          Text(
            widget.music?.name ?? '',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          IconButton(
            onPressed: togglePlay,
            icon: isPlaying
                ? Icon(
                    Icons.pause,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
