part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  const UserProfileState({
    this.user = User.empty,
    this.isLoading = false,
    this.hasError = false,
  });

  final User user;
  final bool isLoading;
  final bool hasError;

  @override
  List<Object> get props => [user, isLoading, hasError];

  UserProfileState copyWith({
    User? user,
    bool? isLoading,
    bool? hasError,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
