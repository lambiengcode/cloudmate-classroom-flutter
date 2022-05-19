import 'package:cloudmate/src/models/transaction_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class TransactionRepository {
  Future<List<TransactionModel>> getTransactions() async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.TRANSACTION,
    );
    if (response.statusCode == 200) {
      List rawData = response.data['data'];
      return rawData.map((e) => TransactionModel.fromMap(e)).toList();
    }
    return [];
  }
}
