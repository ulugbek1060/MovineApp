import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_data/movies_data.dart' show AuthRepository;

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterSate> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterSate()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterEvent event,
    Emitter<RegisterSate> state,
  ) async {
    authRepository.login();
  }
}
