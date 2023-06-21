import 'package:aplicaciones_multiplataforma/persistence/user_dao.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('user testing', () {
    const email = 'testEmail@gmail.com';
    const password = 'TESTpassword123';
    const firstName = 'Test';
    const lastName = 'User';
    const phone = '123132';
    final _auth = MockFirebaseAuth();
    final _fireStoreInstance = FakeFirebaseFirestore();
    final _userDao = UserDao(_fireStoreInstance);

    test('User should be created', () async {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      _userDao.createUser(email: email, emailVerified: true, firstName: firstName,
          lastName: lastName, userId: _auth.currentUser!.uid);
      expect((await _userDao.getUserById(_auth.currentUser!.uid)).firstName, 'Test');
    });

    test('User should be updated successfully', () async {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);

        _userDao.createUser(email: email, emailVerified: true, firstName: firstName,
            lastName: lastName, userId: _auth.currentUser!.uid);
        await _userDao.updateUser(userId: _auth.currentUser!.uid, phone: phone);
        expect((await _userDao.getUserById(_auth.currentUser!.uid)).phone, phone);
    });
  });
}