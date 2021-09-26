import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/repositories/user_repository/user_repository.dart';

part 'user_profile_state.dart';
part 'user_profile_event.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({
    required UserRepository userRepository
  }) : _userRepository = userRepository,
       super(const UserProfileState());

  final UserRepository _userRepository;

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is GetUserProfile) {
      yield* _getUserProfile(event, state);
    }
  }

  Stream<UserProfileState> _getUserProfile(GetUserProfile event, UserProfileState state) async* {
    yield state.copyWith(isLoading: true);

    try {
      final user = await _userRepository.getUser(forceUpdate: true);

      yield state.copyWith(
        user: user,
        isLoading: false,
        hasError: false,
      );
    } catch (err) {
      yield state.copyWith(
        hasError: true,
        isLoading: false,
      );
    }
  }
}
