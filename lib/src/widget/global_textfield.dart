import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalTextField extends StatefulWidget {

  GlobalTextField({
    Key? key,
    this.contentPadding,
    this.title,
    this.hint,
    this.security = false,
    this.controller,
    this.textInputType,
    this.validator,
    this.autovalidateMode,
    this.requireInput = '*',
    this.readOnly,
    this.onTap,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.inputFormatters,
    this.onSubmit,
    this.enabled,
  }) : super(key: key);

  final Widget? prefixIcon;
  Widget? suffixIcon;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final TextInputType? textInputType;
  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;
  bool security;
  final FormFieldValidator? validator;
  final AutovalidateMode? autovalidateMode;
  final String requireInput;
  final int maxLines;
  final int minLines;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onSubmit;
  final bool? enabled;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {

  bool secure = false;

  @override
  void initState() {
    super.initState();
    if (widget.security) {
      if (widget.suffixIcon == null) {
        secure = true;
      }
      widget.suffixIcon ??= TextButton(
        onPressed: () {
          setState(() {
            widget.security = !widget.security;
          });
        },
        child: Visibility(
          visible: widget.security,
          child: const Icon(Icons.visibility, color: Colors.grey,),
          replacement: const Icon(Icons.visibility_off, color: Colors.grey,),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (secure) {
      widget.suffixIcon = TextButton(
        onPressed: () {
          setState(() {
            widget.security = !widget.security;
          });
        },
        child: Visibility(
          visible: widget.security,
          child: const Icon(Icons.visibility, color: Colors.black54,),
          replacement: const Icon(Icons.visibility_off, color: Colors.black54,),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: '${widget.title ?? ''}${widget.requireInput}'.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title??'',
                style: TextStyle(
                  fontSize: 12,

                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        TextFormField(
          autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
          expands: false,
          controller: widget.controller,
          obscureText: widget.security,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hint ?? '',
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300
              )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.grey.shade300
                )
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Colors.grey.shade300
                )
            )
          ),
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          validator: widget.validator,
          onTap: widget.onTap,
          readOnly: widget.readOnly ?? false,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters
              ?? (TextInputType.phone == widget.textInputType ? [LengthLimitingTextInputFormatter(10)] : null),
          onFieldSubmitted: widget.onSubmit,
        ),
      ],
    );
  }
}

class Validator {
  static String? serial(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập mã serial';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Vui lòng nhập mã serial là số từ 0-9';
    }
    return null;
  }


  static String? pointCanEmpty(valueDy, {int? maxPoint, int? minPoint}) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return null;
    }
    return point(valueDy, maxPoint: maxPoint, minPoint: minPoint);
  }

  static String? point(valueDy, {int? maxPoint, int? minPoint}) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập điểm';
    }
    if (!RegExp(r'[0-9]')
        .hasMatch(value)) {
      return 'Vui lòng nhập điểm là số từ 0-9';
    }
    if (null != maxPoint) {
      int point = int.parse(value);
      if (point > maxPoint) {
        return 'Vui lòng nhập điểm <=$maxPoint';
      }
    }
    if (null != minPoint) {
      int point = int.parse(value);
      if (point < minPoint) {
        return 'Vui lòng nhập điểm >=$minPoint';
      }
    }
    return null;
  }

  static String? tax(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập mã số thuế';
    }
    return null;
  }

  static String? fullnameCompany(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập tên công ty';
    }
    return null;
  }


  static String? fullnameCanEmpty(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return null;
    }
    return fullname(valueDy);
  }

  static String? emailCanEmpty(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return null;
    }
    return email(valueDy);
  }

  static String? productName(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập tên sản phẩm';
    }
    return null;
  }

  static String? bank(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập số tài khoản ngân hàng';
    }
    return null;
  }

  static String? bankName(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập họ tên chủ tài khoản ngân hàng';
    }
    return null;
  }

  static String? address(valueDy) {
    String value = valueDy;
    if (value.isEmpty) {
      return 'Vui lòng nhập địa chỉ cụ thể';
    }
    return null;
  }

  static String? idCard(valueDy) {
    String value = valueDy;
    if (value.isEmpty) {
      return 'Vui lòng nhập số CMND/ CCCD';
    }
    if (value.length != 9 && value.length != 12) {
      return 'Vui lòng nhập đủ 9 hoặc 12 số CMND/ CCCD';
    }
    return null;
  }

  static String? email(valueDy) {
    String value = valueDy;
    if (value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    if (!RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$").hasMatch(value)) {
      return 'Vui lòng nhập đúng email';
    }
    return null;
  }


  static String? birthday(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng chọn ngày sinh';
    }
    if (!RegExp(r'\d{4}.\d{2}.\d{2}').hasMatch(value)) {
      return 'Vui lòng nhập ngày theo định dạng "yyyy-MM-dd"';
    }
    return null;
  }

  static String? birthdayVn(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng chọn ngày sinh';
    }
    if (!RegExp(r'\d{2}.\d{2}.\d{4}').hasMatch(value)) {
      return 'Vui lòng nhập ngày theo định dạng "dd/MM/yyyy"';
    }
    return null;
  }

  static String? birthdayVnCanEmpty(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return null;
    }
    return birthdayVn(valueDy);
  }

  static String? referralCode(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập mã người giới thiệu';
    }
    return null;
  }

  static String? fullname(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập họ và tên';
    }
    if (!RegExp(r'\w+').hasMatch(value)) {
      return 'Vui lòng nhập đúng họ và tên';
    }
    return null;
  }

  static String? phone(valueDy) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng nhập số điện thoại Việt Nam';
    }
    if (value.trim().length != 10) {
      return 'Vui lòng nhập đúng 10 số điện thoại';
    }
    if (!RegExp(r'^0?[3|5|7|8|9][0-9]{8}$')
        .hasMatch(value)) {
      return 'Vui lòng nhập đúng số điện thoại Việt Nam';
    }
    return null;
  }

  static String? password(valueDy) {
    String value = valueDy ?? '';
    if (value.length < 8) {
      return 'Vui lòng nhập mật khẩu ít nhất 8 ký tự';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Vui lòng nhập ít nhất 1 ký tự thường';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Vui lòng nhập ít nhất 1 ký tự in hoa';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Vui lòng nhập ít nhất 1 số từ 0 đến 9';
    }
    if (!RegExp(r'[!"#$%&'"'"'()*+,-./:;<=>?@[\\]^_`{|}~]').hasMatch(value)) {
      return 'Vui lòng nhập ít nhất 1 ký tự đặc biệt';
    }
    return null;
  }

  static String? rePassword(valueDy, String rePassword) {
    String value = valueDy ?? '';
    if (value.isEmpty) {
      return 'Vui lòng xác nhận lại mật khẩu';
    }
    if (value != rePassword) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

}
