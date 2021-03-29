import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main()
{
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future<String> getWeather() async
  {
    //"http://api.openweathermap.org/data/2.5/weather?q=Pabna&appid=3b9a0e5e60c2f30f6af54e84222bd83f"
    final pathParameters = {
      'q':'pabna','appid':'3b9a0e5e60c2f30f6af54e84222bd83f'
    };
     final uri = Uri.https("api.openweathermap.org", "/data/2.5/weather",pathParameters);

     final response = await http.get(uri);
      var results = jsonDecode(response.body);
      setState(() {
        this.temp = results['main']['temp'];
        this.description = results['weather'][0]['description'];
        this.currently =results['weather'][0]['main'];
        this.humidity = results[main]['humidity'];
        this.windSpeed = results['wind']['speed'];

        //print(temp);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.height,
            color: Colors.indigo,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Current In Dhaka",style: new TextStyle(fontSize: 14,color: Colors.white),),
                Text(temp!=null? temp.toString()+"\u00B0" :"Loading",style: new TextStyle(fontSize: 40,color: Colors.white),),
                Text("Rain",style: new TextStyle(fontSize: 14,color: Colors.white),),

              ],
            ),
          ),
          Expanded(
                child: Container(
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: ListView(

                      children: [

                        ListTile(
                          leading: Icon(Icons.device_thermostat),
                          title: Text("Temperature"),
                          trailing: Text("52\u00B0"),
                        ),

                        ListTile(
                          leading: Icon(Icons.cloud),
                          title: Text("Weather"),
                          trailing: Text("weather"),
                        ),

                        ListTile(
                          leading: Icon(Icons.wb_sunny),
                          title: Text("Humidity"),
                          trailing: Text("70"),
                        ),

                        ListTile(
                          leading: Icon(Icons.filter_drama_sharp),
                          title: Text("Wind Speed"),
                          trailing: Text("25"),
                        ),
                      ],
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }
}
