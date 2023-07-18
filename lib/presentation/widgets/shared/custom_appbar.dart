import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: Theme.of(context).colorScheme.primary
              ),
              const SizedBox(width: 5),
              Text(
                "Cinemapedia",
                style: Theme.of(context).textTheme.titleMedium
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){},
              )
            ],
          )
        ),
      )
    );
  }
}