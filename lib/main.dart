import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Counter counter = Counter();
  await counter.loadUserData(); // Ensure user data is loaded before fetching weather data
  await counter.fetchData();

  runApp(
      ChangeNotifierProvider(
        create: (context) => counter,
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'The Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    debugShowCheckedModeBanner: false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome, ${counter.name}!'
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: counter.selectedIndex,
          unselectedItemColor: Colors.green[100],
          selectedItemColor: Colors.green[600],
          onTap: (currentIndex) {
            counter.nav(context, currentIndex);
          }
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.green, // Change background color of this row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on), // Location icon
                  Text(
                    ' ${counter.homeLocation}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.yellow, // Change background color of this row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https:${counter.image}',
                    width: 64,
                    height: 64,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.orange, // Change background color of this row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.thermometer,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Sunrise',
                  ),
                  Text(
                    'Temperature: ${counter.temperature != null ? counter.temperature! : 'Loading...'} °C', // Fetch temperature later
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.purple, // Change background color of this row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.man,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Sunrise',
                  ),
                  Text(
                    'Feels Like: ${counter.feelslike != null ? counter.feelslike! : 'Loading...'}', // Fetch feels like temperature later
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ), // Feels like temperature fetched later
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.teal, // Change background color of this row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    counter.conditionText != null ? counter.conditionText! : 'Loading...', // Fetch weather condition later
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  // Weather condition fetched later
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey, // Change background color of this row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.drop,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Sunrise',
                  ),
                  Text(
                    'Humidity: ${counter.humidity != null ? counter.humidity! : 'Loading...'}', // Fetch humidity later
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.cloud_drizzle,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Sunrise',
                  ),
                  Text(
                    '${counter.raininmm != null ? counter.raininmm! : 'Loading...'} mm', // Fetch precipitation later
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.brown, // Change background color of this row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.sunrise,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Sunrise',
                  ),
                  Text(
                    counter.sunrise != null ? counter.sunrise! : 'Loading...', // Fetch sunset later
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.wind,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Sunrise',
                  ),
                  Text(
                    '${counter.windspeed != null ? counter.windspeed! : 'Loading...'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.sunset_fill,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Sunset',
                  ),
                  Text(
                    counter.sunset != null ? counter.sunset! : 'Loading...', // Fetch sunrise later
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
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




