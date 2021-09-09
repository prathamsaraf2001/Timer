import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountDownTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => CountDownTimerPage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<CountDownTimerPage> {
  final _isHours = true;
  var _isStarted = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(0),
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onEnded: () {
      print('onEnded');
    },
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.grey.withOpacity(0.0),
      drawer: ClipRRect(
        borderRadius: new BorderRadius.only(
          topRight: const Radius.circular(30.0),
          bottomRight: const Radius.circular(30.0),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            alignment: Alignment.center,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  // ListTile(
                  //   leading: Image.asset(
                  //     "assets/icons/alarm.png",
                  //     scale: 2.7,
                  //   ),
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       "",
                  //     );
                  //   },
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.01,
                  // ),
                  // ListTile(
                  //   leading: Image.asset(
                  //     "assets/icons/worldclock.png",
                  //     scale: 2.6,
                  //   ),
                  //   onTap: () {
                  //     Navigator.pushNamed(
                  //       context,
                  //       "",
                  //     );
                  //   },
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.01,
                  // ),
                  ListTile(
                    leading: Image.asset(
                      "assets/icons/timer.png",
                      scale: 3,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/timer",
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  ListTile(
                    leading: Image.asset(
                      "assets/icons/stopwatch.png",
                      scale: 2.4,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/stopwatch",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: const Text('CountDown Sample'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Display stop watch time
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: IconButton(
                          icon: Image.asset("assets/icons/reset.png"),
                          // style: ElevatedButton.styleFrom(
                          //   primary: Colors.red,
                          //   onPrimary: Colors.white,
                          //   shape: const StadiumBorder(),
                          // ),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                            setState(() {
                              _isStarted = false;
                            });
                            // setState(() {
                            //   _isStarted = true;
                            // });
                          },
                          // child: const Text(
                          //   'Reset',
                          //   style: TextStyle(color: Colors.white),
                          // ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8),
                      //   child: Text(
                      //     value.toString(),
                      //     style: const TextStyle(
                      //         fontSize: 17,
                      //         fontFamily: 'Helvetica',
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ),

            /// Display every minute.
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 0),
            //   child: StreamBuilder<int>(
            //     stream: _stopWatchTimer.minuteTime,
            //     initialData: _stopWatchTimer.minuteTime.value,
            //     builder: (context, snap) {
            //       final value = snap.data;
            //       print('Listen every minute. $value');
            //       return Column(
            //         children: <Widget>[
            //           Padding(
            //               padding: const EdgeInsets.all(8),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   const Padding(
            //                     padding: EdgeInsets.symmetric(horizontal: 4),
            //                     child: Text(
            //                       'minute',
            //                       style: TextStyle(
            //                         fontSize: 17,
            //                         fontFamily: 'Helvetica',
            //                       ),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 4),
            //                     child: Text(
            //                       value.toString(),
            //                       style: const TextStyle(
            //                           fontSize: 30,
            //                           fontFamily: 'Helvetica',
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                   ),
            //                 ],
            //               )),
            //         ],
            //       );
            //     },
            //   ),
            // ),

            /// Display every second.
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 0),
            //   child: StreamBuilder<int>(
            //     stream: _stopWatchTimer.secondTime,
            //     initialData: _stopWatchTimer.secondTime.value,
            //     builder: (context, snap) {
            //       final value = snap.data;
            //       print('Listen every second. $value');
            //       return Column(
            //         children: <Widget>[
            //           Padding(
            //               padding: const EdgeInsets.all(8),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: <Widget>[
            //                   const Padding(
            //                     padding: EdgeInsets.symmetric(horizontal: 4),
            //                     child: Text(
            //                       'second',
            //                       style: TextStyle(
            //                         fontSize: 17,
            //                         fontFamily: 'Helvetica',
            //                       ),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 4),
            //                     child: Text(
            //                       value.toString(),
            //                       style: const TextStyle(
            //                         fontSize: 30,
            //                         fontFamily: 'Helvetica',
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               )),
            //         ],
            //       );
            //     },
            //   ),
            // ),

            /// Lap time.
            Container(
              height: 120,
              margin: const EdgeInsets.all(8),
              child: StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: _stopWatchTimer.records.value,
                builder: (context, snap) {
                  final value = snap.data!;
                  if (value.isEmpty) {
                    return Container();
                  }
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut);
                  });
                  print('Listen records. $value');
                  return ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final data = value[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${index + 1} ${data.displayTime}',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          )
                        ],
                      );
                    },
                    itemCount: value.length,
                  );
                },
              ),
            ),

            /// Button
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 90,

                    // highlightColor: Colors.transparent,
                    // hoverColor: Colors.transparent,
                    // color: Colors.white,
                    // autofocus: false,
                    // style: ElevatedButton.styleFrom(
                    //   primary:
                    //       _isStarted ? Colors.red : Colors.green,
                    //   shape: StadiumBorder(),
                    // ),
                    icon: Icon(
                      _isStarted
                          ? Icons.stop_circle_outlined
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),

                    // color: _isStarted
                    //   ? Colors.red
                    //   : Colors.green,
                    // shape: StadiumBorder(),
                    // child: Text(
                    //   _isStarted ? "Stop" : "Start",
                    //   style: TextStyle(
                    //       // Your style here
                    //       ),
                    // ),
                    onPressed: _isStarted
                        ? () async {
                            HapticFeedback.mediumImpact();
                            // _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                            setState(() {
                              _isStarted = false;
                            });
                          }
                        : () async {
                            HapticFeedback.mediumImpact();
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                            setState(() {
                              _isStarted = true;
                            });
                          },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 4),
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(15, 5, 0, 0)
                  //         .copyWith(right: 8),
                  //     child: IconButton(
                  //       icon: Image.asset("assets/icons/lap.png"),
                  //       // style: ElevatedButton.styleFrom(
                  //       //   primary: Colors.deepPurpleAccent,
                  //       //   onPrimary: Colors.white,
                  //       //   shape: const StadiumBorder(),
                  //       // ),
                  //       onPressed: () async {
                  //         _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                  //       },
                  //       // child: const Text(
                  //       //   'Lap',
                  //       //   style: TextStyle(color: Colors.white),
                  //       // ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "Hours",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  _stopWatchTimer.setPresetHoursTime(1);
                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  _stopWatchTimer.setPresetHoursTime(-1);
                                },
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "Minutes",
                              style: TextStyle(color: Colors.white),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () async {
                                _stopWatchTimer.setPresetMinuteTime(1);
                              },
                              child: const Text(
                                '+',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  _stopWatchTimer.setPresetMinuteTime(-1);
                                },
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "Seconds",
                              style: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  _stopWatchTimer.setPresetSecondTime(1);
                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  _stopWatchTimer.setPresetSecondTime(-1);
                                },
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 4),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Colors.pinkAccent,
                  //       onPrimary: Colors.white,
                  //       shape: const StadiumBorder(),
                  //     ),
                  //     onPressed: () async {
                  //       _stopWatchTimer.setPresetTime(mSec: 3599 * 1000);
                  //     },
                  //     child: const Text(
                  //       'Set PresetTime',
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        _stopWatchTimer.clearPresetTime();
                      },
                      child: const Text(
                        'Clear Preset Time',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
