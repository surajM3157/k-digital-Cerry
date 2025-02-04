import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piwotapp/constants/colors.dart';
import '../../constants/images.dart';
import '../../route/route_names.dart';
import '../../shared prefs/pref_manager.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0.0, end: 3000.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().then((_) async{
      // Navigate to next screen once animation completes
      // You can use Navigator.pushReplacement or Navigator.push
      await Prefs.load();
      Prefs.loadData();
      print("username ${Prefs.checkUsername}");
      _loadScreen();
    });
  }

  _loadScreen() async
  {
    await Prefs.load();
    Prefs.loadData();

    if(Prefs.checkLogin == true)
    {
      if(Prefs.checkProfile == true) {
        Get.offAllNamed(Routes.editProfile);
      }else{
        Get.offAllNamed(Routes.home);
      }
    }
    else
    {
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              decoration: BoxDecoration(
                shape: _animation.value > 500 ?BoxShape.rectangle:BoxShape.circle,
                gradient: LinearGradient(
                  colors: AppColor.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: _animation.value > 2000 ? SvgPicture.asset(Images.logo) : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

