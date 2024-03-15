import 'package:bloc/bloc.dart';
import 'package:consumer_cms/Models/Configuration.dart';
import 'package:equatable/equatable.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  ConfigCubit() : super(ConfigInitial());
  

  Configuration? configuration;

  void setConfig(Configuration config){
    configuration = config;
    emit(ConfigSet(config));
  }

  Configuration? getConfiguration(){
    return configuration;
  }

}
