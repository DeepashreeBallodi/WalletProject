part of 'mywalletbloc_bloc.dart';

@immutable
abstract class MywalletblocState {}

class MywalletblocInitial extends MywalletblocState {}

class MywalletblocLoading extends MywalletblocState {}

class MyWalletScreenLoaded extends MywalletblocState {
  WalletData walletResponse;
  bool isInternetConnected;
  MyWalletScreenLoaded({this.walletResponse,this.isInternetConnected});
}
