import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MeetLocationSelector extends StatefulWidget {
  @override
  _MeetLocationSelectorState createState() => _MeetLocationSelectorState();
}

class _MeetLocationSelectorState extends State<MeetLocationSelector> {
  static const MODE_ADD = 0xF1;
  static const MODE_REMOVE = 0xF2;
  static const MODE_NONE = 0xF3;
  int _currentMode = MODE_NONE;

  Completer<NaverMapController> _controller = Completer();
  List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _controlPanel(),
        _naverMap(),
      ],
    );
  }

  _controlPanel() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 추가
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _currentMode = MODE_ADD),
              child: Container(
                decoration: BoxDecoration(
                    color:
                        _currentMode == MODE_ADD ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black)),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  '추가',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        _currentMode == MODE_ADD ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),

          // 삭제
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _currentMode = MODE_REMOVE),
              child: Container(
                decoration: BoxDecoration(
                    color: _currentMode == MODE_REMOVE
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.black)),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  '삭제',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _currentMode == MODE_REMOVE
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),

          // none
          GestureDetector(
            onTap: () => setState(() => _currentMode = MODE_NONE),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      _currentMode == MODE_NONE ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black)),
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.clear,
                color: _currentMode == MODE_NONE ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _naverMap() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          NaverMap(
            onMapCreated: _onMapCreated,
            onMapTap: _onMapTap,
            markers: _markers,
            initLocationTrackingMode: LocationTrackingMode.Follow,
          ),
        ],
      ),
    );
  }

  // ================== method ==========================

  void _onMapCreated(NaverMapController controller) {
    _controller.complete(controller);
  }

  void _onMapTap(LatLng latLng) {
    if (_currentMode == MODE_ADD) {
      _markers.add(Marker(
        markerId: DateTime.now().toIso8601String(),
        position: latLng,
        infoWindow: '테스트',
        onMarkerTab: _onMarkerTap,
      ));
      setState(() {});
    }
  }

  void _onMarkerTap(Marker? marker, Map<String, int?> iconSize) {
    if(marker == null) return;

    int pos = _markers.indexWhere((m) => m.markerId == marker.markerId);
    setState(() {
      _markers[pos].captionText = '선택됨';
    });
    if (_currentMode == MODE_REMOVE) {
      setState(() {
        _markers.removeWhere((m) => m.markerId == marker.markerId);
      });
    }
  }
}