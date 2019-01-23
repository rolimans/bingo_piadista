import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class PiadasFetcher{
  PiadasFetcher(){
    _getOnline();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/piadas.json');
  }

  Future<String> get readData async{
      try{
        final file = await _localFile;
        String body = await file.readAsString();
        return body;
      } catch (e){
        if(e!=null){
          print("Got Old");
          return _getAsset();
        }
      }
  }

  Future<File> _writeData(String data) async{
    final file = await _localFile;

    return file.writeAsString("$data");
  }

  Future<String> _getAsset() async{
    try {
      final asset = await rootBundle.loadString('assets/piadas.json');
      return asset;
    } catch (e){
      print("FATAL ERROR");
    }
  }

  void _getOnline() async {
    try {
      await http.get('https://kalidata.app/bingo').then((val) {
        if (val.statusCode == 200){
          _writeData(val.body);
        }
      });
    } catch(e){print("SEM NET");}
  }
}