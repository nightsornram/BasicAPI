import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แอพความรู้ฟิสิกส์"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              //var data = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return MyBox(
                    snapshot.data[index]["title"],
                    snapshot.data[index]["subtitle"],
                    snapshot.data[index]["image_url"],
                    snapshot.data[index]["details"],
                  );
                },
                itemCount: snapshot.data.length,
              );
            },
            future: getData(),
            //future:
            //DefaultAssetBundle.of(context).loadString('assets/data.json'),
          )),
    );
  }

  Widget MyBox(
      String title, String subtitle, String image_url, String details) {
    var v1 = title;
    var v2 = subtitle;
    var v3 = image_url;
    var v4 = details;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      //color: Colors.blue[50],
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.darken))
          //color: Colors.blue[50],
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 18,
          ),
          TextButton(
              onPressed: () {
                print("NextPage =>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              },
              child: Text("อ่านต่อ")),
        ],
      ),
    );
  }

  Future getData() async {
    //https://raw.githubusercontent.com/nightsornram/BasicAPI/main/data.json
    var url = Uri.https(
        "raw.githubusercontent.com", "/nightsornram/BasicAPI/main/data.json");
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
