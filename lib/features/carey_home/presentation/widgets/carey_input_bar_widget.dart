import 'package:carey/core/constants/config.dart';
import 'package:carey/core/constants/image_assets.dart';
import 'package:carey/core/theme/app_colors.dart';
import 'package:carey/core/widgets/buttons/td_button.dart';
import 'package:carey/core/widgets/buttons/td_progress_button.dart';
import 'package:carey/core/widgets/gap.dart';
import 'package:carey/features/carey_home/presentation/bloc/send_message_bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CareyInputBarWidget extends StatefulWidget {
  const CareyInputBarWidget(
      {super.key, required this.onSend, this.onAttachmentTap});

  final void Function(String msg) onSend;
  final GestureTapCallback? onAttachmentTap;

  @override
  State<CareyInputBarWidget> createState() => _CareyInputBarWidgetState();
}

class _CareyInputBarWidgetState extends State<CareyInputBarWidget> {
  final TextEditingController _messageController = TextEditingController();
  bool isMessageSending = false;

  Future<void> _sendMessage() async {
    print("_messageController.text.trim() : ");
    print(_messageController.text);

    if (_messageController.text.trim().isNotEmpty) {
      widget.onSend(_messageController.text.trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          const Gap(
            width: 8,
          ),
          TdButton(
            icon: attachment,
            onPressed: widget.onAttachmentTap,
          ),
          const Gap(
            width: 8,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor().grey120,
              ),
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0,
                        color: Colors.transparent), // Transparent border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0,
                        color: Colors.transparent), // Transparent when selected
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0,
                        color:
                            Colors.transparent), // Transparent for error state
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0,
                        color: Colors.transparent), // Transparent when disabled
                  ),
                ),
              ),
            ),
          ),
          const Gap(
            width: 8,
          ),
          BlocListener<SendMessageBloc, SendMessageState>(
              listener: (context, state) {
                setState(() {
                  print("STATE: $state");

                  if (state is SendMessageInProgress) {
                    isMessageSending = true;
                  } else {
                    isMessageSending = false;
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TdProgressButton(
                  icon: Icons.arrow_forward,
                  onPressed: _sendMessage,
                  isLoading: isMessageSending,
                ),
              )),
        ],
      ),
    );
  }
}
