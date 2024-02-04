import 'package:flutter/material.dart';
import 'package:portfolio/3d_moving_points/moving_dots_3d.dart';
import 'package:portfolio/moving_dots/screens/moving_dots_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MovingDots3D(
        child: Text(
      "Hehe",
      style: TextStyle(
        color: Colors.white,
      ),
    ));

    return MovingDotsScreen(
      child: Container(
        color: Colors.black45,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shivanshu Gupta',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white),
              ),
              Text(
                'Flutter Developer',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
