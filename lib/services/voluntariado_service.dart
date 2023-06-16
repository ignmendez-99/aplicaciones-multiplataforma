import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/persistence/voluntariado_dao.dart';

class VoluntariadoService {

  final VoluntariadoDao _voluntariadoDao = VoluntariadoDao();

  Future<List<Voluntariado>> getAllVoluntariados() async {
    return await _voluntariadoDao.getAllVoluntariados();
  }

  Future<List<Voluntariado>> getVoluntariadosFilteredByName({required String titleFilter}) async {
    return await _voluntariadoDao.getVoluntariadosFilteredByName(titleFilter: titleFilter);
  }
}