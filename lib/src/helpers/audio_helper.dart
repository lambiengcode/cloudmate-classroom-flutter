import 'package:just_audio/just_audio.dart';

class AudioHelper {
  Future<void> soundAndRing(String url) async {
    final _player = AudioPlayer();
    try {
      if (_player.playing) {
        _player.stop();
      }
      await _player.setUrl(url);
      _player.setVolume(1);
      _player.play();
      _player.setLoopMode(LoopMode.off);
    } catch (error) {
      print('audio error: ${error.toString()}');
    }
  }
}
