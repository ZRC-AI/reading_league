import 'dart:async';

import 'package:reading_league/controller/pdfview_controller/audio_paths_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'package:record/record.dart';
import 'package:path/path.dart' as p;
import '../database_controller/databasecontroller.dart';

class RecordController extends GetxController {
  Timer? _timer;
  late final AudioRecorder _audioRecorder;
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;
  RxList<String> audiopaths = ['示例音频'].obs;
  final DatabaseController dbcontroller = Get.put(DatabaseController());
  final AudioPathsController apscontroller = Get.put(AudioPathsController());
  var recordingseconds = 0.obs;

// 在 initState 中初始化 _recorder
  @override
  void onInit() {
    super.onInit();
    _init();
    // 在这里执行初始化操作
  }

  void _init() {
    _audioRecorder = AudioRecorder();

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      _updateRecordState(recordState);
    });
    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) {
      _amplitude = amp;
    });
  }

  void _updateRecordState(RecordState recordState) {
    _recordState = recordState;

    switch (recordState) {
      case RecordState.pause:
        _timer?.cancel();
        break;
      case RecordState.record:
        _startTimer();
        break;
      case RecordState.stop:
        _timer?.cancel();
        break;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordingseconds.value++;
    });
  }

  Future<String> start(String name) async {
    try {
      if (await _audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.aacLc;

        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          encoder,
        );

        debugPrint('${encoder.name} supported: $isSupported');

        final devs = await _audioRecorder.listInputDevices();
        debugPrint(devs.toString());

        const config = RecordConfig(encoder: encoder, numChannels: 1);

        // Record to file

        final dir = await getApplicationDocumentsDirectory();
        String path = p.join(
          dir.path,
          name,
          'audios',
          'audio_${DateTime.now().millisecondsSinceEpoch}.wav',
        );

        await _audioRecorder.start(config, path: path);

        // Record to stream
        // final file = File(path);
        // final stream = await _audioRecorder.startStream(config);
        // stream.listen(
        //   (data) {
        //     // ignore: avoid_print
        //     print(
        //       _audioRecorder.convertBytesToInt16(Uint8List.fromList(data)),
        //     );
        //     file.writeAsBytesSync(data, mode: FileMode.append);
        //   },
        //   // ignore: avoid_print
        //   onDone: () => print('End of stream'),
        // );

        // Record to stream web
        // var b = <Uint8List>[];
        // final stream = await _audioRecorder.startStream(config);
        // stream.listen(
        //   (data) {
        //     b.add(data);
        //   },
        //   onDone: () {
        //     _downloadWebData(html.Url.createObjectUrl(html.Blob(b)));
        //   },
        // );

        _startTimer();

        return p.basename(path);
      } else {
        Logger().d('录音权限获取失败');
        return '';
      }
    } catch (e) {
      if (kDebugMode) {
        Logger().d('录制开始失败：${e}');
        return '';
      } else {
        return '';
      }
    }
  }

  Future<void> stop(String seminar) async {
    final String? newpath = await _audioRecorder.stop();
    recordingseconds.value = 0;
    if (newpath != null) {
      String audioname = p.basename(newpath);
      dbcontroller.insertaudio(seminar, audioname);
      apscontroller.selectaudio();
    }
  }

  Future<void> pause() async {
    await _audioRecorder.pause();
  }

  Future<void> resume() async {
    await _audioRecorder.resume();
  }
}
