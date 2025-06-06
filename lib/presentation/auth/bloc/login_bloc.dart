import 'package:bloc/bloc.dart';
import 'package:canary_app/data/model/request/auth/login_request_model.dart';
import 'package:canary_app/data/model/response/auth_response_model.dart';
import 'package:canary_app/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;


  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState>emit,
  )async{
    emit(LoginLoading());

    final result = await authRepository.login(event.requestModel);

    result.fold(
      (l) => emit(LoginFailure(error: l.message)),
      (r) => emit(LoginSuccess(responseModel: r))
      
    );
  }
}
