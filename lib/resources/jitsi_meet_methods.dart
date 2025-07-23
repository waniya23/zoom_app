import 'package:zoom_app/resources/auth_methods.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_app/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods=FirestoreMethods();
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username= ''
  }) async {
    try {
      String name;
      if(username.isEmpty){
        name=_authMethods.user.displayName!;
      }else{
        name=username;
      }

      // Feature flags are configured differently in the wrapper
      var options = JitsiMeetingOptions(
        roomNameOrUrl: roomName,
        userDisplayName: name,
        userEmail: _authMethods.user.email,
        userAvatarUrl: _authMethods.user.photoURL,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
      );

      // To set resolution (360p), use serverURL or configOverrides
      // options.serverUrl = "https://meet.jit.si";  // Default server (or your custom Jitsi instance)

      // Optional: Override video resolution via config
      // options.configOverrides = {
      //   "resolution": 360,  // Sets 360p resolution
      //   "startWithVideoMuted": isVideoMuted,
      //   "startWithAudioMuted": isAudioMuted,
      // };
      _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeetWrapper.joinMeeting(options: options);
    } catch (e) {
      print("Error joining meeting: $e");
    }
  }
}
