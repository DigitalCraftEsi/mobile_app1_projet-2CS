import 'package:bloc/bloc.dart';
enum SugarQuantityEvents{
  onAddSugarEvent,
  onDecreaseSugar
}
class SugarQuantityBloc extends Bloc<SugarQuantityEvents,int>{
  @override
  // TODO: implement initialState
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(SugarQuantityEvents event) async*{
    // TODO: implement mapEventToState
   switch(event){
     case SugarQuantityEvents.onAddSugarEvent:
       yield state+1;
       break;
     case SugarQuantityEvents.onDecreaseSugar:
       yield state-1;
       break;
   }
  }
  
}