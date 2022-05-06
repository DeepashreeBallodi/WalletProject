import 'package:Wallet/DataModels/TransactionHistory.dart';
import 'package:Wallet/Network/Service.dart';
import 'package:Wallet/Utils/helper_util.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mytransactionbloc_event.dart';
part 'mytransactionbloc_state.dart';

class MytransactionblocBloc
    extends Bloc<MytransactionblocEvent, MytransactionblocState> {
  MytransactionblocBloc() : super(MytransactionblocLoading());

  @override
  Stream<MytransactionblocState> mapEventToState(
    MytransactionblocEvent event,
  ) async* {
    if (event is GetTransactionMainScreenEvent) {
      yield* _mapGetTransMainScreenEventDatatoState(event);
    }
  }

  Stream<MytransactionblocState> _mapGetTransMainScreenEventDatatoState(
      GetTransactionMainScreenEvent event) async* {
    Service api = Service();
    bool internet = true;
    TransactionHistory transactionResp;

    getHomeScreenData() async {
      internet = await HelperUtil.checkInternetConnection();
      if (internet) {
        transactionResp = api.getTransactionData();
      } else {
        internet = false;
      }
    }

    await getHomeScreenData();
    yield MytransactionScreenLoaded(transactionResp: transactionResp,isInternetConnected: internet);
  }
}
