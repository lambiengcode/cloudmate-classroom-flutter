import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Constants {
  LottieBuilder splashLottie = Lottie.asset('assets/lottie/splash.json');
  LottieBuilder loadingLottie = Lottie.asset('assets/lottie/cat_sleeping.json');
  static const defaultClassImage = NetworkImage(
    'https://i.pinimg.com/originals/02/89/09/02890993e3735184e80ecdf9db079e05.png',
  );
  static const defaultClassImageString =
      'https://i.pinimg.com/originals/02/89/09/02890993e3735184e80ecdf9db079e05.png';
  static const className = 'Tên lớp học';
  static const classTopic = 'Chủ đề';
  static const classIntro = 'Giới thiệu về lớp học';
}
