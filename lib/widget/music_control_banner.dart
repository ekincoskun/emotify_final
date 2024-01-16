import 'package:flutter/material.dart';
import '../Client/Presentation/UIManager/MusicPage/music.dart';

class MusicControlBanner extends StatefulWidget {
  final bool isPlaying;
  final bool isReversed;
  final VoidCallback onPressed;
  final VoidCallback onTap;

  final Music? music;

  const MusicControlBanner({
    required this.isPlaying,
    required this.isReversed,
    required this.onPressed,
    required this.onTap,
    this.music,
  });

  @override
  _MusicControlBannerState createState() => _MusicControlBannerState();
}

class _MusicControlBannerState extends State<MusicControlBanner> {
  bool isPaused = false;
  bool isPlaying = false;
  bool isReversed = false;
  @override
  void initState() {
    super.initState();
    isPlaying = widget.isPlaying;
    isReversed = widget.isReversed;
  }

  @override
  void didUpdateWidget(MusicControlBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      setState(() {
        isPlaying = widget.isPlaying;
        isReversed = widget.isReversed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isReversed = !isReversed;
              });
              widget.onTap();
            },
            icon: Icon(
              Icons.change_circle_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isPaused = !isPaused;
                isPlaying = !isPlaying;
              });
              widget.onPressed();
            },
            child: Container(
              height: 35,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 8),
                  Icon(
                    isPaused ? Icons.play_arrow : Icons.pause,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: 8),
                  Text(
                    isPaused ? 'Play' : 'Pause',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  if (widget.music != null)
                    Expanded(
                      child: Text(
                        widget.music!.name, // Şarkı adı
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
