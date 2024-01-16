import '../MusicPage/music.dart';

class HappyPlaylist {
  HappyPlaylist._() {}
  static List<Music> getHappyMusic() {
    return <Music>[
      Music(
          'Tourner dans le vide',
          'https://is5-ssl.mzstatic.com/image/thumb/Music116/v4/49/58/30/49583018-308b-431d-c691-4a28e78be8cd/14UMGIM01109.rgb.jpg/100x100bb.jpg',
          'Indila',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview126/v4/94/44/b9/9444b9da-7333-8d23-3837-b9281aa2db4a/mzaf_9622341659403154943.plus.aac.p.m4a'),
      Music(
          'Jay Jay',
          'https://is5-ssl.mzstatic.com/image/thumb/Music124/v4/0b/39/21/0b3921d8-ff44-7f20-edef-7b6c81702ee1/4018939359201_3000.jpg/100x100bb.jpg',
          'Mero',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/39/34/dd/3934ddf8-6708-4e97-a630-d7dc15b8f274/mzaf_9037674278030039690.plus.aac.p.m4a'),
      Music(
          'Happy',
          'https://is4-ssl.mzstatic.com/image/thumb/Music115/v4/f4/43/16/f4431607-15c4-883c-3fbe-dd6abbbe03e7/886444516877.jpg/100x100bb.jpg',
          'Pharrell Williams',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/26/c1/cf/26c1cff9-23e4-ca53-b6b1-b27942bcdb39/mzaf_13186632879241485603.plus.aac.p.m4a'),
    ];
  }
}
