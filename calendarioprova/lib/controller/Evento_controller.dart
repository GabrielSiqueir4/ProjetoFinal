import 'package:calendarioprova/Db/db_helper.dart';
import 'package:calendarioprova/models/Evento.dart';
import 'package:get/get.dart';

class EventoController extends GetxController {
  void onRead() {
    super.onReady();
  }

  var eventoList = <Evento>[].obs;

  Future<int> addEvento({Evento? evento}) async {
    return await DbHelper.insert(evento);
  }

  void getEvento() async {
    List<Map<String, dynamic>> evento = await DbHelper.query();
    eventoList.assignAll(evento.map((data) => Evento.fromJson(data)).toList());
  }

  void delete(Evento evento) {
    DbHelper.delete(evento);
  }
}
