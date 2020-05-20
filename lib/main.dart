import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' ;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),),);
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    getLocation();
    
    super.initState();
  }

  
  var latitude;
  var longitude;
  var desc;
  var nameplace;
  var temperatures;
  var humid;
  void getLocation()async{
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.bestForNavigation); 
    var l1 = position.longitude;
    var l2 = position.latitude; 
    print(l1);
    print(l2);
    Response response = await get("http://api.openweathermap.org/data/2.5/weather?lat=$l2&lon=$l1&appid=4f5288c191f6902c28111af8add446a7&units=metric");
    String data = response.body;
    var descrip = jsonDecode(data)["weather"][0]["description"].toString();
    var temperature = jsonDecode(data)["main"]["temp"].toString();
    var placeName = jsonDecode(data)["name"].toString();
    var humidity = jsonDecode(data)["main"]["humidity"].toString();
    print(humidity);
    print(placeName);
    print("$temperature");
    print(descrip);
   setState(() {
    longitude = l1;
    humid = humidity;
     latitude = l2;
     desc = descrip;
     nameplace = placeName;
     temperatures = temperature;
   });
  }

  
  
 

  @override
  Widget build(BuildContext context) {
    
    return 
           Scaffold(
          
          body: Column(children: <Widget>[
            Stack(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height, //800.7,
                width: MediaQuery.of(context).size.width ,//500,
                child: PageView(
                scrollDirection: Axis.vertical,
                    children: [
                    Image.network("https://cdn.dribbble.com/users/648922/screenshots/6887377/attachments/1466540/1_cloudy_1125_2436_wallpaper.jpg",color: Color.fromRGBO(255, 255, 255, 0.5),
  colorBlendMode: BlendMode.modulate,fit: BoxFit.fill,),
                    Image.network("https://cdn.dribbble.com/users/648922/screenshots/6887377/attachments/1466541/2_sunny_1125_2436_wallpaper.jpg",color: Color.fromRGBO(255, 255, 255, 0.5),
  colorBlendMode: BlendMode.modulate,fit: BoxFit.fill,),
                    Image.network("https://cdn.dribbble.com/users/648922/screenshots/6887377/attachments/1466542/3_night_1125_2436_wallpaper.jpg",color: Color.fromRGBO(255, 255, 255, 0.5),
  colorBlendMode: BlendMode.modulate,fit: BoxFit.fill,),
                  ]),),
                Padding(
                  padding: const EdgeInsets.only(top:100 ),
                  child: Center(child: Icon(Icons.navigation,color: Colors.black54,size:40)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(child: Text("$nameplace",style: TextStyle(fontSize: 40,color: Colors.black54),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Center(child: Text("$temperatures C",style: TextStyle(fontSize: 100,color: Colors.black),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 400),
                    child: Center(child: Text("$desc",style: TextStyle(fontSize: 30,color: Colors.black54,letterSpacing: 3,fontWeight: FontWeight.bold),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 320,left: 160),
                    child: Center(
                      child: Row(children: <Widget>[
                        Container(
                          height: 40,width: 40,
                          child: Image.network("https://cdn1.iconfinder.com/data/icons/weather-forecast-31/650/water-humidity-precipitation-512.png")),
                        Text("$humid",style: TextStyle(fontSize: 30,color: Colors.black54))
                      ],),
                    ),
                  ),
            ],)
          ],)
        
    );
  }
}


