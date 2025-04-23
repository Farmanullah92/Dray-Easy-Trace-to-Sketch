import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LicenseAndCredits extends StatefulWidget {
  const LicenseAndCredits({super.key});

  @override
  State<LicenseAndCredits> createState() => _LicenseAndCreditsState();
}

class _LicenseAndCreditsState extends State<LicenseAndCredits> {
  double _currentScale = 1.0;
  final double _minScale = 1.0;
  final double _maxScale = 3.0;

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _currentScale = (_currentScale * details.scale).clamp(
        _minScale,
        _maxScale,
      );
    });
  }

  void _zoomIn() {
    setState(() {
      _currentScale = (_currentScale + 0.1).clamp(_minScale, _maxScale);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentScale = (_currentScale - 0.1).clamp(_minScale, _maxScale);
    });
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'License & Credits',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black54,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomIn',
            mini: true,
            onPressed: _zoomIn,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'zoomOut',
            mini: true,
            onPressed: _zoomOut,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'resetZoom',
            mini: true,
            onPressed: _resetZoom,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: GestureDetector(
        onScaleUpdate: _handleScaleUpdate,
        child: Transform.scale(
          scale: _currentScale,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'License & Credits',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Copyright 2011 The Android Open Source Project'),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensed under the Apache License, Version 2.0 (the "License"), you may not use this file except in compliance with the License. You may obtain a copy of the License at',
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                        'http://www.apache.org/licenses/LICENSE-2.0',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text(
                      'http://www.apache.org/licenses/LICENSE-2.0',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \'AS IS\' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.',
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Json',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Copyright 2008-2014 Google Inc.'),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensed under the Apache License, Version 2.0 (the "License"), you may not use this file except in compliance with the License. You may obtain a copy of the License at',
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                        'http://www.apache.org/licenses/LICENSE-2.0',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text(
                      'http://www.apache.org/licenses/LICENSE-2.0',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \'AS IS\' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.',
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'OkHttp',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Copyright 2013 Square, Inc.'),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensed under the Apache License, Version 2.0 (the "License"), you may not use this file except in compliance with the License. You may obtain a copy of the License at',
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                        'http://www.apache.org/licenses/LICENSE-2.0',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text(
                      'http://www.apache.org/licenses/LICENSE-2.0',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \'AS IS\' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.',
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Retrofit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Copyright 2013 Square Inc.'),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensed under the Apache License, Version 2.0 (the "License"), you may not use this file except in compliance with the License. You may obtain a copy of the License at',
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                        'http://www.apache.org/licenses/LICENSE-2.0',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text(
                      'http://www.apache.org/licenses/LICENSE-2.0',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \'AS IS\' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.',
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Lottie',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Copyright (c) 2017 Airbnb'),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensed under the Apache License, Version 2.0 (the "License") you may not use this file except in compliance with the License. You may obtain a copy of the License at',
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                        'http://www.apache.org/licenses/LICENSE-2.0',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text(
                      'http://www.apache.org/licenses/LICENSE-2.0',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \'AS IS\' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.',
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'GPUImage for Android',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Copyright 2018 CyberAgent, Inc.'),
                  const SizedBox(height: 10),
                  const Text(
                    'Licensed under the Apache License, Version 2.0 (the "License"), you may not use this file except in compliance with the License. You may obtain a copy of the License at',
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(
                        'http://www.apache.org/licenses/LICENSE-2.0',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text(
                      'http://www.apache.org/licenses/LICENSE-2.0',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \'AS IS\' BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.',
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'CameraView',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Copyright (c) 2017 Oulab Studios'),
                  const SizedBox(height: 10),
                  const Text(
                    'Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:',
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.',
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'THE SOFTWARE IS PROVIDED \'AS IS\', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.',
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Icons',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Icon made by Freepik from www.flaticon.com'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse('https://www.flaticon.com/');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: const Text(
                          'Flat Icon',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
