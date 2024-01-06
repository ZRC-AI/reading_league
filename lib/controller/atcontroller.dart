import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class ATControl {
  int index;
  AudioPlayer audioPlayer;
  String path;
  Duration position;
  ATControl(this.index, this.audioPlayer, this.position, this.path);
}

class ATController extends GetxController {
  List<ATControl?> atlists = [];
  void genatcontrol(AudioPlayer audioPlayer, Duration position, String path) {
    int index = atlists.length + 1;
    ATControl atcontrol = ATControl(index, audioPlayer, position, path);
    atlists.add(atcontrol);
  }

  void addacp(ATControl audioPlayer) {}

  void seek(ATControl atControl) {
    atControl.audioPlayer.seek(atControl.position);
  }
}
