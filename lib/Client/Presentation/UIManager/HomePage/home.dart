import 'package:flutter/material.dart';

import '../../../../widget/scrollable_containers.dart';
import '../LibraryPage/category.dart';
import '../LibraryPage/category_operations.dart';
import '../LibraryPage/happy_playlist.dart';
import '../MusicPage/angry_playlist_page.dart';
import '../MusicPage/calm_playlist_page.dart';
import '../MusicPage/music.dart';
import '../MusicPage/music_operations.dart';
import '../MusicPage/happy_playlist_page.dart';
import '../MusicPage/sad_playlist_page.dart';

class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);
  Function(Music, {bool stop, bool isPlaying}) _miniPlayer;
  Home(this._miniPlayer);
  Widget createCategory(Category category) {
    return Container(
      height: 200,
      width: 100,
      color: const Color.fromARGB(255, 70, 70, 70),
      child: Row(
        children: [
          Image.network(
            category.imageURL,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              category.name,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> createListOfCategories() {
    List<Category> categoryList = CategoryOperations.getCategories();
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
  }

  Widget createMusic(Music music) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 175,
            width: 175,
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
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            music.name,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Text(
            music.desc,
            style: TextStyle(color: Colors.white, fontSize: 12),
          )
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
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 235,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
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

  Widget createGrid() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      child: GridView.count(
        childAspectRatio: 5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: createListOfCategories(),
        crossAxisCount: 2,
      ),
    );
  }

  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        message,
        style: TextStyle(
            color: const Color.fromARGB(255, 44, 44, 124),
            fontSize: 25,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 806,
        child: Column(children: [
          createAppBar('Emotify'),
          SizedBox(
            height: 10,
          ),
          createMusicList('Music For You'),
          HorizontalScrollableWidget(
            title: 'Playlists',
            texts: ['Happy', 'Sad', 'Angry', 'Calm'],
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HappyPlaylistPage(_miniPlayer),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SadPlaylistPage(_miniPlayer),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AngryPlaylistPage(_miniPlayer),
                    ),
                  );
                  break;
                case 3:
                  Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalmPlaylistPage(_miniPlayer),
                    ),
                  );
                  break;
              }
            },
          ),
        ]),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
      ),
    );
  }
}
