import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_shipment_state.dart';

class CreateShipmentCubit extends Cubit<CreateShipmentState> {
  CreateShipmentCubit() : super(CreateShipmentInitial());
}
