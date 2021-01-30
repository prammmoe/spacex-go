import '../models/index.dart';
import '../repositories/index.dart';
import 'base/index.dart';

/// Cubit that holds a list of SpaceX vehicles.
class VehiclesCubit extends RequestCubit<VehiclesRepository, List<Vehicle>> {
  VehiclesCubit(VehiclesRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading());

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }

  Vehicle getVehicle(String id) {
    if (state.status == RequestStatus.loaded) {
      return state.value.where((l) => l.id == id).single;
    } else {
      return null;
    }
  }

  String getVehicleType(String id) {
    if (state.status == RequestStatus.loaded) {
      return state.value.where((vehicle) => vehicle.id == id).single.type;
    } else {
      return null;
    }
  }
}
