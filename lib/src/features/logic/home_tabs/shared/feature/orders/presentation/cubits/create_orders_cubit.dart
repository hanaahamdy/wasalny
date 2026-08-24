part of '../imports/view_imports.dart';

class CreateOrdersCubit extends Cubit<CreateOrdersState>
    with CreateOrdersMixin {
  CreateOrdersCubit() : super(const CreateOrdersState());
}
