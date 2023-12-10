import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_project/providers/post_provider.dart';

import '../navigation/app_navigator.dart';
import '../providers/user_provider.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPoppedBack;
  BasePage({required this.child, this.onPoppedBack});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppNavigator.navigationObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppNavigator.navigationObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() async{
    final UserProvider userProvider = await context.read<UserProvider>();
    await context.read<PostProvider>().fetchPosts(userProvider.user!.email);
    if (widget.onPoppedBack != null) {
      widget.onPoppedBack!();
    }
  }


  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
