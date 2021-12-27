import 'package:animations/src/basics/02_page_route_builder_page.dart';
import 'package:animations/src/basics/03_animation_controller_page.dart';
import 'package:animations/src/basics/04_tweens_page.dart';
import 'package:animations/src/basics/05_animated_builder.dart';
import 'package:animations/src/basics/06_custom_tween_page.dart';
import 'package:animations/src/basics/07_tween_sequence.dart';
import 'package:animations/src/basics/08_fade_transition.dart';
import 'package:animations/src/miscs/01_expand_card_page.dart';
import 'package:animations/src/miscs/02_carousel_page.dart';
import 'package:animations/src/miscs/03_focus_image_page.dart';
import 'package:animations/src/miscs/04_card_swipe_page.dart';
import 'package:animations/src/miscs/05_repeating_animation_page.dart';
import 'package:animations/src/miscs/06_physics_card_drag_page.dart';
import 'package:animations/src/miscs/07_animated_list_page.dart';
import 'package:animations/src/miscs/08_animated_positioned_page.dart';
import 'package:animations/src/miscs/09_animated_switcher_page.dart';
import 'package:animations/src/miscs/10_hero_animation_page.dart';
import 'package:animations/src/miscs/11_curved_animation_page.dart';
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
  Item(
      name: 'Expandable Card',
      route: ExpandCardPage.routeName,
      builder: (context) => const ExpandCardPage()),
  Item(
      name: 'Carousel',
      route: CarouselPage.routeName,
      builder: (context) => CarouselPage()),
  Item(
      name: 'Focus Image',
      route: FocusImagePage.routeName,
      builder: (context) => const FocusImagePage()),
  Item(
      name: 'Card Swipe',
      route: CardSwipePage.routeName,
      builder: (context) => const CardSwipePage()),
  Item(
      name: 'Repeating Animation',
      route: RepeatingAnimationPage.routeName,
      builder: (context) => const RepeatingAnimationPage()),
  Item(
      name: 'Spring Physics',
      route: PhysicsCardDragPage.routeName,
      builder: (context) => const PhysicsCardDragPage()),
  Item(
      name: 'AnimatedList',
      route: AnimatedListPage.routeName,
      builder: (context) => const AnimatedListPage()),
  Item(
      name: 'AnimatedPositioned ',
      route: AnimatedPositionedPage.routeName,
      builder: (context) => const AnimatedPositionedPage()),
  Item(
      name: 'AnimatedSwitcher',
      route: AnimatedSwitcherPage.routeName,
      builder: (context) => const AnimatedSwitcherPage()),
  Item(
      name: 'Hero Animation',
      route: HeroAnimationPage.routeName,
      builder: (context) => const HeroAnimationPage()),
  Item(
      name: 'Curved Animation',
      route: CurvedAnimationPage.routeName,
      builder: (context) => const CurvedAnimationPage()),
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
