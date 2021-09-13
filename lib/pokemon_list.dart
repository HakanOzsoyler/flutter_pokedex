import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokemon_detail.dart';
import 'package:http/http.dart' as http;

import 'model/pokedex.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Future<Pokedex> veri;
  Pokedex pokedex;
  Future<Pokedex> pokemonlariGetir() async {
    var respose = await http.get(url);
    var decodedJson = jsonDecode(respose.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder(
              future: veri,
              builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.count(
                      crossAxisCount: 2,
                      children: snapshot.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonDetail(
                                          pokemon: poke,
                                        )));
                          },
                          child: Hero(
                            tag: poke.name,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    child: FadeInImage.assetNetwork(
                                        fadeInDuration: Duration(seconds: 1),
                                        fadeInCurve: Curves.bounceInOut,
                                        placeholder: 'assets/loading4.gif',
                                        image: ''
                                        // 'https://www.serebii.net/pokemongo/pokemon/003.png',
                                        ),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList());
                } else {
                  return Center(child: Text("Hata !!! verilere ulaşılamıyor"));
                }
              },
            );
          } else {
            return FutureBuilder(
              future: veri,
              builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.extent(
                      maxCrossAxisExtent: 300,
                      children: snapshot.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonDetail(
                                          pokemon: poke,
                                        )));
                          },
                          child: Hero(
                            tag: poke.name,
                            child: Card(
                              elevation: 6,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    child: FadeInImage.assetNetwork(
                                      fadeInDuration: Duration(seconds: 1),
                                      fadeInCurve: Curves.bounceInOut,
                                      placeholder: 'assets/loading4.gif',
                                      image:
                                          'https://img.pokemondb.net/sprites/bank/normal/${poke.name.toLowerCase()}.png',
                                      // 'https://www.serebii.net/pokemongo/pokemon/003.png',
                                    ),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList());
                } else {
                  return Center(child: Text("Hata !!! verilere ulaşılamıyor"));
                }
              },
            );
          }
        },
      ),
    );
  }
}
