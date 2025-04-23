import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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

  void _handleScaleEnd(ScaleEndDetails details) {
    // You can add inertia or other effects here if needed
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
        title: Text('Privacy policy', style: TextStyle(color: Colors.white)),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.black54,
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in, color: Colors.white),
            onPressed: _zoomIn,
          ),
          IconButton(
            icon: Icon(Icons.zoom_out, color: Colors.white),
            onPressed: _zoomOut,
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _resetZoom,
          ),
        ],
      ),
      body: GestureDetector(
        onScaleUpdate: _handleScaleUpdate,
        onScaleEnd: _handleScaleEnd,
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
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Kraph Tech',
                          style: GoogleFonts.b612Mono(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Privace Policy',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'At Kraph Tech we recognize that privacy is significant. This Privacy Policy applies to all apps (Android & IOS) under the publisher name of "Kraph Tech". We has created this Policy to explain our privacy practices so you can understand what information about you is collected, used and disclosed. We collect information from you in order to provide corresponding service and better user experience. With your',
                  ),
                  SizedBox(height: 40),
                  Text(
                    'INFORMATION WE COLLECT',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.stop, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Generally. We may collect personal information from our users in order to provide you with personalized, useful and efficient experience. The categories of information we collect can include: Social network\'s personal information and device\'s gallery pictures.',
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.stop, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Non-personal identification. We may collect non-personal identification information about installed applications, application usage information and device information. The information you give us, for example, when you give us your opinions to our application and services via our feedback channel, such as your email address and names.',
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'EU USER CONSENT POLICY',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'We include certain disclosures to users in the European Economic Area (EEA) & obtain their consent to use cookies or other local storage, where legally required, and to use personal data (such as AdID) to serve ads. This policy reflects the requirements of the EU ePrivacy Directive and the General Data Protection Regulation (GDPR)',
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        const TextSpan(
                          text:
                              'We ask about permission of users who are in the ',
                        ),
                        const TextSpan(
                          text: 'European Economic Area',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: ' to display ads like '),
                        const TextSpan(
                          text: 'PERSONALIZE/NON-PERSONALIZE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Learn about EU User Consent Policy:'),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.stop),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(
                            'https://www.google.com/about/company/user-consent-policy/',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'Learn about EU User Consent Policy',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    'PRIVACY POLICY OF THIRD PARTY SERVICE PROVIDERS USED BY THE APP',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information. The information that I request is retained on your device and is not collected by me in any way.',
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The app does use third party services that may collect information used to identify you.',
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.stop),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(
                            'https://policies.google.com/privacy',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'Google Play Services',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.stop),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(
                            'https://support.google.com/admob/answer/6128543?hl=en',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'Ad Mob',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.stop),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(
                            'https://firebase.google.com/policies/analytics',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          'Firebase Analytics',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'HOW WE USE COLLECTED INFORMATION',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'We may use your information only for serving you better as below:',
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.stop, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'To personalize user experience;',
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.stop, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'To help develop our service- We may use Non-Personal Information to provide, maintain, improve and develop our services;',
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.stop, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'We may collect your non-personal information and use them for market and promotion purpose, for example, we may promote or recommend more relevant apps to you.',
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'We use this information to operate, maintain, and provide to you the features and functionality of our Apps, as well as to communicate directly with you, such as to send you email messages and push notifications. We may also send you Service-related emails or messages (e.g., account verification, order confirmations, change or updates to features of our apps, of our apps, technical and security notices).',
                    softWrap: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'HOW YOUR INFORMATION MAY BE DISCLOSED',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.stop, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Personal Information. We do not store Personal Information and therefore we do not disclose your Personal Information.',
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.stop, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Non-Personal Information. We do not combine Non-Personal Information with Personal. Information (such as combining your name with your unique User Device number).',
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.stop, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'We may disclose your non-personal information for promotion purpose to our trusted partners who shall comply with this privacy policy and the relevant privacy laws.',
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'THIRD-PARTY SITES',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'In general, the Applications, the Services and the Site access third party information (such as your Facebook account information) through application interfaces. We may provide links to third-party Websites, such as Facebook, as a service to our Users. The The Site may also carry advertisements from other companies. When you click on links of third parties in an Application, the Services or the Site, you may leave the Application, the Services or the Site. Some of these third party sites may be co-branded with our name/logo or our affiliated entity"s name/logo, even though they are not operated or maintained by us. This Policy does not address, and we are not responsible for, the privacy practices of Web sites operated by third parties, whether they are linked to or otherwise accessible from an Application, the Services or the Site. The inclusion of a link or accessibility of third party Websites. does not imply endorsement of such third party Website by us',
                    softWrap: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'USERS WITH WHOM YOU SHARE YOUR INFORMATION',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We cannot control the actions of other Users with whom you share your information. We cannot, and do not control the information you share with other Users using an Application, the Services or the Site(including via Forums) or how such other Users will use or share such information. We are not responsible for third party circumvention of our security measures.',
                    softWrap: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'SECURITY',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We are very concerned about safe guarding the confidentiality of your information. We do not collect Personal Information, and we employ administrative, physical and electronic measures designed to protect your Non-Personal Information from unauthorized access and use. Please be aware that no security measures that we take to protect your information is absolutely guaranteed to avoid unauthorized accessor use of your Non-Personal Information which is impenetrable.',
                    softWrap: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'SENSITIVE INFORMATION',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We ask that you not send us, and you not to disclose, any sensitive Personal Information (e.g.information related to racial or ethnic origin, political opinions, religion or other beliefs, health, sexual orientation, criminal background or membership in past organizations, including trade union memberships) on or through an Application, the Services or the Site or otherwise to us.',
                    softWrap: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'LOCATION',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This clause applies to the Application that is using location permission in this developer account.',
                    softWrap: true,
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.stop, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Do not store location information on the server-side. It is used in applications locally.',
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.stop, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'if the Application asks the location permission, it uses core functionality in the Application like display location on Map, display Wifi name, location reminder, location alert, etc. (if applicable).',
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'CHANGES TO THIS PRIVACY POLICY',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Our Privacy Policy may change from time to time, we will post any privacy policy changes on this so please review it periodically. We may provide you additional forms of notice of modifications opage, you updates as appropriate under the circumstances.',
                    softWrap: true,
                  ),
                  Text(
                    'this Policy, your sole recourse is to immediately stop all use if you do not agree to any modifications to this Pol of all Applications, the Services and the Site. Your continued use of any Application, the Services or the Site following the posting of any modifications to this Policy will constitute your acceptance of the revised Policy. Please note that none of our employees or agents has the authority to vary any of our Policies.',
                    softWrap: true,
                  ),

                  SizedBox(height: 20),
                  const Divider(color: Colors.black, thickness: 1),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Thank You',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
