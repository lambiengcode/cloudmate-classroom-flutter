import 'package:lottie/lottie.dart';

class Constants {
  static const INCH_TO_DP = 160;

  // Assets
  LottieBuilder splashLottie = Lottie.asset('assets/lottie/splash.json');
  LottieBuilder loadingLottie = Lottie.asset('assets/lottie/cat_sleeping.json');
  static const urlImageDefault = 'https://i.postimg.cc/Dfsg6VYJ/Hi-School.png';
  static const className = 'Tên lớp học';
  static const classTopic = 'Chủ đề';
  static const classIntro = 'Giới thiệu về lớp học';
  static const price = 'Giá lớp học';
  static final List<Map<String, String>> defaultClassImageUrls = [
    {
      'image':
          'https://i.pinimg.com/originals/02/89/09/02890993e3735184e80ecdf9db079e05.png',
      'blurHash':
          r'rGQ8#*9Z~D%2aL$+t6NHNG%NtQaKRkM_axo#oejF^Sr@I.S1S#S2o0n$WBROWWSyoexbj]nij]W;%Mg2NZV[i_nhWrt7t6xajFjbbbbvbbWAWAkD',
    },
    {
      'image':
          'https://i.pinimg.com/564x/62/de/59/62de59126d9e5b2a72f7ab306ba08dd5.jpg',
      'blurHash':
          r'rGP;+eJC{Lv|:j-:xFNIAJ%hR*Z#xurqRPNHsqO?}v,pOAK6OFSes+r;xVL~S5tQV@K5t7ogbDwH|FR*Ki$$bcI;NIohof==slFMNdnPtRwcV@nh',
    },
    {
      'image':
          'https://i.pinimg.com/564x/44/e7/9a/44e79a4fc1ae11b021629dcdfc68503d.jpg',
      'blurHash':
          r'r9D[S9%J0}#SmmEdAqxH-nyFT0I.s9wJaLslt7t70c$f}HEyKdnUw#brr?eTr=$+Sht2xtJBRiNY-WJ7J~sqVyxoV?VvxZItbGoaoMXAoIw[NHN1',
    },
    {
      'image':
          'https://i.pinimg.com/564x/ba/ab/2b/baab2b85777e2754653d028ee0a30194.jpg',
      'blurHash':
          r'rUR1I?Io}Z-oadNbj[xuWr-pkWRPs9S}NFWVf,n*$NbFNuWBs:oze.r=jrnhoIozR+V]ozf*V?X7xGs:R+R*R*a}oyWUn+a{oIW;R,sVoMn%s.WB',
    },
  ];

  static getOnlyDefaultClassImage() {
    defaultClassImageUrls.shuffle();
    return defaultClassImageUrls.first;
  }

  static const filesSupported = [
    'docx',
    'doc',
    'pdf',
    'pptx',
  ];
}
