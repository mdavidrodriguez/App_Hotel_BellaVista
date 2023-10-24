import 'package:flutter_bloc/flutter_bloc.dart';

class HabitacionShelState {
  List<String> habIds;
  HabitacionShelState(this.habIds);
}

abstract class HabitacionShelEvent {
  const HabitacionShelEvent();
}

class AddHabiToHabshelf extends HabitacionShelEvent {
  final String habId;
  const AddHabiToHabshelf(this.habId);
}

class RemoveHabFromHabshelf extends HabitacionShelEvent {
  final String habId;
  const RemoveHabFromHabshelf(this.habId);
}

class HabshelfBloc extends Bloc<HabitacionShelEvent, HabitacionShelState> {
  HabshelfBloc(HabitacionShelState initialState) : super(initialState) {
    on<AddHabiToHabshelf>((event, emit) {
      state.habIds.add(event.habId);
      emit(HabitacionShelState(state.habIds));
    });

    on<RemoveHabFromHabshelf>((event, emit) {
      state.habIds.remove(event.habId);
      emit(HabitacionShelState(state.habIds));
    });
  }
}
