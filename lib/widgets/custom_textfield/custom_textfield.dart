import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gluon_flutter_test_auliapr/shared/palette.dart';
import 'package:gluon_flutter_test_auliapr/widgets/custom_textfield/custom_textfield_controller.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final int? lines;
  final Function? validator, onChanged;
  final TextInputType? keyboardType;
  final String? label, helperText, placeholder, textMessage;
  final bool autofocus,
      divider,
      enabled,
      isSearchInput,
      phone;
  final Widget? prefixIcon, otherWidget;
  final TextStyle? labelStyle,placeholderStyle,style;
  final VoidCallback? onEditingComplete;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? inputFormatters;


  const CustomTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.label,
    this.isSearchInput = false,
    this.helperText,
    this.placeholder = '',
    this.enabled = true,
    this.validator,
    this.keyboardType,
    this.autofocus = false,
    this.divider = false,
    this.lines = 1,
    this.labelStyle,
    this.textMessage,
    this.phone = false,
    this.prefixIcon,
    this.style = const TextStyle(),
    this.placeholderStyle, this.contentPadding,
    this.inputFormatters,
    this.onEditingComplete,
    this.otherWidget,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  late final CustomTextFieldController customTextFieldController;

  _init(){
    Get.delete<CustomTextFieldController>();
    customTextFieldController = Get.put(CustomTextFieldController());
  }

  InputBorder _mainBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Palette.light, width: 1),
    );
  }
  
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final bool _isLabel = widget.label != null;
    final bool _isHelperText = widget.helperText != null;
    final bool _isTextMessage = widget.textMessage != null;
    final bool _isLabelStyle = widget.labelStyle != null;
    final bool _isPrefixIcon = widget.prefixIcon != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        _isLabel
            ? Text(
          widget.label ?? '',
          style: _isLabelStyle
              ? widget.labelStyle
              : const TextStyle(
            fontSize: 13,
          ),
        )
            : const SizedBox(),
        Container(
          margin: EdgeInsets.only(
              top: _isLabel ? 10 : 0, bottom: _isHelperText ? 10 : 0),
          child: Row(
            children: [
              Flexible(
                child: Obx(()=> TextFormField(
                  enabled: widget.enabled,
                  autofocus: widget.autofocus,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  onChanged: (value) {
                    customTextFieldController.handleOnChanged(value);
                    widget.onChanged;
                  },
                  onEditingComplete: widget.onEditingComplete,
                  maxLines: widget.lines,
                  textInputAction: TextInputAction.done,
                  style: text.bodyText1?.merge(const TextStyle(color: Palette.dark)).merge(widget.style),
                  validator: (value) => widget.validator!(value ?? ''),
                  expands: false,
                  inputFormatters: (widget.inputFormatters != null) ? widget.inputFormatters : [],
                  decoration: InputDecoration(
                    prefixIcon: _isPrefixIcon ? widget.prefixIcon : null,
                    hintText: widget.placeholder,
                    hintStyle: widget.placeholderStyle,
                    enabledBorder: customTextFieldController.isInputValid.isFalse ? _mainBorder().copyWith(borderSide: const BorderSide(color: Palette.danger,width: 2)) : _mainBorder(),
                    focusedBorder: customTextFieldController.isInputValid.isFalse ? _mainBorder().copyWith(borderSide: const BorderSide(color: Palette.danger,width: 2)) : _mainBorder(),
                    fillColor:
                    widget.isSearchInput ? Palette.blueGradation : Palette.light,
                    filled: true,
                    contentPadding: widget.contentPadding ??
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 30,
                      child: Tooltip(
                        key: customTextFieldController.toolTipKey,
                        message: 'Username cannot be empty',
                        preferBelow: false,
                        enableFeedback: true,
                        decoration: BoxDecoration(color: Palette.danger,borderRadius: BorderRadius.circular(5)),
                        child: IconButton(
                          icon: Icon(
                            customTextFieldController.isInputValid.isTrue ? FontAwesomeIcons.check : FontAwesomeIcons.exclamationCircle,
                            color: customTextFieldController.isInputValid.isTrue ? Colors.green : Palette.danger,
                            size: 25,
                          ),
                          onPressed: ()=> {},
                        ),
                      ),
                    ),
                  ),
                )),
              ),
              widget.otherWidget ?? Container()
            ],
          ),
        ),
        _isHelperText
            ? Text(
          widget.helperText ?? '',
          style: const TextStyle(color: Palette.semiBlack),
        )
            : const SizedBox(),
        _isTextMessage
            ? Container(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Text(
              widget.textMessage ?? '',
              style: const TextStyle(color: Palette.success),
            ),
        )
            : const SizedBox(),
        widget.divider ? const Divider(height: 60) : const SizedBox(),
      ],
    );
  }
}



