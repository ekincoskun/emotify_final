import '../MusicPage/music.dart';

class CalmPlaylist {
  CalmPlaylist._() {}
  static List<Music> getCalmMusic() {
    return <Music>[
      Music(
          'Gnossienne No. 1',
          'https://is4-ssl.mzstatic.com/image/thumb/Music126/v4/d3/b4/5a/d3b45a27-957b-6535-08a7-1847be3f712c/Calm_Cello_Music_Classical_Cello_and_Piano_Music_for_Studying_Sleeping_Relaxing.jpg/100x100bb.jpg',
          'Cello Music DEA Channel',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/7a/85/3b/7a853b13-5e00-e78c-ac9a-a5de8c810cb3/mzaf_5262048790741410692.plus.aac.p.m4a'),
      Music(
          'Moonlight Sonata',
          'https://is1-ssl.mzstatic.com/image/thumb/Music/cd/11/3d/mzi.habpfpwc.tif/100x100bb.jpg',
          'London Philharmonic Orchestra',
          'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/52/a4/c4/52a4c4ab-c8ff-edc2-1d9e-6d6207e3df36/mzaf_10898931435537392814.plus.aac.p.m4a'),
    ];
  }
}
