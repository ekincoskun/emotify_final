import '../MusicPage/music.dart';

class AngryPlaylist {
  AngryPlaylist._() {}
  static List<Music> getAngryMusic() {
    return <Music>[
      Music(
        'Psychosocial',
        'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/06/3c/77/063c7719-c241-442a-9032-b1e348026574/075679806314.jpg/100x100bb.jpg',
        'Slipknot',
        'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/35/4a/52/354a5273-cd18-4b66-de38-12b3d1d76e77/mzaf_17830225624410243321.plus.aac.p.m4a',
      ),
      Music(
        '200 Milyar',
        'https://is4-ssl.mzstatic.com/image/thumb/Music122/v4/25/6e/66/256e66a9-0a4b-b6a6-bc5c-317481a2eaa8/22UMGIM58484.rgb.jpg/100x100bb.jpg',
        'Lvbel C5',
        'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/ce/3e/60/ce3e60eb-32ea-3b0d-b44d-095407d966de/mzaf_261086033178093661.plus.aac.p.m4a',
      ),
    ];
  }
}
