import 'package:aplicaciones_multiplataforma/persistence/user_dao.dart';

import '../models/user.dart';

class UserService {

  static UserService? _instance;

  UserService._(); // Private constructor

  factory UserService() {
    if (_instance == null) {
      _instance = UserService._();
    }
    return _instance!;
  }

  final UserDao _userDao = UserDao();

  Future<User> getUserById(String id) async {
    return await _userDao.getUserById(id);
  }

  Future<User> createUser(String email, bool emailVerified) async {
    return await _userDao.createUser(email, emailVerified);
  }

  Future<void> changeFavouriteInVoluntariado({
    required String userId,
    required String voluntariadoId,
    required bool changeTo
  }) async {
    return await _userDao.changeFavouriteInVoluntariado(
      voluntariadoId: voluntariadoId,
      userId: userId,
      changeTo: changeTo
    );
  }
}