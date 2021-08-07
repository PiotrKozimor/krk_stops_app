import 'package:bloc/bloc.dart';

enum Filter {
  ALL,
  TRAM,
  BUS,
}

class DeparturesFilterCubit extends Cubit<Filter> {
  DeparturesFilterCubit() : super(Filter.ALL);

  void toggle() {
    switch (state) {
      case Filter.ALL:
        emit(Filter.TRAM);
        break;
      case Filter.TRAM:
        emit(Filter.BUS);
        break;
      case Filter.BUS:
        emit(Filter.ALL);
    }
  }
}
