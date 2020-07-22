import 'package:flutteronline/redux/profile/profileReducer.dart';
import 'package:meta/meta.dart';

@immutable
class GetProfileAction {
  final ProfileState profileState;

  GetProfileAction(this.profileState);
}

//action
getProfileAction(Map profile) {
  //logic
  return GetProfileAction( 
    ProfileState(profile: profile)
  );
}