part of 'mytransactionbloc_bloc.dart';

@immutable
abstract class MytransactionblocState {}

class MytransactionblocInitial extends MytransactionblocState {}

class MytransactionblocLoading extends MytransactionblocState {}

class MytransactionScreenLoaded extends MytransactionblocState {
  TransactionHistory transactionResp;
   bool isInternetConnected;
  MytransactionScreenLoaded({this.transactionResp,this.isInternetConnected});
}
