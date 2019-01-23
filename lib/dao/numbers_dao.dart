import '../util/piadas_fetcher.dart';
import '../model/number.dart';
import 'dart:convert';
class NumbersDAO{
  PiadasFetcher fetcher = new PiadasFetcher();

  Future<List<Number>> get_numbers(int len) async{
    try{
      Map<String, dynamic> json = jsonDecode(await fetcher.readData);
      List<Number> nums = new List(len);
      for(int i = 0; i<len; i++){
        String txt, desc;
        var js = json[(i+1).toString()];
        if(js!=null){
          txt = js['txt'];
          desc = js['desc'];
        }
        nums[i] = new Number(i+1, txt, desc);
      }
      nums.shuffle();
      return nums;
    } catch(e){
      print(e);
    }
  }
}