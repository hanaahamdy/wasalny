part of '../imports/stadiums_imports.dart';

class StadiumSlotsView extends StatefulWidget {
  final int stadiumId;
  final DateTime? startsAt;
  const StadiumSlotsView({super.key, required this.stadiumId, this.startsAt});

  bool get isSelectingEnd => startsAt != null;

  @override
  State<StadiumSlotsView> createState() => _StadiumSlotsViewState();
}

class _StadiumSlotsViewState extends State<StadiumSlotsView> {
  late final StadiumSlotsCubit _cubit = StadiumSlotsCubit(
    stadiumId: widget.stadiumId,
  );
  late DateTime _selectedDate = DateUtils.dateOnly(
    widget.startsAt ?? DateTime.now(),
  );
  StadiumSlot? _selectedSlot;

  @override
  void initState() {
    super.initState();
    _cubit.fetchSlots(_selectedDate);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _selectDate(DateTime date) {
    if (date.isBefore(DateUtils.dateOnly(DateTime.now()))) return;
    if (widget.startsAt != null &&
        date.isBefore(DateUtils.dateOnly(widget.startsAt!))) {
      return;
    }
    setState(() {
      _selectedDate = date;
      _selectedSlot = null;
    });
    _cubit.fetchSlots(date);
  }

  DateTime _dateWithTime(String time) {
    final parts = time.split(':');
    return DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      int.tryParse(parts.first) ?? 0,
      parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0,
    );
  }

  void _confirm() {
    final slot = _selectedSlot;
    if (slot == null) return;
    var endsAt = _dateWithTime(slot.endTime);
    final startsAt = _dateWithTime(slot.startTime);
    if (!endsAt.isAfter(startsAt)) endsAt = endsAt.add(const Duration(days: 1));
    if (widget.isSelectingEnd) {
      if (!endsAt.isAfter(widget.startsAt!)) return;
      Go.back(StadiumSlotSelection(startsAt: widget.startsAt!, endsAt: endsAt));
      return;
    }
    Go.back(StadiumSlotSelection(startsAt: startsAt, endsAt: endsAt));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: CustomAppbar(title: LocaleKeys.bookingsBookFieldTitle),
        backgroundColor: AppColors.scaffoldBackground,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 18.h),
          child: DefaultButton(
            title: LocaleKeys.stadiumsConfirm,
            height: 56.h,
            color: _selectedSlot == null ? AppColors.grey2 : AppColors.primary,
            borderRadius: BorderRadius.circular(28.r),
            onTap: _selectedSlot == null ? null : _confirm,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
          children: [
            Text(
              LocaleKeys.stadiumsBookingDateTime,

              style: TextStyle(
                color: AppColors.main,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            12.h.szH,
            _buildCalendar(),
            20.h.szH,
            Text(
              widget.isSelectingEnd
                  ? LocaleKeys.stadiumsBookingTo
                  : LocaleKeys.stadiumsBookingFrom,

              style: TextStyle(
                color: AppColors.main,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            12.h.szH,
            BlocBuilder<StadiumSlotsCubit, AsyncState<List<StadiumSlot>>>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: LoadingIndicator(color: AppColors.primary),
                  );
                }
                if (state.isError) {
                  return TextButton(
                    onPressed: () => _cubit.fetchSlots(_selectedDate),
                    child: Text(LocaleKeys.stadiumsRetry),
                  );
                }
                return Wrap(
                  spacing: 8.w,
                  runSpacing: 10.h,
                  children: state.data.map(_buildSlotChip).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .06),
            blurRadius: 30,
          ),
        ],
      ),
      child: CalendarDatePicker(
        initialDate: _selectedDate,
        firstDate: DateUtils.dateOnly(widget.startsAt ?? DateTime.now()),
        lastDate: DateUtils.dateOnly(
          DateTime.now(),
        ).add(const Duration(days: 30)),
        currentDate: DateTime.now(),
        onDateChanged: _selectDate,
      ),
    );
  }

  Widget _buildSlotChip(StadiumSlot slot) {
    final selected = identical(_selectedSlot, slot);
    final selectable = _isSlotSelectable(slot);
    final color = selected
        ? AppColors.createMatchHeader
        : selectable
        ? AppColors.white
        : AppColors.error.withValues(alpha: .08);
    return InkWell(
      onTap: selectable ? () => setState(() => _selectedSlot = slot) : null,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: selectable ? AppColors.moreDivider : AppColors.error,
          ),
        ),
        child: Text(
          '${slot.startTime} - ${slot.endTime}',
          style: TextStyle(
            color: selected
                ? AppColors.white
                : selectable
                ? AppColors.main
                : AppColors.error,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  bool _isSlotSelectable(StadiumSlot slot) {
    if (!slot.isAvailable) return false;
    final startsAt = widget.startsAt;
    if (startsAt == null) return true;
    var slotEnd = _dateWithTime(slot.endTime);
    final slotStart = _dateWithTime(slot.startTime);
    if (!slotEnd.isAfter(slotStart)) {
      slotEnd = slotEnd.add(const Duration(days: 1));
    }
    return slotEnd.isAfter(startsAt);
  }
}
