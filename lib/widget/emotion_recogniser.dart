import 'dart:io';
import 'package:Emotify/Client/Presentation/UIManager/MusicPage/music.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../classifier/classifier.dart';
import 'image_view.dart';
import 'root.dart';
import 'package:Emotify/widget/music_control_banner.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

class EmotionRecogniser extends StatefulWidget {
  const EmotionRecogniser({super.key});

  @override
  State<EmotionRecogniser> createState() => _EmotionRecogniserState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _EmotionRecogniserState extends State<EmotionRecogniser> {
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;
  bool isPlaying = false;
  bool isReversed = false;
  bool _shouldPlayMusic = false;
  String _musicUrl = '';

  int currentTabIndex = 0;
  AudioPlayer _audioPlayer = new AudioPlayer();
  Music? music;
  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _EmotionLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  late Classifier _classifier;

  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: _buildTitle(),
          ),
          const SizedBox(height: 20),
          _buildPhotolView(),
          const SizedBox(height: 10),
          isReversed ? _buildReverseResultView() : _buildResultView(),
          const Spacer(flex: 5),
          _buildPickPhotoButton(
            title: 'Take a photo',
            source: ImageSource.camera,
          ),
          _buildPickPhotoButton(
            title: 'Pick from gallery',
            source: ImageSource.gallery,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildPhotolView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 400,
            width: 350,
            child: ImageView(file: _selectedImageFile)),
        _buildAnalyzingText(),
      ],
    );
  }

  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('Analyzing...');
  }

  Widget _buildTitle() {
    return const Text('Emotion Recogniser',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ));
  }

  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,
  }) {
    return TextButton(
      onPressed: () => _onPickPhoto(source),
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 44, 44, 124),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ))),
      ),
    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.501
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final EmotionLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _EmotionLabel = EmotionLabel;
      _accuracy = accuracy;
    });
  }

  Widget _buildReverseResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _EmotionLabel;
      if (_EmotionLabel == 'Happy') {
        _shouldPlayMusic = true;
        _musicUrl =
            'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/e2/c9/02/e2c90225-e3e5-5fe6-d679-cb87f3920df8/mzaf_7290642055578962905.plus.aac.p.m4a';
      } else if (_EmotionLabel == 'Angry') {
        _shouldPlayMusic = true;
        _musicUrl =
            'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/7a/85/3b/7a853b13-5e00-e78c-ac9a-a5de8c810cb3/mzaf_5262048790741410692.plus.aac.p.m4a';
      } else if (_EmotionLabel == 'Sad') {
        _shouldPlayMusic = true;
        _musicUrl =
            'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/26/c1/cf/26c1cff9-23e4-ca53-b6b1-b27942bcdb39/mzaf_13186632879241485603.plus.aac.p.m4a';
      } else {
        _shouldPlayMusic = false;
        _musicUrl = '';
      }
    } else {
      title = '';
    }

    //
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    if (_shouldPlayMusic && !isPlaying) {
      _audioPlayer.play(_musicUrl);
    }

    return Column(
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )),
        const SizedBox(height: 10),
        Text(
          accuracyLabel,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        if (_shouldPlayMusic)
          MusicControlBanner(
            isPlaying: isPlaying,
            isReversed: isReversed,
            onTap: () {
              setState(() {
                isReversed = !isReversed;
              });
            },
            onPressed: () {
              setState(() {
                isPlaying = !isPlaying;
                if (isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.resume();
                }
              });
            },
          ),
      ],
    );
  }

  Widget _buildResultView() {
    var title = '';

    if (_resultStatus == _ResultStatus.notFound) {
      title = 'Fail to recognise';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _EmotionLabel;
      if (_EmotionLabel == 'Happy') {
        _shouldPlayMusic = true;
        _musicUrl =
            'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/26/c1/cf/26c1cff9-23e4-ca53-b6b1-b27942bcdb39/mzaf_13186632879241485603.plus.aac.p.m4a';
      } else if (_EmotionLabel == 'Sad') {
        _shouldPlayMusic = true;
        _musicUrl =
            'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/e2/c9/02/e2c90225-e3e5-5fe6-d679-cb87f3920df8/mzaf_7290642055578962905.plus.aac.p.m4a';
      } else if (_EmotionLabel == 'Angry') {
        _shouldPlayMusic = true;
        _musicUrl =
            'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/35/4a/52/354a5273-cd18-4b66-de38-12b3d1d76e77/mzaf_17830225624410243321.plus.aac.p.m4a';
      } else {
        _shouldPlayMusic = false;
        _musicUrl = '';
      }
    } else {
      title = '';
    }

    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel = 'Accuracy: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    if (_shouldPlayMusic && !isPlaying) {
      _audioPlayer.play(_musicUrl);
    }

    return Column(
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )),
        const SizedBox(height: 10),
        Text(
          accuracyLabel,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        if (_shouldPlayMusic)
          MusicControlBanner(
            isPlaying: isPlaying,
            isReversed: false,
            onTap: () {
              setState(() {
                isReversed = !isReversed;
              });
            },
            onPressed: () {
              setState(() {
                isPlaying = !isPlaying;
                if (isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.resume();
                }
              });
            },
          ),
      ],
    );
  }
}
