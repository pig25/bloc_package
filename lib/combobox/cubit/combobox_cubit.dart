import 'package:bloc/bloc.dart';
import '../model/combobox.dart';


class ComBoBoxCubit<T> extends Cubit<List<ComBoBoxItemEntry<T>> > {
  ComBoBoxCubit(this.item) : super([]){
    filter('');
  }
  final List<ComBoBoxItemEntry<T>> item;

  filter(String filter) {
    if(filter.isEmpty){
      emit(item);
    }
    else{
      emit(item.where((x) => x.label.contains(filter)).toList());
    }
  }

}
