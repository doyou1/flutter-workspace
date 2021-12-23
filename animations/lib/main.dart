import 'package:animations/src/basics/02_page_route_builder_page.dart';
import 'package:animations/src/basics/03_animation_controller_page.dart';
import 'package:animations/src/basics/04_tweens_page.dart';
import 'package:animations/src/basics/05_animated_builder.dart';
import 'package:animations/src/basics/06_custom_tween_page.dart';
import 'package:animations/src/basics/07_tween_sequence.dart';
import 'package:animations/src/basics/08_fade_transition.dart';
import 'package:flutter/material.dart';
import 'package:animations/src/basics/01_animated_container_page.dart';

void main() => runApp(const Animations());

class Item {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const Item({
    required this.name,
    required this.route,
    required this.builder,
  });
}

final basics = [
  Item(
      name: 'AnimatedContainer',
      route: AnimatedContainerPage.routeName,
      builder: (context) => const AnimatedContainerPage()),
  Item(
      name: 'PageRouteBuilder',
      route: PageRouteBuilderPage.routeName,
      builder: (context) => const PageRouteBuilderPage()),
  Item(
      name: 'Animation Controller',
      route: AnimationControllerPage.routeName,
      builder: (context) => const AnimationControllerPage()),
  Item(
      name: 'Tweens',
      route: TweensPage.routeName,
      builder: (context) => const TweensPage()),
  Item(
      name: 'AnimatedBuilder',
      route: AnimatedBuilderPage.routeName,
      builder: (context) => const AnimatedBuilderPage()),
  Item(
      name: 'Custom Tween',
      route: CustomTweenPage.routeName,
      builder: (context) => const CustomTweenPage()),
  Item(
      name: 'Tween Sequences',
      route: TweenSequencePage.routeName,
      builder: (context) => const TweenSequencePage()),
  Item(
      name: 'Fade Transition',
      route: FadeTransitionPage.routeName,
      builder: (context) => const FadeTransitionPage()),
];

final miscs = [
  // Item(
  //     name: 'Fepandable Card',
  //     route: FepandableCard.routeName,
  //     builder: (context) => const FepandableCard()),
  // Item(
  //     name: 'Carousel',
  //     route: Carousel.routeName,
  //     builder: (context) => const Carousel()),
  // Item(
  //     name: 'Focus Image',
  //     route: FocusImage.routeName,
  //     builder: (context) => const FocusImage()),
  // Item(
  //     name: 'Card Swipe',
  //     route: CardSwipe.routeName,
  //     builder: (context) => const CardSwipe()),
  // Item(
  //     name: 'Repeating Animation',
  //     route: RepeatingAnimation.routeName,
  //     builder: (context) => const RepeatingAnimation()),
  // Item(
  //     name: 'Spring Physics',
  //     route: SpringPhysics.routeName,
  //     builder: (context) => const SpringPhysics()),
  // Item(
  //     name: 'AnimatedList',
  //     route: AnimatedList.routeName,
  //     builder: (context) => const AnimatedList()),
  // Item(
  //     name: 'AnimatedPositioned ',
  //     route: AnimatedPositioned.routeName,
  //     builder: (context) => const AnimatedPositioned()),
  // Item(
  //     name: 'AnimatedSwitcher',
  //     route: AnimatedSwitcher.routeName,
  //     builder: (context) => const AnimatedSwitcher()),
  // Item(
  //     name: 'Hero Animation',
  //     route: HeroAnimation.routeName,
  //     builder: (context) => const HeroAnimation()),
  // Item(
  //     name: 'Curved Animation',
  //     route: CurvedAnimation.routeName,
  //     builder: (context) => const CurvedAnimation()),
];

final basicRoutes =
    Map.fromEntries(basics.map((i) => MapEntry(i.route, i.builder)));

final miscRoutes =
    Map.fromEntries(miscs.map((i) => MapEntry(i.route, i.builder)));

final allRoutes = <String, WidgetBuilder>{
  ...basicRoutes,
  ...miscRoutes,
};

class Animations extends StatelessWidget {
  const Animations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: allRoutes,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: ListView(
        children: [
          ListTile(
              title: Text(
            'Basics',
            style: headerStyle,
          )),
          ...basics.map((i) => AnimationTile(
                item: i,
              )),
          ListTile(
              title: Text(
            'Miscs',
            style: headerStyle,
          )),
          ...miscs.map((i) => AnimationTile(item: i)),
        ],
      ),
    );
  }
}

class AnimationTile extends StatelessWidget {
  final Item item;

  const AnimationTile({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(item.name),
        onTap: () {
          Navigator.pushNamed(context, item.route);
        });
  }
}
