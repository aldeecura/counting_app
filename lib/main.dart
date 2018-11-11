import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

const appId = 'ca-app-pub-1359002954768604~4610083333';
//const testAdUnitId = 'ca-app-pub-1359002954768604/2004101291';


MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
  keywords: <String>['numbers', 'counting','flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: new DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.unknown, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = new BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-1359002954768604/2004101291", //BannerAd.testAdUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = new InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: "ca-app-pub-1359002954768604/1209183934", //InterstitialAd.testAdUnitId,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);


void main() => runApp(Count());


class Count extends StatefulWidget {
  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {

  FirebaseAnalytics analytics = new FirebaseAnalytics();


  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: appId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Counting Number App'),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics),],
      title: 'Counting App',
      theme: ThemeData(primarySwatch: Colors.green),
      builder: (BuildContext context, Widget child) {

        return new Padding( child: child, padding: const EdgeInsets.only(bottom: 50.0,));
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    myBanner
    // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'COUNT',
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 40.0),
            ),
          ],
        ),
      ),

      floatingActionButton: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
          ),
          new FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: new Icon(Icons.remove),
          ),
          new Padding(
            padding: new EdgeInsets.symmetric(
              horizontal: 100.0,
            ),
          ),
          new FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}