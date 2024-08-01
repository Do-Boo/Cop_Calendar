import "dart:convert";
import "dart:io";
import "dart:ui" as ui;
import "package:events_app/api/api_database_query.dart";
import "package:events_app/function/f_url_href.dart";
import "package:events_app/widgets/w_button.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_html/flutter_html.dart";
import "package:flutter_linkify/flutter_linkify.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:url_launcher/url_launcher.dart";

var theme;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SafeArea(child: _buildAppBar(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  alignment: Alignment.centerLeft,
                  height: 36,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        "공지",
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Button(
                          onPressed: () {},
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.2)),
                FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 300), () => fetchnotificationTableJsonData("1")),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
                      // return _BuildLodingWidget();
                      return const SizedBox();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      var items = snapshot.data as List<dynamic>;
                      return SizedBox(
                        height: items.length * 56,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Button(
                              onPressed: () {},
                              borderRadius: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                                height: 56,
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_right_rounded),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat('yyyy.MM.dd.(EE)', "ko_KR").format(DateTime.parse(items[index]["created_at"].toString())).toString(),
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 16),
                                            Text(items[index]["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        Linkify(
                                          text: '다운로드 링크: ${items[index]["content"]}',
                                          style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16),
                                          linkStyle: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                                          onOpen: (link) async {
                                            if (await canLaunchUrl(Uri.parse(link.url))) {
                                              await launchUrl(Uri.parse(link.url));
                                            } else {
                                              throw 'Could not launch ${link.url}';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  alignment: Alignment.centerLeft,
                  height: 36,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        "알림",
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Button(
                          onPressed: () {},
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 300), () => fetchnotificationTableJsonData("2")),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
                      // return _BuildLodingWidget();
                      return const SizedBox();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      var items = snapshot.data as List<dynamic>;
                      return SizedBox(
                        height: items.length * 56,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Button(
                              onPressed: () {},
                              borderRadius: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                                height: 56,
                                child: Row(
                                  children: [
                                    const Icon(Icons.arrow_right_rounded),
                                    const SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat('yyyy.MM.dd.(EE)', "ko_KR").format(DateTime.parse(items[index]["created_at"].toString())).toString(),
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 16),
                                            Text(items[index]["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                        Linkify(
                                          text: '다운로드 링크: ${items[index]["content"]}',
                                          style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16),
                                          linkStyle: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                                          onOpen: (link) async {
                                            if (await canLaunchUrl(Uri.parse(link.url))) {
                                              await launchUrl(Uri.parse(link.url));
                                            } else {
                                              throw 'Could not launch ${link.url}';
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).hintColor.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Button(
              child: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                HapticFeedback.lightImpact();
                Get.back();
              },
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: Text(
              "알림",
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
