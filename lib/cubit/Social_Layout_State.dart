abstract class SocialLayoutStates{}
class SocialLayoutInitialState extends SocialLayoutStates{}
class SocialLayoutLoadingState extends SocialLayoutStates{}
class SocialLayoutSuccessState extends SocialLayoutStates{}
class SocialLayoutErrorState extends SocialLayoutStates{}


class SocialChangeIndexState extends SocialLayoutStates{}


class SocialChangeProfileSuccessState extends SocialLayoutStates{}
class SocialChangeProfileErrorState extends SocialLayoutStates{}
class SocialChangeCoverSuccessState extends SocialLayoutStates{}
class SocialChangeCoverErrorState extends SocialLayoutStates{}

class SocialChangeNameLoadingState extends SocialLayoutStates{}
class SocialChangeNameSuccessState extends SocialLayoutStates{}
class SocialChangeNameErrorState extends SocialLayoutStates{}

class SocialChangeBioLoadingState extends SocialLayoutStates{}
class SocialChangeBioSuccessState extends SocialLayoutStates{}
class SocialChangeBioErrorState extends SocialLayoutStates{}

// for post
class postLoadingState extends SocialLayoutStates{}
class postSuccessState extends SocialLayoutStates{}
class postErrorState extends SocialLayoutStates{}
// Get Post
class getPostLoadingState extends SocialLayoutStates{}
class getPostSuccessState extends SocialLayoutStates{}
class getPostErrorState extends SocialLayoutStates{}

// likePost
class likeLoadingState extends SocialLayoutStates{}
class likeSuccessState extends SocialLayoutStates{}
class likeErrorState extends SocialLayoutStates{}
// comment post
class CommentLoadingState extends SocialLayoutStates{}
class CommentSuccessState extends SocialLayoutStates{}
class CommentErrorState extends SocialLayoutStates{}
// show friends
class ShowFriendsLoadingState extends SocialLayoutStates{}
class ShowFriendsSuccessState extends SocialLayoutStates{}
class ShowFriendsErrorState extends SocialLayoutStates{}
// send message
class MessageSuccessState extends SocialLayoutStates{}
class MessageErrorState extends SocialLayoutStates{}
// get message
class GetMessSuccessState extends SocialLayoutStates{}
