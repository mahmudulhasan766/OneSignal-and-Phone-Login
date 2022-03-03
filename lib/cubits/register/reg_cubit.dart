import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reg_state.dart';

class RegCubit extends Cubit<RegState> {
  RegCubit() : super(RegInitial());
}
