import 'package:flutter/material.dart';

import '../LibraryPage/happy_playlist.dart';
import '../MusicPage/music.dart';
import '../MusicPage/music_operations.dart';

class LibraryPage extends StatelessWidget {
  Function(Music, {bool stop, bool isPlaying}) _miniPlayer;
  LibraryPage(this._miniPlayer, {super.key});

  Widget createMusic(Music music) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 100, 100, 100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                _miniPlayer(music, stop: false, isPlaying: true);
              },
              child: Image.network(
                music.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  music.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  music.desc,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createMusicList(String label) {
    List<Music> musicList = MusicOperations.getMusic();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
          ),
          Container(
            height: 725,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, index) {
                return createMusic(musicList[index]);
              },
              itemCount: musicList.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        Container(
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            createMusicList('Library'),
          ]),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        )
      ]),
    );
  }
}
