import '../MusicPage/music.dart';

class SadPlaylist {
  SadPlaylist._() {}
  static List<Music> getSadMusic() {
    return <Music>[
      Music(
        'Karakolluk',
        'https://is1-ssl.mzstatic.com/image/thumb/Music124/v4/2a/d4/e5/2ad4e574-c991-f916-fe9e-dbd8213c07b8/cover.jpg/100x100bb.jpg',
        'Azer Bülbül',
        'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/a7/61/bb/a761bb69-fc3e-4505-fd65-dfee54ac8c9c/mzaf_9583196359390988503.plus.aac.p.m4a',
      ),
      Music(
          'Deep End',
          'https://is5-ssl.mzstatic.com/image/thumb/Music115/v4/3e/9a/62/3e9a62a2-f831-c356-b693-8f738d3a526a/886448665434.jpg/100x100bb.jpg',
          'Fousheé',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/88/e3/f2/88e3f223-7796-7fb0-855a-77e3d38d106a/mzaf_15817348458148598255.plus.aac.p.m4a'),
      Music(
          'Her Şeyi Yak',
          'https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/ba/22/76/ba2276a9-e829-2a71-1ed8-43495f0d0a11/00602567788485.rgb.jpg/100x100bb.jpg',
          'Duman',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/88/e3/f2/88e3f223-7796-7fb0-855a-77e3d38d106a/mzaf_15817348458148598255.plus.aac.p.m4a'),
    ];
  }
}
