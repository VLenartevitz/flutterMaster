import 'package:flutter/material.dart';

import '../../commons/app_images.dart';
import '../../utils/sizes.dart';

class WidgetSplash extends StatefulWidget {
  final double width;
  final double height;
  final double widthName;
  final bool isLoading;
  final String name;

  const WidgetSplash({
    super.key,
    this.width = 230,
    this.height = 230,
    this.widthName = 0,
    this.isLoading = false,
    required this.name,
  });

  @override
  _WidgetSplashState createState() => _WidgetSplashState();
}

class _WidgetSplashState extends State<WidgetSplash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                width: widget.width,
                height: widget.height,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Image.asset(AppImages.logo),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                width: widget.width >= AppSizes.width ? AppSizes.width : widget.width,
                height: 20,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                child: SizedBox(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Visibility(
            visible: widget.isLoading,
            child:
                const CircularProgressIndicator(backgroundColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
