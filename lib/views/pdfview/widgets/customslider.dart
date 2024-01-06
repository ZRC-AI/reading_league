import 'dart:async';
import 'dart:io';
import 'package:reading_league/controller/pdfview_controller/audio_paths_controller.dart';
import 'package:reading_league/controller/pdfview_controller/pdf_controller.dart';
import 'package:reading_league/controller/pdfview_controller/record_controller.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../../controller/pdfview_controller/audio_button_controller.dart';

class CustomSlider extends StatefulWidget {
  CustomSlider({super.key});
  @override
  _CustomSlider createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  late StreamSubscription<void> _playerStateChangedSubscription;
  late StreamSubscription<Duration?> _durationChangedSubscription;
  late StreamSubscription<Duration> _positionChangedSubscription;
  Duration? _position;
  Duration? _duration;
  final PdfController pdfcontroller = Get.put(PdfController());
  final RecordController rcontroller = Get.put(RecordController());
  final AudioButtonController abcontroller = Get.put(AudioButtonController());
  final AudioPathsController apscontroller = Get.put(AudioPathsController());
  final _audioPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);

  @override
  void initState() {
    _playerStateChangedSubscription =
        _audioPlayer.onPlayerComplete.listen((state) async {
      await stop();
      setState(() {});
    });

    _positionChangedSubscription = _audioPlayer.onPositionChanged.listen(
      (position) => setState(() {
        _position = position;
        abcontroller.position = position;
      }),
    );

    _durationChangedSubscription = _audioPlayer.onDurationChanged.listen(
      (duration) => setState(() {
        _duration = duration;
      }),
    );
    abcontroller.audioplayer = _audioPlayer;
    super.initState();
  }

  Future<void> play() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dirname = dir.path;
    String audios = 'audios';
    String path = p.join(
        dirname, pdfcontroller.seminar, audios, apscontroller.isplayingaudio);

    try {
      _audioPlayer.play(
        DeviceFileSource(path),
      );
    } catch (e) {
      Logger().d(e);
    }
  }

  Future<void> pause() => _audioPlayer.pause();

  Future<void> stop() => _audioPlayer.stop();

  void seek(int position) {
    _audioPlayer.seek(Duration(milliseconds: position));
  }

  @override
  Widget build(BuildContext context) {
    bool canSetValue = false;
    final duration = _duration;
    final position = _position;
    if (duration != null && position != null) {
      canSetValue = position.inMilliseconds > 0;
      canSetValue &= position.inMilliseconds < duration.inMilliseconds;
    }
    return Card(
      margin: EdgeInsets.only(bottom: 0),
      elevation: 4,
      color: const Color.fromARGB(240, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // 定义圆角半径
      ),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 30,
                width: 270,
                child: Stack(children: [
                  Center(
                      child: SizedBox(
                          height: 30,
                          width: 230,
                          child: SliderTheme(
                            data: SliderThemeData(
                                trackHeight: 5,
                                // rangeTrackShape: ,
                                thumbShape: CustomSliderThumbShape()),
                            child: Slider(
                              activeColor: Colors.black,
                              inactiveColor:
                                  const Color.fromARGB(255, 218, 215, 215),
                              min: 0.0,
                              max: 1.0,
                              onChanged: (v) {
                                if (duration != null) {
                                  final position = v * duration.inMilliseconds;
                                  seek(position.round());
                                }
                              },
                              value: canSetValue &&
                                      duration != null &&
                                      position != null
                                  ? position.inMilliseconds /
                                      duration.inMilliseconds
                                  : 0.0,
                            ),
                          ))),
                  position != null && duration != null
                      ? Align(
                          alignment: Alignment.bottomLeft,
                          child: Card(
                            margin: EdgeInsets.only(left: 40),
                            elevation: 0,
                            color: Colors.transparent,
                            child: Text(
                              "${(position.inSeconds / 60).truncate()}:${(position.inSeconds % 60)}",
                              style:
                                  TextStyle(fontSize: 9, color: Colors.black),
                            ),
                          ))
                      : Align(
                          alignment: Alignment.bottomLeft,
                          child: Card(
                              margin: EdgeInsets.only(left: 40),
                              elevation: 0,
                              color: Colors.transparent,
                              child: Text(
                                "0:00",
                                style:
                                    TextStyle(fontSize: 9, color: Colors.black),
                              )),
                        ),
                  position != null && duration != null
                      ? Align(
                          child: Card(
                              margin: EdgeInsets.only(right: 40),
                              elevation: 0,
                              color: Colors.transparent,
                              child: Text(
                                "${(duration.inSeconds / 60).truncate()}:${(duration.inSeconds % 60)}",
                                style:
                                    TextStyle(fontSize: 9, color: Colors.black),
                              )),
                          alignment: Alignment.bottomRight,
                        )
                      : Align(
                          child: Card(
                            margin: EdgeInsets.only(right: 40),
                            elevation: 0,
                            color: Colors.transparent,
                            child: Text(
                              "0:00",
                              style:
                                  TextStyle(fontSize: 9, color: Colors.black),
                            ),
                          ),
                          alignment: Alignment.bottomRight,
                        ),
                  Obx(
                    () => abcontroller.audioplaypausing.value
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                splashRadius: 16,
                                iconSize: 16,
                                onPressed: () {
                                  play();
                                  abcontroller.audioplaypausing.value = false;
                                },
                                icon: Icon(Icons.play_arrow)))
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                splashRadius: 16,
                                iconSize: 16,
                                onPressed: () {
                                  pause();
                                  abcontroller.audioplaypausing.value = true;
                                },
                                icon: Icon(Icons.pause))),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        splashRadius: 16,
                        iconSize: 16,
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          stop();
                          pdfcontroller.canplaying.value = false;
                        },
                      ))
                ])),
          ]),
    );
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  const CustomSliderThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // 返回自定义滑块按钮的首选大小
    return Size(5, 5);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    // 在这里绘制自定义滑块按钮
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 6.0, paint);
  }
}
