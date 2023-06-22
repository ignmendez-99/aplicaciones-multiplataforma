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
    final auth = MockFirebaseAuth();
    final fireStoreInstance = FakeFirebaseFirestore();
    final userDao = UserDao(fireStoreInstance);

    test('User should be created', () async {
      await auth.createUserWithEmailAndPassword(email: email, password: password);

      userDao.createUser(email: email, emailVerified: true, firstName: firstName,
          lastName: lastName, userId: auth.currentUser!.uid);
      var user = await userDao.getUserById(auth.currentUser!.uid);
      expect(user.firstName, firstName);
      expect(user.lastName, lastName);
      expect(user.email, email);
    });

    test('User should be updated successfully', () async {
        await auth.createUserWithEmailAndPassword(email: email, password: password);

        userDao.createUser(email: email, emailVerified: true, firstName: firstName,
            lastName: lastName, userId: auth.currentUser!.uid);
        await userDao.updateUser(userId: auth.currentUser!.uid, phone: phone);
        var user = await userDao.getUserById(auth.currentUser!.uid);
        expect(user.phone, phone);
        expect(user.firstName, firstName);
        expect(user.lastName, lastName);
        expect(user.email, email);
    });
  });
}