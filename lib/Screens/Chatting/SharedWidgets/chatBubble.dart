import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../../../Core/APP/colors.dart';
import '../../../Core/APP/snackbar.dart';




class ChatBubble extends StatefulWidget {
  final String text;
  final bool user;

  const ChatBubble({super.key, required this.text, required this.user});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: widget.text));
        if(mounted){
          SnackBarManager.addNewTextSnackBar(context, text: widget.text);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.c1,
                widget.user ? MyColors.c2 : Colors.purpleAccent[100]!
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                //Alignment.centerRight : Alignment.centerLeft
                bottomLeft:
                widget.user ? const Radius.circular(15) : Radius.zero,
                bottomRight:
                widget.user ? Radius.zero : const Radius.circular(15),
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
              )),
          padding: const EdgeInsets.all(15),
          constraints: const BoxConstraints(maxWidth: 270),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: TexMarkdown(
              widget.text,
              textScaler: const TextScaler.linear(0.9),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
