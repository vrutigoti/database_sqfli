import 'package:database_sqfli/main.dart';
import 'package:flutter/material.dart';

class view_contact extends StatefulWidget {
  const view_contact({super.key});

  @override
  State<view_contact> createState() => _view_contactState();

}

class _view_contactState extends State<view_contact> {
  List<Map> l=[];
  get_data() async {
    String qry = "select * from contact_book";
    l = await first.database!.rawQuery(qry);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("View Contact"),),
    body: FutureBuilder(future: get_data(),builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done){
        return ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${l[index]['name']}",),
            subtitle: Text("${l[index]['contact']}"),
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {
                  String qry="delete from contact_book where id=${l[index]}";
                  first.database!.rawInsert(qry);
                  setState(() {
                  });
                }, icon: Icon(Icons.delete)),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return first(l[index]);
                  },));
                }, icon: Icon(Icons.edit))
              ],
            ),
          );
        },);
      }
      else{
            return CircularProgressIndicator();
      }
    }

   ) ,
    );
  }
}
