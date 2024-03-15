part of 'config_cubit.dart';

sealed class ConfigState extends Equatable {
  const ConfigState();

  @override
  List<Object> get props => [];
}

final class ConfigInitial extends ConfigState {}

final class ConfigSet extends ConfigState {

  final Configuration configuration;

  const ConfigSet(this.configuration);

  @override
  List<Object> get props => [configuration];

}
