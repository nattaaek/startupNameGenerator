import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup name generator',
      theme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.blueAccent
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => RandomWordsState();

}

class RandomWordsState extends State<RandomWords> {
  final _suggestion = <WordPair>[];

  final _save = Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);
  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        final title = _save.map(
            (pair) {
              return ListTile(
                title: Text(pair.asPascalCase,
                style: _biggerFont,
                ),
              );
            }
        );
        final divied = ListTile.divideTiles(tiles: title,
            context: context).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(
            ('your favortite'),
            ),
          ),
          body: ListView(children: divied,),
        );
      }
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup name generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
        ],
      ),
      body: _buildSuggestion(),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _save.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _save.remove(pair);
          }else{
            _save.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i){
      if(i.isOdd) return Divider();

      final index = i ~/ 2;

      if(index >= _suggestion.length){
        _suggestion.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestion[index]);
    }
    );


  }

}