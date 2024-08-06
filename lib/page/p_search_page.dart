import "package:events_app/api/api_database_query.dart";
import "package:events_app/widgets/w_button.dart";
import "package:events_app/widgets/w_custom_dialog.dart";
import "package:events_app/widgets/w_round_widget.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

var theme;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isExpanded = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isExpanded = true;
        FocusScope.of(context).requestFocus(_focusNode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56), // 원하는 높이로 설정
        child: SafeArea(child: _buildAppBar(context)),
      ),
      body: const SafeArea(child: SizedBox()),
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isExpanded)
            SizedBox(
              height: 40,
              width: 40,
              child: Button(
                child: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  setState(() => isExpanded = false);
                  _focusNode.unfocus();
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Get.back();
                  });
                },
              ),
            )
          else
            const SizedBox(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            width: isExpanded ? MediaQuery.of(context).size.width - 72 : 40,
            height: 40,
            child: Stack(
              children: [
                SizedBox(
                  child: RoundWidget(
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(2),
                    borderRadius: BorderRadius.circular(27),
                    color: Theme.of(context).hintColor.withOpacity(isExpanded ? 0.2 : 0),
                  ),
                ),
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onSubmitted: (text) async {
                    if (text.isEmpty) {
                      FocusScope.of(context).requestFocus(_focusNode);
                      return;
                    } else if (text.replaceAll(" ", "") == "오늘의식단") {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.2),
                        builder: (context) {
                          return CustomDialogWidget(
                            child: FutureBuilder(
                              future: fetchRestaurantJsonData(DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var items = snapshot.data as List<dynamic>;
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text("점심"),
                                        Text(items[0]["menu"].toString().split("|")[0]),
                                        const Text(""),
                                        const Text("저녁"),
                                        Text(items[0]["menu"].toString().split("|")[1]),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      setState(() => isExpanded = false);
                      _focusNode.unfocus();
                      Future.delayed(const Duration(milliseconds: 150), () {
                        Get.back();
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: isExpanded ? "검색어를 입력하세요" : "",
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                isExpanded ? const SizedBox() : const SizedBox(height: 40, width: 40, child: Icon(CupertinoIcons.search)),
              ],
            ),
          ),
          AnimatedContainer(
            width: isExpanded ? 0 : 54,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
