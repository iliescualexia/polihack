import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';
import '../utils/custom_sizes.dart';

class DropDownListTwo extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String?>? onItemSelected;
  final String? initialValue;
  final bool isLoading;
  const DropDownListTwo({
    Key? key,
    required this.items,
    required this.hintText,
    this.onItemSelected,
    this.initialValue,
    this.isLoading = false
  }) : super(key: key);

  @override
  State<DropDownListTwo> createState() => _DropDownListTwoState();
}

class _DropDownListTwoState extends State<DropDownListTwo> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: AppColors.paleBlue,
        ),
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: AppColors.deepBlue,
        value: _selectedItem,
        hint: Text(widget.hintText, style: AppTextStyle.lightDefaultStyle()),
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyle.lightDefaultStyle(),
            errorStyle: TextStyle(color: Colors.red),
            contentPadding: EdgeInsets.all(CustomSizes.defaultOffset() * 2),
            filled: true,
            fillColor: AppColors.deepBlue.withOpacity(0.5),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColors.purple)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColors.pastelPurple)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColors.pastelPurple)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColors.purple))
        ),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  item,
                  style: AppTextStyle.lightDefaultStyle()),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(newValue);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a ${widget.hintText}';
          }
          return null;
        },
      ),
    );
  }
}
