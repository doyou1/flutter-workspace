import 'package:flutter/material.dart';

class PageRouteBuilderPage extends StatelessWidget {
  const PageRouteBuilderPage({Key? key}) : super(key: key);
  static const String routeName = '/basics/page_route_builder_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go!'),
          onPressed: () {
            Navigator.of(context).push<void>(_createRoute());
          },
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder<SlideTransition>(
      pageBuilder: (context, animation, secondaryAnimation) => _Page2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween =
            Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero);
        var curveTween = CurveTween(curve: Curves.ease);

        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: child,
        );
      });
}

class _Page2 extends StatelessWidget {
  const _Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Text(
          'Page 2!',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
