import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class MessageField extends StatelessWidget {
  final TextEditingController messageController;
  final GlobalKey<FormState> formKey;
  final Function(String)? onChanged;
  final FocusNode _focusNode;
  final ValueNotifier<bool> _isButtonVisible;
  final VoidCallback? sendTap;
  final VoidCallback? stickerTap;

  const MessageField({
    required this.messageController,
    required this.formKey,
    required this.onChanged,
    required FocusNode focusNode,
    required ValueNotifier<bool> isButtonVisible,
    this.sendTap,
    this.stickerTap,
    super.key,
  })  : _focusNode = focusNode,
        _isButtonVisible = isButtonVisible;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 60,
        color: const Color(0xFFF2F3F4),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: _focusNode.hasFocus ? 300 : 350,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: _focusNode.hasFocus
                    ? Colors.transparent
                    : const Color(0xFFDEE0E3),
                border: Border.all(
                  color: _focusNode.hasFocus
                      ? Colors.blue
                      : const Color(0xFFDEE0E3),
                ),
              ),
              child: TextFormField(
                focusNode: _focusNode,
                controller: messageController,
                inputFormatters: [NoLeadingWhitespaceFormatter()],
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: customTheme['mainTextSecondaryColor'],
                ),
                decoration: InputDecoration(
                  hintText: 'Enter message',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: customTheme['secondaryTextColor'],
                  ),
                  prefixIcon: InkWell(
                    onTap: stickerTap,
                    child: const Icon(
                      Iconsax.sticker,
                    ),
                  ),
                  prefixIconColor: customTheme['secondaryTextColor'],
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  if (onChanged == null) return;
                  onChanged!.call(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a text";
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isButtonVisible,
              builder: (context, isVisible, child) {
                return isVisible
                    ? InkWell(
                        onTap: sendTap,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: customTheme['primaryColor'],
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            size: 20,
                            color: customTheme['whiteColor'],
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NoLeadingWhitespaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}
