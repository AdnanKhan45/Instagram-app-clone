part of 'get_single_other_user_cubit.dart';

abstract class GetSingleOtherUserState extends Equatable {
  const GetSingleOtherUserState();
}

class GetSingleOtherUserInitial extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserLoading extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}

class GetSingleOtherUserLoaded extends GetSingleOtherUserState {
  final UserEntity otherUser;

  GetSingleOtherUserLoaded({required this.otherUser});
  @override
  List<Object> get props => [otherUser];
}

class GetSingleOtherUserFailure extends GetSingleOtherUserState {
  @override
  List<Object> get props => [];
}
