import 'package:flutter/foundation.dart';
import 'package:flutteronline/redux/profile/profileAction.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class ProfileState extends Equatable {
  final Map<String , dynamic> profile ;

  ProfileState({
    //this.profile = const{'email' : 'mary@gmail.com', 'name' : 'marry', 'role' : 'admin'}
    this.profile = const{'email' : ' ', 'name' : ' ', 'role' : ' '}
  });

  ProfileState copyWith({Map<String , dynamic> profile}) {
    return ProfileState(
      profile: profile ?? this.profile
    );
  }

  @override
    List<Object> get props => [profile];


}


profileReducer(ProfileState state, dynamic action){
  if(action is GetProfileAction){
    return state.copyWith(
      profile: action.profileState.profile
    );
  }
  return state;
}