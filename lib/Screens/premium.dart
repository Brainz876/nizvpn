// @dart=2.9
import 'package:flutter/material.dart';

class Premium extends StatefulWidget {
  const Premium({Key key}) : super(key: key);

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/premium.png'),
              fit: BoxFit.contain,
              height: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Premium",
              style: TextStyle(fontSize: 28),
            ),
            Card(
              child: ListTile(
                title: Text("1 Month"),
                subtitle: Text("All Features"),
                trailing: ElevatedButton(
                  child: Text("20.00"),
                  onPressed: () {},
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("6 Month"),
                subtitle: Text("All Features"),
                trailing: ElevatedButton(
                  child: Text("40.00"),
                  onPressed: () {},
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("12 Month"),
                subtitle: Text("All Features"),
                trailing: ElevatedButton(
                  child: Text("60.00"),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
