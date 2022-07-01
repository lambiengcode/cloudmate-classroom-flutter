import 'dart:async';
import 'package:just_audio/just_audio.dart';

class AudioHelper {
  static AudioPlayer player = AudioPlayer();

  static StreamController<Duration> bufferedController = StreamController<Duration>.broadcast();

  Future<void> soundAndRing(String url) async {
    player = AudioPlayer();

    try {
      if (player.playing) {
        player.stop();
      }
      await player.setUrl(url);
      player.setVolume(1);
      player.play();

      player.bufferedPositionStream.listen((event) {
        print('BUFFERED: $event');
        bufferedController.add(event);
      });

      player.durationStream.listen((event) {
        print('DURATION: $event');
      });

      player.positionStream.listen((event) {
        print('POSITION: $event');
      });

      player.setLoopMode(LoopMode.off);
    } catch (error) {
      print('audio error: ${error.toString()}');
    }
  }

  // Stream<PositionData> get positionDataStream =>
  //     Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
  //         player.positionStream,
  //         player.bufferedPositionStream,
  //         player.durationStream,
  //         (position, bufferedPosition, duration) =>
  //             PositionData(position, bufferedPosition, duration ?? Duration.zero));
}

class PositionData {
  Duration position;
  Duration duration;
  Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition, this.duration);

  @override
  String toString() {
    return 'PositionData{position: ${position.toString()}, duration: ${duration.toString()}, bufferedPosition: ${bufferedPosition}}';
  }
}
