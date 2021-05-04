import 'package:mwazaf_app/screens/login/model.dart';
import 'package:rxdart/rxdart.dart';

class UserController {
  BehaviorSubject<UserData> _user = BehaviorSubject<UserData>();
  UserData get user => _user.value;
  Function(UserData) get changeUser => _user.sink.add;
  Stream<UserData> get userStream => _user.stream;
  dispose() {
    _user.close();
  }
}

UserController userController = UserController();
