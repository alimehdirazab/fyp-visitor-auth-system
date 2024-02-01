import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/data/models/user/user_model.dart';
import 'package:fyp/data/repositories/user_repository.dart';
import 'package:fyp/logic/cubits/user_cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    // _initialize();
  }

  final UserRepository _userRepository = UserRepository();

  // void _initialize() async {
  //   final userDetails = await Preferences.getAccessToken();
  //   String? email = userDetails;

  //   if (email == null ) {
  //     emit(UserLoggedOutState());
  //   } else {
  //     signIn(email: email, password: password);
  //   }
  // }

  // void _emitLoggedInState({
  //   required UserModel userModel,
  //   required String email,
  //   required String password,
  // }) async {
  //   await Preferences.saveUserDetails(email, password);
  //   emit(UserLoggedInState(userModel));
  //   log('Details Saved!');
  // }

  void signIn({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      await _userRepository.signIn(email: email, password: password);
      emit(UserLoggedInState());
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void createAccount({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      await _userRepository.createAccount(email: email, password: password);
      emit(UserLoggedInState());
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void signOut() async {
    //await Preferences.clear();
    emit(UserLoggedOutState());
  }
}
