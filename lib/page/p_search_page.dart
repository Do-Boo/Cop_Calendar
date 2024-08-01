import "dart:convert";
import "dart:io";
import "dart:ui" as ui;
import "package:events_app/widgets/w_button.dart";
import "package:events_app/widgets/w_round_widget.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

var theme;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isExpanded = false;
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
                  focusNode: _focusNode,
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
