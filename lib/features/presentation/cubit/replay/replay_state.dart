part of 'replay_cubit.dart';

abstract class ReplayState extends Equatable {
  const ReplayState();
}

class ReplayInitial extends ReplayState {
  @override
  List<Object> get props => [];
}

class ReplayLoading extends ReplayState {
  @override
  List<Object> get props => [];
}
class ReplayLoaded extends ReplayState {
  final List<ReplayEntity> replays;

  ReplayLoaded({required this.replays});

  @override
  List<Object> get props => [replays];
}
class ReplayFailure extends ReplayState {
  @override
  List<Object> get props => [];
}
