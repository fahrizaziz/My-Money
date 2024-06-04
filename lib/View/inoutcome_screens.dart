import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:mymoney/Model/Utils/strings.dart';
import 'package:mymoney/Model/inoutcome_model.dart';
import 'package:mymoney/ViewModel/history_providers.dart';
import 'package:provider/provider.dart';

import '../Model/Utils/colors.dart';
import '../Model/Utils/format.dart';

class InOutComeScreens extends StatefulWidget {
  final String type;
  const InOutComeScreens({required this.type, super.key});

  @override
  State<InOutComeScreens> createState() => _InOutComeScreensState();
}

class _InOutComeScreensState extends State<InOutComeScreens> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<HistoryProviders>().getInOutCome(
          context: context,
          type: widget.type,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              widget.type,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.all(16),
                child: TextField(
                  // controller: controllerSearch,
                  onTap: () async {
                    // DateTime? result = await showDatePicker(
                    //   context: context,
                    //   initialDate: DateTime.now(),
                    //   firstDate: DateTime(2022, 01, 01),
                    //   lastDate: DateTime(DateTime.now().year + 1),
                    // );
                    // if (result != null) {
                    //   controllerSearch.text =
                    //       DateFormat('yyyy-MM-dd').format(result);
                    // }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: CustomColor.chart.withOpacity(0.5),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // cInOut.search(
                        //   cUser.data.idUser,
                        //   widget.type,
                        //   controllerSearch.text,
                        // );
                      },
                      icon: const Icon(Icons.search, color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    hintText: '2022-06-01',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Consumer<HistoryProviders>(
        builder: (context, value, child) {
          return value.history.isEmpty
              ? Center(
                  child: DView.loadingCircle(),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _scrollController,
                  itemCount: value.history.length,
                  itemBuilder: (context, index) {
                    var history = value.history[index];
                    if (index < value.history.length) {
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.fromLTRB(
                          16,
                          index == 0 ? 16 : 8,
                          16,
                          index == value.history.length - 1 ? 16 : 8,
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(
                            4,
                          ),
                          child: Row(
                            children: [
                              DView.width(),
                              Text(
                                Format.date(
                                  history.date!,
                                ),
                                style: const TextStyle(
                                  color: CustomColor.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  Format.currency(
                                    history.total!,
                                  ),
                                  style: const TextStyle(
                                    color: CustomColor.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'update',
                                    child: Text(
                                      Strings.popUpdate,
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text(
                                      Strings.popDelete,
                                    ),
                                  )
                                ],
                                onSelected: (value) => menuOption(
                                  value,
                                  history,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      const SizedBox();
                    }
                  },
                );
        },
      ),
    );
  }

  menuOption(String value, InOutComeModel history) async {
    if (value == 'update') {
      print('Update');
    } else if (value == 'delete') {
      print('Delete');
    }
  }
}
