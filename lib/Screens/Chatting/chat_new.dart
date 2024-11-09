import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:hwarat/Core/API_Endpoint/APICallCenter.dart';
import 'package:hwarat/Core/APP/Utils.dart';
import 'package:hwarat/Core/APP/snackbar.dart';
import 'package:hwarat/Core/Models/DataModels.dart';

import '../../Core/AIKitchenWidgets/AKTextField.dart';
import '../../Core/APP/colors.dart';
import '../../Core/APP/config.dart';
import '../../Core/LoadingButton.dart';
import 'SharedWidgets/incomingMessage.dart';
import 'SharedWidgets/new_chatBubble.dart';
import 'chat_new_dataManager.dart';

class ChattingNew extends StatefulWidget {
  final String? title;
  final String? chatId;
  final String? modelId;

  const ChattingNew({super.key, this.title, this.chatId, this.modelId});

  @override
  State<ChattingNew> createState() => _ChattingNewState();
}

class _ChattingNewState extends State<ChattingNew> with WidgetsBindingObserver {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _sc = ScrollController();
  double tfHeight = 75;
  double bottomInset = 0.0;

  bool wasAtEdge = true;
  final ValueNotifier<bool> loadingButtonSend = ValueNotifier<bool>(false);


  bool firstMessage = true;





  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.platformDispatcher
        .view(id: 0)
        ?.viewInsets
        .bottom;
    bottomInset = value!;
    scrollToBottom();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_sc.hasClients) {
      scrollToBottom();
    }
  }

  void scrollToBottom() {
      if(!_sc.position.atEdge){
        _sc.animateTo(_sc.position.maxScrollExtent,duration: 100.milliseconds,curve: Curves.linear);
      }
  }

  void scrollListener() async {}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sc.removeListener(scrollListener);
    _sc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    SpecificChatDataController.instance.init(widget.chatId ?? "");
    super.initState();
    _sc.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      setUpPlaceHolderMessages();
    });
  }

  void setUpPlaceHolderMessages() {
    if (widget.chatId != null && widget.modelId != null) {
    } else {
      SpecificChatDataController.instance.newMessage.value =
          !SpecificChatDataController.instance.newMessage.value;
    }
  }

  Future<void> resetWidget() async {
    SpecificChatDataController.instance.initialized = false;
    await SpecificChatDataController.instance.init(widget.chatId ?? "");
    firstMessage = true;
    setState(() {});
  }

  void showOptions() async{
    await showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.3),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(45)
                ),
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          height: 50,
                          child: Text("صفحة الإعدادات",textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold,color: Colors.black54),),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: LoadingButton(
                            onPressed: () async {
                                await ApiCall.createThread();
                                SnackBarManager.addNewTextSnackBar(context, text: APP.threadID??"فارغ");
                            },
                            buttonText: "Generate new thread",
                            buttonStyle: Utils.getOptionsButtonStyle(context),),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: LoadingButton(
                            onPressed: () async {
                              DetailedAPIResponse res = await ApiCall.generateIBMToken();
                              if(res.overriddenResponseCode == 200){
                                SnackBarManager.addNewTextSnackBar(context, text: "IBM token generated correctly");
                              }
                            },
                            buttonText: "Generate new IBM token",
                            buttonStyle: Utils.getOptionsButtonStyle(context),),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SizedBox(
                          height: 25,
                          child: Text("الخوارزميات المتاحة",textAlign: TextAlign.center,style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold,color: MyColors.c3),),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: 300,
                        child: Material(
                          color: Colors.transparent,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 65.0),
                                child: RadioListTile(
                                    value: 1,
                                    title: Text("حوارات الافتراضي",style: Theme.of(context).textTheme.labelMedium,),
                                    groupValue: APP.selectedRadio,
                                    onChanged: (change) async {
                                      if(firstMessage == false){
                                        await resetWidget();
                                        setState((){
                                          APP.selectedRadio = change!;
                                        });
                                      }
                                      else{
                                        setState((){
                                          APP.selectedRadio = change!;
                                        });
                                      }
                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 65.0),
                                child: RadioListTile(
                                    value: 2,
                                    title: Text("Allam plus",style: Theme.of(context).textTheme.labelMedium,),
                                    groupValue: APP.selectedRadio,
                                    onChanged: (change) async {
                                      if(firstMessage == false){
                                        await resetWidget();
                                        setState((){
                                          APP.selectedRadio = change!;
                                        });
                                      }
                                      else{
                                        setState((){
                                          APP.selectedRadio = change!;
                                        });
                                      }
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }


  Future<void> hwaratDefaultManner() async {
    // final message = DetailedAPIResponse(overriddenResponseCode: 100);
    DetailedAPIResponse message = await ApiCall.createMessageForThread(_textController.text);

    if ( message.overriddenResponseCode == 200) {
      if (firstMessage) {
        firstMessage = false;
        SpecificChatDataController.instance.clearPlaceHolders();
      }

      scrollToBottom();

      setState(() {
        SpecificChatDataController.messages.add(
            NewChatBubble(
                text: _textController.text,
                user: true)
        );
        SpecificChatDataController.messages.add(
            Align(
              alignment: Alignment.centerLeft,
              child: IncomingMessage(
                functionNumber: 1,
                callback: (done) {
                  loadingButtonSend.value = false;
                  scrollToBottom();
                },
              ),
            )
        );
      });

      scrollToBottom();
    }
    else{
      SnackBarManager.addNewTextSnackBar(context, text: "حدث خطأ يرجى التأكد من الاتصال وإعادة الإرسال",duration: 2.seconds);
      loadingButtonSend.value = false;
    }

    _textController.clear();
  }

  Future<void> allamPlusDefaultManner() async {
    DetailedAPIResponse message = await ApiCall.createMessageForThread(_textController.text);

    if ( message.overriddenResponseCode == 200) {
      if (firstMessage) {
        firstMessage = false;
        SpecificChatDataController.instance.clearPlaceHolders();
      }

      scrollToBottom();

      setState(() {
        SpecificChatDataController.messages.add(
            NewChatBubble(
                text: _textController.text,
                user: true
            )
        );

        SpecificChatDataController.messages.add(
            Align(
              alignment: Alignment.centerLeft,
              child: IncomingMessage(
                functionNumber: 2,
                callback: (done) {
                  loadingButtonSend.value = false;
                  scrollToBottom();
                },
              ),
            )
        );
      });

      scrollToBottom();
    }
    else{
      SnackBarManager.addNewTextSnackBar(context, text: "حدث خطأ يرجى التأكد من الاتصال وإعادة الإرسال",duration: 2.seconds);
      loadingButtonSend.value = false;
    }

    _textController.clear();
  }


  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 58.9,
        backgroundColor: Colors.grey.withOpacity(0.3),
        centerTitle: true,
        title: Hero(
            tag: "name",
            child: GestureDetector(
              onTap: (){
                scrollToBottom();
                SnackBarManager.addNewTextSnackBar(context, text: APP.threadID??"فارغ");
              },
              onLongPress: () async {
                if(APP.threadID == null){
                  await ApiCall.createThread();
                  SnackBarManager.addNewTextSnackBar(context, text: APP.threadID??"فارغ");
                }
              },
              child: Text(
                widget.title ?? "حوارات",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )),
        leading: IconButton(icon: const Icon(Icons.menu),onPressed: showOptions,),
      ),
      body: Center(
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height,
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: APP.designSize.small.width,
              height: APP.designSize.small.height - 125,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 820,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                                ? MediaQuery.of(context).viewInsets.bottom + 10
                                : 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            Expanded(
                                child: ValueListenableBuilder(
                                    valueListenable: SpecificChatDataController
                                        .instance.newMessage,
                                    builder: (context, value, wid) {
                                      return ListView.builder(
                                          addAutomaticKeepAlives: true,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          controller: _sc,
                                          itemCount: SpecificChatDataController
                                              .messages.length,
                                          itemBuilder: (context, index) {
                                            return SpecificChatDataController
                                                .messages[index];
                                          });
                                    })),
                            const SizedBox(
                              height: 4,
                            ),
                            FittedBox(
                              fit: BoxFit.none,
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 200),
                                width: 400,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textDirection: material.TextDirection.ltr,
                                  children: [
                                    Flexible(
                                        child: TextFieldAK(
                                      //suffixIcon: IconButton(icon: const Icon(Icons.attach_file,size: 28,), onPressed: () {  },),
                                      hintString: 'Chatting'.tr(gender: 'hint'),
                                      highlight: false,
                                      textInputAction: TextInputAction.newline,
                                      textEditingController: _textController,
                                      onTap: () {
                                        wasAtEdge = _sc.offset ==
                                            _sc.position.maxScrollExtent;
                                      },
                                      onSubmitted: (s) {
                                        scrollToBottom();
                                      },
                                      onChanged: (text) {},
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: loadingButtonSend,
                                        builder: (context, value, vWidget) {
                                          return value
                                              ? const FittedBox(
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.only(
                                                        bottom: 16),
                                                    child: SizedBox(
                                                        width: 35,
                                                        height: 35,
                                                        child:
                                                            SizedBox(
                                                              width: 35,
                                                              height: 35,
                                                              child: AspectRatio(
                                                                aspectRatio: 1,
                                                                child: CircularProgressIndicator(),
                                                              ),
                                                            )),
                                                  ),
                                                )
                                              : FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 20),
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: LoadingButton(
                                                        onPressed: () async {
                                                          if (_textController.text.isNotEmpty && loadingButtonSend.value == false) {

                                                            loadingButtonSend
                                                                .value = true;

                                                            switch(APP.selectedRadio){
                                                              case 0:
                                                                await hwaratDefaultManner();
                                                                break;
                                                              case 1:
                                                                await hwaratDefaultManner();
                                                                break;
                                                              case 2:
                                                                await allamPlusDefaultManner();
                                                                break;
                                                              default:
                                                                await hwaratDefaultManner();
                                                            }
                                                          }
                                                        },
                                                        buttonIcon: const Directionality(
                                                                textDirection:
                                                                    material
                                                                        .TextDirection
                                                                        .ltr,
                                                                child: Icon(
                                                                  Icons.send,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 40,
                                                                )),
                                                        buttonStyle: Utils.getDefaultButtonStyle(context),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                        })
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
