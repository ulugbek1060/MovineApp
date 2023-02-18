import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_data/movies_data.dart';

part 'config_event.dart';

part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigRepository configRepository;

  ConfigBloc(this.configRepository) : super(ConfigInitial()) {
    on<ConfigEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
