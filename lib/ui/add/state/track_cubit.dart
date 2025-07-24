import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'track_state.dart';

class TrackCubit extends Cubit<TrackState> {
  TrackCubit() : super(TrackInitial());
}
