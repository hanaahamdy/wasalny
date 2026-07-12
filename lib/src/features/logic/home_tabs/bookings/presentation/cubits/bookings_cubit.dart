part of '../bookings_feature.dart';

class BookingsState extends Equatable {
  final bool isLoading;
  final List<BookingEntity> bookings;
  final BookingStatus selectedStatus;
  final String? errorMessage;

  const BookingsState({
    this.isLoading = false,
    this.bookings = const [],
    this.selectedStatus = BookingStatus.fresh,
    this.errorMessage,
  });

  List<BookingEntity> get filteredBookings => bookings
      .where((booking) => booking.status == selectedStatus)
      .toList(growable: false);

  BookingsState copyWith({
    bool? isLoading,
    List<BookingEntity>? bookings,
    BookingStatus? selectedStatus,
    String? errorMessage,
  }) {
    return BookingsState(
      isLoading: isLoading ?? this.isLoading,
      bookings: bookings ?? this.bookings,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    bookings,
    selectedStatus,
    errorMessage,
  ];
}

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit() : super(const BookingsState());

  Future<void> loadBookings() async {
    emit(state.copyWith(isLoading: true));
    try {
      final bookings = await _FakeBookingsApi.getBookings();
      emit(state.copyWith(isLoading: false, bookings: bookings));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  void selectStatus(BookingStatus status) {
    emit(state.copyWith(selectedStatus: status));
  }
}
