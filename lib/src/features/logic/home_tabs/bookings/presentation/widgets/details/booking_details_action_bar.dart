part of '../../bookings_feature.dart';

class _BookingDetailsActionBar extends StatelessWidget {
  final BookingEntity booking;

  const _BookingDetailsActionBar({required this.booking});

  bool get _canPay => booking.canPay;
  bool get _canApprove => booking.canApprove;
  bool get _canRate => booking.canRate;
  bool get _canShowTeamMembers => _isNew && booking.playersCount > 0;
  bool get _showPayWithTeamMembers => _canPay && _canShowTeamMembers;
  bool get _isNew => booking.status == BookingStatus.fresh;
  bool get _hasSecondaryActions => booking.canCancel || _canShowTeamMembers;
  bool get _hasActions =>
      _canPay || _canApprove || _hasSecondaryActions || _canRate;

  @override
  Widget build(BuildContext context) {
    if (!_hasActions) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_canPay && !_showPayWithTeamMembers)
            _PayOrderButton(booking: booking),
          if (_canPay &&
              !_showPayWithTeamMembers &&
              (_canApprove || _hasSecondaryActions || _canRate))
            SizedBox(height: 12.h),
          if (_canApprove) _BookingApprovalButtons(booking: booking),
          if (_canApprove && (_hasSecondaryActions || _canRate))
            SizedBox(height: 12.h),
          if (_hasSecondaryActions)
            _BookingNewActionsRow(
              booking: booking,
              showPayButton: _showPayWithTeamMembers,
            ),
          if (_hasSecondaryActions && _canRate) SizedBox(height: 12.h),
          if (_canRate) _RateOrderButton(bookingId: booking.id),
        ],
      ),
    );
  }
}

class _BookingNewActionsRow extends StatelessWidget {
  final BookingEntity booking;
  final bool showPayButton;

  const _BookingNewActionsRow({
    required this.booking,
    this.showPayButton = false,
  });

  bool get _canShowTeamMembers =>
      booking.status == BookingStatus.fresh && booking.playersCount > 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showPayButton) ...[
          Expanded(child: _PayOrderButton(booking: booking)),
          if (booking.canCancel || _canShowTeamMembers) SizedBox(width: 12.w),
        ],
        if (booking.canCancel) ...[
          Expanded(child: _CancelOrderButton(booking: booking)),
          if (_canShowTeamMembers) SizedBox(width: 12.w),
        ],
        if (_canShowTeamMembers)
          Expanded(
            child: DefaultButton(
              title: LocaleKeys.bookingsTeamMembers,
              height: 56.h,
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(28.r),
              onTap: () => Go.to(BookingPlayersView(bookingId: booking.id)),
            ),
          ),
      ],
    );
  }
}

class _PayOrderButton extends StatelessWidget {
  final BookingEntity booking;

  const _PayOrderButton({required this.booking});

  int? get _playerId {
    final currentUserId = int.tryParse(UserCubit.instance.state.userModel.id);
    if (currentUserId == null) return null;
    for (final player in booking.players) {
      if (player.userId == currentUserId) return player.id;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PayBookingCubit(
        playerId: _playerId,
        paymentMethod: booking.paymentMethodValue,
      ),
      child: BlocConsumer<PayBookingCubit, AsyncState<String?>>(
        listener: _handleActionState,
        builder: (context, state) => DefaultButton(
          title: LocaleKeys.pay,
          height: 56.h,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28.r),
          onTap: state.status.isLoading || _playerId == null
              ? null
              : context.read<PayBookingCubit>().pay,
          customChild: state.status.isLoading
              ? SizedBox.square(
                  dimension: 22.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _BookingApprovalButtons extends StatelessWidget {
  final BookingEntity booking;

  const _BookingApprovalButtons({required this.booking});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingMatchResponseCubit(matchId: booking.matchId),
      child: BlocConsumer<BookingMatchResponseCubit, AsyncState<String?>>(
        listener: _handleActionState,
        builder: (context, state) => Row(
          children: [
            Expanded(
              child: DefaultButton(
                title: LocaleKeys.bookingDetailsAcceptBooking,
                height: 56.h,
                color: AppColors.bookingSuccessGreen,
                borderRadius: BorderRadius.circular(28.r),
                onTap: state.status.isLoading || booking.matchId == null
                    ? null
                    : () => context.read<BookingMatchResponseCubit>().respond(
                        BookingMatchResponseAction.accept,
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: DefaultButton(
                title: LocaleKeys.bookingDetailsRejectBooking,
                height: 56.h,
                color: AppColors.bookingCancelRed,
                borderRadius: BorderRadius.circular(28.r),
                onTap: state.status.isLoading || booking.matchId == null
                    ? null
                    : () => context.read<BookingMatchResponseCubit>().respond(
                        BookingMatchResponseAction.reject,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CancelOrderButton extends StatelessWidget {
  final BookingEntity booking;

  const _CancelOrderButton({required this.booking});

  Future<void> _showCancelReasonsSheet(BuildContext context) async {
    final reason = await showModalBottomSheet<CancelReasonEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const _CancelBookingReasonsSheet(),
    );
    if (reason == null || !context.mounted) return;
    context.read<CancelBookingCubit>().cancel(reason);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CancelBookingCubit(bookingId: booking.id),
      child: BlocConsumer<CancelBookingCubit, AsyncState<String?>>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.success,
              message: state.data?.isNotEmpty == true
                  ? state.data!
                  : LocaleKeys.dataUpdatedSuccessfully,
            );
            Go.back(true);
          } else if (state.status.isError) {
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.error,
              message: state.errorMessage ?? '',
            );
          }
        },
        builder: (context, state) => DefaultButton(
          title: LocaleKeys.bookingsCancelOrder,
          height: 56.h,
          color: AppColors.bookingCancelRed,
          borderRadius: BorderRadius.circular(28.r),
          onTap: state.status.isLoading
              ? null
              : () => _showCancelReasonsSheet(context),
          customChild: state.status.isLoading
              ? SizedBox.square(
                  dimension: 22.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _RateOrderButton extends StatelessWidget {
  final int bookingId;

  const _RateOrderButton({required this.bookingId});

  Future<void> _showRatingSheet(BuildContext context) async {
    final submitted = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => RateBookingCubit(bookingId: bookingId),
        child: const _RatingSheet(),
      ),
    );
    if (submitted == true && context.mounted) {
      context.read<BookingDetailsCubit>().fetchDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      title: LocaleKeys.bookingsRateStadium,
      height: 56.h,
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(28.r),
      onTap: () async => _showRatingSheet(context),
    );
  }
}

void _handleActionState(BuildContext context, AsyncState<String?> state) {
  if (state.status.isSuccess) {
    MessageUtils.showSnackBar(
      context: context,
      baseStatus: BaseStatus.success,
      message: state.data?.isNotEmpty == true
          ? state.data!
          : LocaleKeys.dataUpdatedSuccessfully,
    );
    context.read<BookingDetailsCubit>().fetchDetails();
  } else if (state.status.isError) {
    MessageUtils.showSnackBar(
      context: context,
      baseStatus: BaseStatus.error,
      message: state.errorMessage ?? '',
    );
  }
}

class PayBookingCubit extends AsyncCubit<String?> {
  final int? playerId;
  final String paymentMethod;

  PayBookingCubit({required this.playerId, required this.paymentMethod})
    : super(null);

  Future<void> pay() async {
    if (isLoading || playerId == null) return;

    setLoading();
    try {
      final response = await injector<NetworkService>().callApi<String>(
        NetworkRequest(
          method: RequestMethod.post,
          path: ApiConstants.payBookingPlayer(playerId!),
          body: {
            'payment_method': paymentMethod.isNotEmpty
                ? paymentMethod
                : 'online',
          },
        ),
        mapper: (json) {
          final response = json is Map
              ? Map<String, dynamic>.from(json)
              : const <String, dynamic>{};
          return response['message']?.toString() ?? '';
        },
      );
      setSuccess(data: response.data);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }
}

enum BookingMatchResponseAction {
  accept('accept'),
  reject('reject');

  final String apiValue;
  const BookingMatchResponseAction(this.apiValue);
}

class BookingMatchResponseCubit extends AsyncCubit<String?> {
  final int? matchId;

  BookingMatchResponseCubit({required this.matchId}) : super(null);

  Future<void> respond(BookingMatchResponseAction action) async {
    if (isLoading || matchId == null) return;

    setLoading();
    try {
      final response = await injector<NetworkService>().callApi<String>(
        NetworkRequest(
          method: RequestMethod.post,
          path: ApiConstants.respondToBookingMatch(matchId!),
          body: {'action': action.apiValue},
        ),
        mapper: (json) {
          final response = json is Map
              ? Map<String, dynamic>.from(json)
              : const <String, dynamic>{};
          return response['message']?.toString() ?? '';
        },
      );
      setSuccess(data: response.data);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }
}
