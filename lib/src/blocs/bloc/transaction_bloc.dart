import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/transaction_model.dart';
import 'package:cloudmate/src/resources/remote/transaction_repository.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial());

  List<TransactionModel> transactions = [];

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is GetTransactionEvent) {
      transactions.clear();
      yield TransactionInitial();
      await _getTransactions();
      yield GetDoneTransaction(transactions: transactions);
    }
  }

  // MARK: Private methods
  Future<void> _getTransactions() async {
    List<TransactionModel> _transactions = await TransactionRepository().getTransactions();

    transactions.addAll(_transactions);
  }
}
