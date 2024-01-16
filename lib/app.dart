import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'widget/emotion_recogniser.dart';
import 'Client/Presentation/UIManager/HomePage/home.dart';
import 'Client/Presentation/UIManager/LibraryPage/library_page.dart';
import 'Client/Presentation/UIManager/MusicPage/music.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {
  late List<Widget> Tabs = [];
  int currentTabIndex = 0;
  AudioPlayer _audioPlayer = new AudioPlayer();
  Music? music;
  bool isPlaying = false;

  Widget miniPlayer(Music? music, {bool stop = false, bool isPlaying = false}) {
    this.music = music;
    if (music == null) {
      return SizedBox();
    }
    if (isPlaying) {
      _audioPlayer.play(music.audioURL, isLocal: true);
    }
    if (stop) {
      isPlaying = false;
      _audioPlayer.stop();
    }
    setState(() {});
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Color.fromARGB(255, 70, 70, 70),
      height: 75,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(music.image, fit: BoxFit.cover),
          SizedBox(
            width: 20,
          ),
          Text(
            music.name,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            width: 50,
          ),
          IconButton(
              onPressed: () async {
                isPlaying = !isPlaying;

                if (isPlaying) {
                  await _audioPlayer.pause();
                } else {
                  await _audioPlayer.play(music.audioURL, isLocal: true);
                }

                setState(() {});
              },
              icon: Icon(
                isPlaying ? Icons.play_arrow : Icons.pause,
                color: Colors.white,
                size: 32,
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Tabs = [Home(miniPlayer), EmotionRecogniser(), LibraryPage(miniPlayer)];
  }

  // UI Design
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      home: Scaffold(
        body: Tabs[currentTabIndex],
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            miniPlayer(music),
            BottomNavigationBar(
                currentIndex: currentTabIndex,
                onTap: (currentIndex) {
                  print('Current Index is $currentIndex');
                  currentTabIndex = currentIndex;
                  setState(() {});
                },
                selectedLabelStyle: const TextStyle(color: Colors.white),
                selectedItemColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 44, 44, 44),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.camera,
                        color: Colors.white,
                      ),
                      label: 'Camera'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.library_books_outlined,
                        color: Colors.white,
                      ),
                      label: 'Library'),
                ]),
          ],
        ),
      ),
    );
  }
}
