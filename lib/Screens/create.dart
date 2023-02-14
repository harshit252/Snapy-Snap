import 'dart:convert';
import 'dart:io';
import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class CreateCapture extends StatefulWidget {
  const CreateCapture({Key? key}) : super(key: key);

  @override
  State<CreateCapture> createState() => _CreateCaptureState();
}

class _CreateCaptureState extends State<CreateCapture> {
  late final DeepArController _controller;
  String version = '';
  bool _isFaceMask = false;
  bool _isFilter = false;

  final List<String> _effectsList = [];
  final List<String> _maskList = [];
  final List<String> _filterList = [];
  int _effectIndex = 0;
  int _maskIndex = 0;
  int _filterIndex = 0;

  final String _assetEffectsPath = 'assets/';

  @override
  void initState() {
    _controller = DeepArController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _initEffects();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    _controller
        .initialize(
          androidLicenseKey:
              "d7a867203f719b0af5fc353ef0053112e41009ddb66aadc0936770d0b310de83af447a9034e06629",
          iosLicenseKey:
              "b1777c0a28a53a137b24d82b3f67fd38570b5ec8d0b5b6ea84b3d1c93dc833966026b6ba87fb313c",
          resolution: Resolution.veryHigh,
        )
        .then((value) => setState(() {}));
    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
            scale: (1 / _controller.aspectRatio) / deviceRatio,
            child: DeepArPreview(
              _controller,
              onViewCreated: () {
                // set any initial effect, filter etc
                // _controller
                //     .switchEffect(_assetEffectsPath + 'viking_helmet.deepar');
              },
            ),
          ),
          _topMediaOptions(),
          _bottomMediaOptions(),
        ],
      ),
    );
  }

  Positioned _topMediaOptions() {
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () async {
              await _controller.toggleFlash();
              setState(() {});
            },
            color: Colors.white70,
            iconSize: 30,
            icon:
                Icon(_controller.flashState ? Icons.flash_on : Icons.flash_off),
          ),
          IconButton(
            onPressed: () async {
              _isFaceMask = !_isFaceMask;
              if (_isFaceMask) {
                _controller.switchFaceMask(_maskList[_maskIndex]);
              } else {
                _controller.switchFaceMask("null");
              }
              setState(() {});
            },
            color: Colors.white70,
            iconSize: 40,
            icon: Icon(
              _isFaceMask
                  ? Icons.face_retouching_natural_rounded
                  : Icons.face_retouching_off,
            ),
          ),
          IconButton(
            onPressed: () async {
              _isFilter = !_isFilter;
              if (_isFilter) {
                _controller.switchFilter(_filterList[_filterIndex]);
              } else {
                _controller.switchFilter("null");
              }
              setState(() {});
            },
            color: Colors.white70,
            iconSize: 40,
            icon: Icon(
              _isFilter ? Icons.filter_hdr : Icons.filter_hdr_outlined,
            ),
          ),
          IconButton(
              onPressed: () {
                _controller.flipCamera();
              },
              iconSize: 30,
              color: Colors.white70,
              icon: const Icon(Icons.cameraswitch))
        ],
      ),
    );
  }

  // prev, record, screenshot, next
  // Sample option which can be performed
  Positioned _bottomMediaOptions() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                iconSize: 60,
                onPressed: () {
                  if (_isFaceMask) {
                    String prevMask = _getPrevMask();
                    _controller.switchFaceMask(prevMask);
                  } else if (_isFilter) {
                    String prevFilter = _getPrevFilter();
                    _controller.switchFilter(prevFilter);
                  } else {
                    String prevEffect = _getPrevEffect();
                    _controller.switchEffect(prevEffect);
                  }
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white70,
                )),
            IconButton(
                onPressed: () async {
                  if (_controller.isRecording) {
                    File? file = await _controller.stopVideoRecording();
                    OpenFile.open(file.path);
                  } else {
                    await _controller.startVideoRecording();
                  }
                  setState(() {});
                },
                iconSize: 50,
                color: Colors.white70,
                icon: Icon(_controller.isRecording
                    ? Icons.videocam_sharp
                    : Icons.videocam_outlined)),
            const SizedBox(width: 20),
            IconButton(
                onPressed: () {
                  try {
                    _controller.takeScreenshot().then((file) {
                      OpenFile.open(file.path);
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Photo Capture Failed',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                color: Colors.white70,
                iconSize: 40,
                icon: const Icon(Icons.photo_camera)),
            IconButton(
                iconSize: 60,
                onPressed: () {
                  if (_isFaceMask) {
                    String nextMask = _getNextMask();
                    _controller.switchFaceMask(nextMask);
                  } else if (_isFilter) {
                    String nextFilter = _getNextFilter();
                    _controller.switchFilter(nextFilter);
                  } else {
                    String nextEffect = _getNextEffect();
                    _controller.switchEffect(nextEffect);
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                )),
          ],
        ),
      ),
    );
  }

  void _initEffects() {
    // Either get all effects
    _getEffectsFromAssets(context).then((values) {
      _effectsList.clear();
      _effectsList.addAll(values);

      _maskList.clear();
      _maskList.add(_assetEffectsPath + 'flower_face.deepar');
      _maskList.add(_assetEffectsPath + 'viking_helmet.deepar');
      _filterList.clear();
      _filterList.add(_assetEffectsPath + 'burning_effect.deepar');
      _filterList.add(_assetEffectsPath + 'Hope.deepar');

      _effectsList.removeWhere((element) => _maskList.contains(element));

      _effectsList.removeWhere((element) => _filterList.contains(element));
    });

    // OR

    // Only add specific effects
    // _effectsList.add(_assetEffectsPath+'burning_effect.deepar');
    // _effectsList.add(_assetEffectsPath+'flower_face.deepar');
    // _effectsList.add(_assetEffectsPath+'Hope.deepar');
    // _effectsList.add(_assetEffectsPath+'viking_helmet.deepar');
  }

  /// Get all deepar effects from assets
  ///
  Future<List<String>> _getEffectsFromAssets(BuildContext context) async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final filePaths = manifestMap.keys
        .where((path) => path.startsWith(_assetEffectsPath))
        .toList();
    return filePaths;
  }

  String _getNextEffect() {
    _effectIndex < _effectsList.length ? _effectIndex++ : _effectIndex = 0;
    return _effectsList[_effectIndex];
  }

  /// Get previous effect
  String _getPrevEffect() {
    _effectIndex > 0 ? _effectIndex-- : _effectIndex = _effectsList.length;
    return _effectsList[_effectIndex];
  }

  /// Get next mask
  String _getNextMask() {
    _maskIndex < _maskList.length ? _maskIndex++ : _maskIndex = 0;
    return _maskList[_maskIndex];
  }

  /// Get previous mask
  String _getPrevMask() {
    _maskIndex > 0 ? _maskIndex-- : _maskIndex = _maskList.length;
    return _maskList[_maskIndex];
  }

  /// Get next filter
  String _getNextFilter() {
    _filterIndex < _filterList.length ? _filterIndex++ : _filterIndex = 0;
    return _filterList[_filterIndex];
  }

  /// Get previous filter
  String _getPrevFilter() {
    _filterIndex > 0 ? _filterIndex-- : _filterIndex = _filterList.length;
    return _filterList[_filterIndex];
  }
}
