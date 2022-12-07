import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone_app/features/domain/entities/replay/replay_entity.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/replay/create_replay_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/replay/delete_replay_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/replay/like_replay_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/replay/read_replays_usecase.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/replay/update_replay_usecase.dart';

part 'replay_state.dart';

class ReplayCubit extends Cubit<ReplayState> {
  final CreateReplayUseCase createReplayUseCase;
  final DeleteReplayUseCase deleteReplayUseCase;
  final LikeReplayUseCase likeReplayUseCase;
  final ReadReplaysUseCase readReplaysUseCase;
  final UpdateReplayUseCase updateReplayUseCase;
  ReplayCubit({
    required this.createReplayUseCase,
    required this.updateReplayUseCase,
    required this.readReplaysUseCase,
    required this.likeReplayUseCase,
    required this.deleteReplayUseCase
}) : super(ReplayInitial());

  Future<void> getReplays({required ReplayEntity replay}) async {
    emit(ReplayLoading());
    try {
      final streamResponse = readReplaysUseCase.call(replay);
      streamResponse.listen((replays) {
        emit(ReplayLoaded(replays: replays));
      });
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> likeReplay({required ReplayEntity replay}) async {
    try {
      await likeReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> createReplay({required ReplayEntity replay}) async {
    try {
      await createReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> deleteReplay({required ReplayEntity replay}) async {
    try {
      await deleteReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> updateReplay({required ReplayEntity replay}) async {
    try {
      await updateReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }
}
