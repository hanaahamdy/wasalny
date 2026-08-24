part of '../imports/presentation_imports.dart';


class CreateDeliveryCubit extends Cubit<CreateDeliveryStates> with CreateDeliveryControllers {
  CreateDeliveryCubit() : super(CreateDeliveryInitial());
}