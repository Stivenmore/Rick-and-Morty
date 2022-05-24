part of 'business_cubit.dart';

abstract class BusinessState extends Equatable {
  const BusinessState();

  @override
  List<Object> get props => [];
}
class BusinessInitial extends BusinessState {}

class BusinessLoading extends BusinessState {}

class BusinessLoaded extends BusinessState {
  const BusinessLoaded({required this.charatermodelslist});
  final List<CharaterModels> charatermodelslist;

  @override
  List<Object> get props => [charatermodelslist];
}

class BusinessNotConections extends BusinessState {}

class BusinessError extends BusinessState {}
