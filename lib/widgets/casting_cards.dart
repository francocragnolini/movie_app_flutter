import "package:flutter/material.dart";

//! codigo de referencia
class CastingCards extends StatelessWidget {
  const CastingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      color: Colors.red,
      margin: const EdgeInsets.only(bottom: 30),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => _CastCard(),
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      color: Colors.green,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            placeholder: AssetImage("assets/no-image.jpg"),
            image: NetworkImage("https://via.placeholder.com/150x300.png"),
            fit: BoxFit.cover,
            height: 140,
            width: 100,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "actor.name",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
