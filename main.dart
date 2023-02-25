import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'data_model.dart';



main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: const Center(child: Text('Show Data on Table')),),
      body: HomePage(),
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool error = false, dataloaded = false;
  var result;

  @override
  void initState() {
    _getData();
    super.initState();
  }

    void _getData(){
      Future.delayed(Duration.zero,() async {
        var url = Uri.parse("http://192.168.100.100:8087/table/json.php?auth=kjgdkhdfldfguttedfgr");
        var response = await http.post(Uri.parse(url.toString()));
        if (response.statusCode == 200) {
            setState(() {
                result = json.decode(response.body);
                print(result);
                dataloaded = true;
            });
        }else{
          setState(() {
              error = true;
          });
        }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //..................................................
        body: Container(
            padding: const EdgeInsets.all(15),
            child:dataloaded
            ? datalist()
            : const Center(
              child:CircularProgressIndicator()
            ),
        )
        //..................................................
    );
  }


 Widget datalist(){
      if(result["error"] !=null){
        return Text(result["errmsg"]);
      }else{

        List<DataModel> namelist = List<DataModel>.from(result["data"].map((i){
              return DataModel.fromJSON1(i);
          }));

        return
        ListView(
          children: [
          Table(
            border: TableBorder.all(width:1, color:Colors.black45),
            children: namelist.map((dataModel){
              return TableRow(
                      children: [
                          TableCell(child: Padding(
                              padding: const EdgeInsets.all(5),
                              child:Text(dataModel.sn1)
                            )
                          ),
                          TableCell(child: Padding(
                              padding: const EdgeInsets.all(5),
                              child:Text(dataModel.name1)
                            )
                          ),
                          TableCell(child: Padding(
                              padding: const EdgeInsets.all(5),
                              child:Text(dataModel.address1)
                            )
                          ),
                          TableCell(child: Padding(
                              padding: const EdgeInsets.all(5),
                              child:Text(dataModel.latLng1)
                            )
                          ),
                                ]
                );
            }).toList(),
          ),
        ],
      );
    }
  }


}
