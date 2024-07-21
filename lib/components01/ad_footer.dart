import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AdFooter extends StatelessWidget {
  const AdFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Shimmer(
        period: Duration(seconds: 2),
        direction: ShimmerDirection.ltr,
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          Theme.of(context).colorScheme.primary.withOpacity(1),
          Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          Theme.of(context).colorScheme.primary.withOpacity(1)
        ]),
        child: Container(
          height: size.height * 0.1,
          width: double.infinity,
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.red),
              color: Colors.white.withOpacity(0.1)),
          child: Center(
            child: Text('Ad will show here'),
          ),
        ),
      ),
    );
  }
}
