import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone_app/features/domain/entities/replay/replay_entity.dart';
import 'package:instagram_clone_app/features/presentation/cubit/replay/replay_cubit.dart';
import 'package:instagram_clone_app/features/presentation/page/post/comment/widgets/edit_replay_main_widget.dart';
import 'package:instagram_clone_app/injection_container.dart' as di;

class EditReplayPage extends StatelessWidget {
  final ReplayEntity replay;

  const EditReplayPage({Key? key, required this.replay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReplayCubit>(
      create: (context) => di.sl<ReplayCubit>(),
      child: EditReplayMainWidget(replay: replay),
    );
  }
}
