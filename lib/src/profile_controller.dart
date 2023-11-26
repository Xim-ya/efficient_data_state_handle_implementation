import 'package:data_state_handle_implementation/src/date_state.dart';
import 'package:data_state_handle_implementation/src/profile.dart';

class ProfileController {
  Ds<Profile> profileInfo = Loading<Profile>();

  Future<void> fetchData() async {
    try {
      profileInfo = Fetched(
        Profile(
          imgUrl: 'https://avatars.githubusercontent.com/u/75591730?v=4',
          name: 'Ximya',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ),
      );
    } catch (e) {
      profileInfo = Failed(e);
    }
  }

  void setLoading() {
    profileInfo = Loading();
  }

  void setFailed() {
    profileInfo = Failed('Something went wrong');
  }
}
