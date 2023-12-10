//ignore_for_file: constant_identifier_names

enum RouteType{
  LoginPage,
  RegisterPageDisabilities,
  TypeOfAccount,
  RegisterPageCaretakers,
  AddRecordPage,
  MainMenuPage,
  ViewAccountPage,
  AddPostPage,
  ViewPostsPage,
  ViewNotificationsPage

}
extension RouteTypeNamed on RouteType{
  String path(){
    return '/$name';
  }
}