part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class GetDoneTransaction extends TransactionState {
  final List<TransactionModel> transactions;
  GetDoneTransaction({required this.transactions});
}
