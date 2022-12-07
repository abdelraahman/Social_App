abstract class socialLoginState{}

class socialLoginInitialState extends socialLoginState{}
class socialLoginLoadingState extends socialLoginState{}
class socialLoginsuccessState extends socialLoginState{}
class socialLoginErrorState extends socialLoginState{
  String message;
  socialLoginErrorState(this.message);

}

