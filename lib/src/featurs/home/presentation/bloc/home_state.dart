part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {
  final bool? isMapView;
  HomeInitial({this.isMapView=false});
}
class ToggleViewState extends HomeState {
  final bool isMapView;

  ToggleViewState({required this.isMapView});
}