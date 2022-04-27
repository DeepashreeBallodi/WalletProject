import 'package:Wallet/DataModels/WalletModel.dart';
import 'package:Wallet/Network/Service.dart';
import 'package:Wallet/Utils/HelperUtil.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mywalletbloc_event.dart';
part 'mywalletbloc_state.dart';

class MywalletblocBloc extends Bloc<MywalletblocEvent, MywalletblocState> {
  MywalletblocBloc() : super(MywalletblocLoading());

  @override
  Stream<MywalletblocState> mapEventToState(
    MywalletblocEvent event,
  ) async* {
    if (event is MywalletblocEvent) {
      yield* _mapGetTransMainScreenEventDatatoState(event);
    }
  }

  Stream<MywalletblocState> _mapGetTransMainScreenEventDatatoState(
      MywalletblocEvent event) async* {
    Service api = Service();
    bool internet = true;
    WalletData walletResponse;

    getHomeScreenData() async {
      internet = await HelperUtil.checkInternetConnection();
      if (internet) {
        walletResponse = api.getWalletData();
      } else {
        internet = false;
      }
    }

    await getHomeScreenData();
    yield MyWalletScreenLoaded(walletResponse: walletResponse,isInternetConnected: internet);
  }
}
