import 'package:shipping_plugin/src/bloc/mixins/ghtk_mixin.dart';

class GHTKBloc with GHTKMixin {
  GHTKBloc(Map ghtk) {
    this.ghtk = ghtk;
  }
}
