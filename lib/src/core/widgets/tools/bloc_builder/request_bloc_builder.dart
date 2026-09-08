import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../extensions/base_state.dart';
import '../../../shared/models/request_state.dart';
import '../../handling_views/error_view.dart';

class RequestBlocBuilder<B extends StateStreamable<RequestState<T>>, T>
    extends StatelessWidget {
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context)? skeletonBuilder;
  final Widget Function(BuildContext context, String error)? errorBuilder;
  final bool Function(RequestState<T> previous, RequestState<T> current)?
  buildWhen;

  const RequestBlocBuilder({
    super.key,
    required this.builder,
    this.skeletonBuilder,
    this.errorBuilder,
    this.buildWhen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, RequestState<T>>(
      buildWhen: buildWhen,
      builder: (context, state) {
        if (state.status.isError) {
          return errorBuilder?.call(context, state.errorMessage ?? '') ??
              ErrorView(error: state.errorMessage ?? '');
        }
        if (state.status.isSuccess) return builder(context, state.data);
        if (skeletonBuilder == null) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return Skeletonizer(enabled: true, child: skeletonBuilder!(context));
      },
    );
  }
}
