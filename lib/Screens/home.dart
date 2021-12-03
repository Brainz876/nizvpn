// @dart=2.9

import 'package:flutter/material.dart';
import 'package:safebrowse/Screens/settings.dart';
import 'package:safebrowse/Theme/theme.dart';
import 'package:safebrowse/core/models/dnsConfig.dart';
import 'package:safebrowse/core/models/vpnConfig.dart';
import 'package:safebrowse/core/utils/nizvpn_engine.dart';
import 'package:flutter/services.dart' show rootBundle;

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _vpnState = NizVpn.vpnDisconnected;
  List<VpnConfig> _listVpn = [];
  VpnConfig _selectedVpn;
  Color _color = Colors.grey.withOpacity(0.4);
  bool _icons = false;
  int val = -1;
  int selectedIndex;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    ///Add listener to update vpnstate
    NizVpn.vpnStageSnapshot().listen((event) {
      setState(() {
        _vpnState = event;
      });
    });

    ///Call initVpn
    initVpn();
  }

  onServerTap(index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  void initVpn() async {
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/us.ovpn"),
        name: "USA",
        username: "vpnbook",
        password: "8shx95n",
        flag: "icons/flags/png/us.png"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/fr.ovpn"),
        name: "France",
        username: "vpnbook",
        password: "e9s5w7s",
        flag: "icons/flags/png/fr.png"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/ca.ovpn"),
        name: "Canada",
        username: "vpnbook",
        password: "8shx95n",
        flag: "icons/flags/png/ca.png"));
    _listVpn.add(VpnConfig(
        config: await rootBundle.loadString("assets/vpn/pl.ovpn"),
        name: "Poland",
        username: "vpnbook",
        password: "8shx95n",
        flag: "icons/flags/png/pl.png"));
    if (mounted)
      setState(() {
        _selectedVpn = _listVpn.first;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('SafeBrowse',
            style: TextStyle(
              color: CustomTheme.primary,
            )),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              iconSize: 32,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              })
        ],
        iconTheme: IconThemeData(
          color: CustomTheme.primary,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(3),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              child: Text(
                _vpnState == NizVpn.vpnDisconnected
                    ? "Disconnected"
                    : _vpnState.replaceAll("_", " ").toUpperCase(),
                style: TextStyle(fontSize: 16, color: Color(0xFF00A6A6)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _color = _color == CustomTheme.primary.withOpacity(0.4)
                  ? Colors.grey.withOpacity(0.4)
                  : CustomTheme.primary.withOpacity(0.4);
            });
          },
          child: Icon(
            _icons == false ? Icons.check : Icons.close,
            color: Colors.white,
            size: 50,
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(90),
            shape: CircleBorder(),
            primary: _color,
            shadowColor: Colors.white,
            // side: BordxerSide(color: Colors.white)
          ),
        ),
        SizedBox(
          height: 50,
        ),
        ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
              backgroundColor: MaterialStateProperty.all(CustomTheme.primary)),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15),
              child: Text(
                _vpnState == NizVpn.vpnDisconnected
                    ? "Connect Now!"
                    : "Disconnect",
                style: TextStyle(fontSize: 18.0),
              )),
          onPressed: () {
            _connectClick();

            setState(() {
              _color = _color == CustomTheme.primary.withOpacity(0.4)
                  ? Colors.grey.withOpacity(0.4)
                  : Colors.green;

              _icons = _icons == false ? true : false;
            });
          },
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: MaterialButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              "Pick Your Server",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _listVpn.length,
                            itemBuilder: (context, int index) {
                              return ListTile(
                                  onTap: () {
                                    onServerTap(index);
                                    if (_selectedVpn == _listVpn[index]) return;
                                    print(
                                        "${_listVpn[index].name} is selected");
                                    // NizVpn.stopVpn;
                                    setState(() {
                                      _selectedVpn = _listVpn[index];
                                    });
                                  },
                                  trailing: Icon(
                                    selectedIndex == index
                                        ? Icons.check_circle
                                        : Icons.panorama_fish_eye,
                                    color: selectedIndex == index
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                  ),
                                  title: Text(_listVpn[index].name),
                                  leading: Image.asset(_listVpn[index].flag,
                                      package: 'country_icons', scale: 3));
                            },
                          )
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //     radius: 12.0,
                  //     backgroundImage: AssetImage(
                  //       _listVpn[selectedIndex].flag,
                  //       package: 'country_icons',
                  //     )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('VPN LIST'),
                  ),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  void _connectClick() {
    ///Stop right here if user not select a vpn
    if (_selectedVpn == null) return;

    if (_vpnState == NizVpn.vpnDisconnected) {
      ///Start if stage is disconnected
      NizVpn.startVpn(
        _selectedVpn,
        dns: DnsConfig("23.253.163.53", "198.101.242.72"),
      );
    } else {
      ///Stop if stage is "not" disconnected
      NizVpn.stopVpn();
    }
  }
}
