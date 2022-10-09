import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:momo_vn/momo_vn.dart';

class MomoAppPayment {
  MomoVn? _momoPay;

  handlePaymentMomo(
      {required int amount,
      required Function(PaymentResponse) handleFinished}) {
    MomoPaymentInfo options = MomoPaymentInfo(
      merchantName: "Cloudmate",
      appScheme: "momoiwtv20220329",
      merchantCode: 'MOMOIWTV20220329',
      partnerCode: 'MOMOIWTV20220329',
      amount: amount,
      orderId: DateTime.now().microsecondsSinceEpoch.toString(),
      orderLabel: 'THANH TOÁN KHOÁ HỌC CLOUDMATE',
      merchantNameLabel: "THANH TOÁN KHOÁ HỌC CLOUDMATE",
      fee: 0,
      description: 'Thanh toán khoá học trên Cloudmate',
      partner: 'merchant',
      isTestMode: true,
      extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
    );
    try {
      _momoPay = MomoVn();
      _momoPay?.on(
        MomoVn.EVENT_PAYMENT_SUCCESS,
        (res) => _handlePaymentSuccess(
          response: res,
          handleFinished: handleFinished,
        ),
      );
      _momoPay?.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _momoPay?.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void _handlePaymentSuccess(
      {required PaymentResponse response,
      required Function(PaymentResponse) handleFinished}) {
    handleFinished(response);
    _momoPay?.clear();
  }

  void _handlePaymentError(PaymentResponse response) {
    AppNavigator.pop();
    _momoPay?.clear();
  }
}
