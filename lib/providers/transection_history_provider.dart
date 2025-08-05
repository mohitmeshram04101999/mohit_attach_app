import 'dart:convert';
import 'dart:math';

import 'package:attach/api/transection_api.dart';
import 'package:attach/modles/all_transection_model.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:attach/providers/profileProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TransectionHistoryProvider with ChangeNotifier {
  List<TransectionInfo> _transectionInfo = [];
  bool _loding = true;
  bool _lodingMore = false;
  int _page = 1;
  int _totalPage = 0;

  List<TransectionInfo> get allTransection => _transectionInfo;
  bool get loading => _loding;
  bool get loadingMore => _lodingMore;

  final TextEditingController _amountController = TextEditingController();
  TextEditingController get amountController => _amountController;

  clear() {
    _transectionInfo = [];
    _loding = true;
    _lodingMore = false;
    _page = 1;
  }

  getAllTransection(BuildContext context) async {
    var resp = await TransectionApi().getAllTransection(_page);

    switch (resp.statusCode) {
      case 200:
        var d = jsonDecode(resp.body);

        AllTransectionResponceModel data = AllTransectionResponceModel.fromJson(
          d,
        );
        _totalPage = data.page ?? 0;
        if (_page == 1) {
          _transectionInfo = data.data ?? [];
        } else {
          _transectionInfo.addAll(data.data ?? []);
        }

        notifyListeners();

        break;

      case 400:
        MyHelper.snakeBar(
          context,
          title: 'Verify Otp',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 403:
        MyHelper.snakeBar(
          context,
          title: 'Verify Otp',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 409:
        MyHelper.snakeBar(
          context,
          title: 'Bank Can not Add  ',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(
          context,
          '${resp.statusCode}\n${resp.body}',
          title: 'Exception',
        );
        break;
    }

    _loding = false;
    _lodingMore = false;
    notifyListeners();
  }

  loadMore(BuildContext context) async {
    print("yer");
    if (_page < _totalPage) {
      _page++;
      _lodingMore = true;
      notifyListeners();
      await getAllTransection(context);
    }
  }

  refresh(BuildContext context) async {
    _page = 1;
    await getAllTransection(context);
  }

  withdrawMoney(BuildContext context, int amount, String bankId) async {
    var resp = await TransectionApi().createTransection(
      amount: amount,
      type: "DEBIT",
      bankId: bankId,
    );

    switch (resp.statusCode) {
      case 201:
        var d = jsonDecode(resp.body);
        // _transectionInfo.add(TransectionInfo.fromJson(d['data']));
        refresh(context);
        await Provider.of<ProfileProvider>(
          context,
          listen: false,
        ).getUser(context);
        Navigator.pop(context);
        notifyListeners();
        break;

      case 400:
        MyHelper.snakeBar(
          context,
          title: 'Can Not Create Transection',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 403:
        MyHelper.snakeBar(
          context,
          title: 'Ristrict Server',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 409:
        MyHelper.snakeBar(
          context,
          title: 'Bank Can not Add  ',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(
          context,
          '${resp.statusCode}\n${resp.body}',
          title: 'Exception',
        );
        break;
    }
  }

  addMoneyInWallet(
    BuildContext context,
    int amount, {
    void Function()? onDone,
  }) async {
    if (amount < 100) {
     MyHelper.snakeBar(
        context,
        title: "Can't Add Money",
        message: "Add At Least 100 Rs.",
      );

     return;
    }

    var resp = await TransectionApi().createTransection(
      amount: amount,
      type: "CREDIT",
    );

    switch (resp.statusCode) {
      case 201:
        var d = jsonDecode(resp.body);
        await refresh(context);
        await Provider.of<ProfileProvider>(
          context,
          listen: false,
        ).getUser(context);
        notifyListeners();
        if (onDone != null) {
          onDone();
        }

        break;

      case 400:
        MyHelper.snakeBar(
          context,
          title: 'Can Not Create Transection',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 403:
        MyHelper.snakeBar(
          context,
          title: 'Ristrict Server',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 409:
        MyHelper.snakeBar(
          context,
          title: 'Bank Can not Add  ',
          message: '${jsonDecode(resp.body)['message']}',
          type: SnakeBarType.error,
        );
        break;

      case 401:
        MyHelper.tokenExp(context);
        break;

      case 500:
        MyHelper.serverError(context, resp.body);
        break;

      default:
        MyHelper.serverError(
          context,
          '${resp.statusCode}\n${resp.body}',
          title: 'Exception',
        );
        break;
    }
  }



  // --------------------------------------Razorpay------------------------------------ //


  rozarPay() async {

    var _razorpay = Razorpay();

    var options = {
      'key': 'rzp_test_3nq9sYvO8QK7wM',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'VXKq4@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment failed'+response.code.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print('External wallet: ' + response.walletName.toString());
  }


}
