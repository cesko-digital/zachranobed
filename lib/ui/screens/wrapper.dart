import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zachranobed/models/user.dart';
import 'package:zachranobed/routes.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadUserInfo();
    });
  }

  _loadUserInfo() {
    User user = context.read<User>();
    if (user.email == "") {
      Navigator.of(context).pushReplacementNamed(RouteManager.login);
    } else {
      Navigator.of(context).pushReplacementNamed(RouteManager.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
