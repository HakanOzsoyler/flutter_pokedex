import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'model/pokedex.dart';

// ignore: must_be_immutable
class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRengiBul();
  }

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(NetworkImage(
            'https://img.pokemondb.net/sprites/bank/normal/${widget.pokemon.name.toLowerCase()}.png'));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: baskinRenk,
        appBar: AppBar(
          backgroundColor: baskinRenk,
          elevation: 0,
          title: Text(widget.pokemon.name),
        ),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if (orientation == Orientation.portrait) {
              return dikeyBody(context);
            } else {
              return yatayBody(context);
            }
          },
        ));
  }

  Stack dikeyBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * (2 / 3),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.12,
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 70),
                Text(
                  widget.pokemon.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text("Height : " + widget.pokemon.height),
                Text("Weight : " + widget.pokemon.weight),
                Text(
                  "Types",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type
                      .map((typ) => Chip(
                          backgroundColor: Colors.orange.shade100,
                          elevation: 6,
                          label: Text(typ)))
                      .toList(),
                ),
                Text(
                  "Next Evolution",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                          .map((evolution) => Chip(
                              backgroundColor: Colors.orange.shade100,
                              elevation: 6,
                              label: Column(
                                children: [
                                  Text(evolution.name),
                                  Text(evolution.num),
                                ],
                              )))
                          .toList()
                      : [Text("Son Hali")],
                ),
                Text(
                  "Weakness",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                          .map((weakness) => Chip(
                              backgroundColor: Colors.orange.shade100,
                              elevation: 6,
                              label: Text(weakness)))
                          .toList()
                      : [Text("Son Hali")],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.name,
            child: Container(
              width: 200,
              height: 200,
              child: Image.network(
                'https://img.pokemondb.net/sprites/bank/normal/${widget.pokemon.name.toLowerCase()}.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget yatayBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height * (3 / 4),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Hero(
              tag: widget.pokemon.name,
              child: Container(
                width: 200,
                child: Image.network(
                  'https://img.pokemondb.net/sprites/bank/normal/${widget.pokemon.name.toLowerCase()}.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text("Height : " + widget.pokemon.height),
                  Text("Weight : " + widget.pokemon.weight),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((typ) => Chip(
                            backgroundColor: Colors.orange.shade100,
                            elevation: 6,
                            label: Text(typ)))
                        .toList(),
                  ),
                  Text(
                    "Next Evolution",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evolution) => Chip(
                                backgroundColor: Colors.orange.shade100,
                                elevation: 6,
                                label: Column(
                                  children: [
                                    Text(evolution.name),
                                    Text(evolution.num),
                                  ],
                                )))
                            .toList()
                        : [Text("Son Hali")],
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                            .map((weakness) => Chip(
                                backgroundColor: Colors.orange.shade100,
                                elevation: 6,
                                label: Text(weakness)))
                            .toList()
                        : [Text("Son Hali")],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
