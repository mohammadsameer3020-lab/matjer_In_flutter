import 'package:flutter/material.dart';
import 'package:first_flutter/shared/Coloer.dart'; // لاستخدام لون تطبيقك الأخضر BTNgreen

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;

  const CustomSearchBar({super.key, required this.onSearchChanged});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _currentValue = "";

  @override
  void initState() {
    super.initState();
    // إعادة بناء الواجهة المحلية لتغيير الألوان والظلال فوراً عند التركيز (Focus)
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // أنيميشن سلس ومريح للعين
        decoration: BoxDecoration(
          // تتغير الخلفية للأبيض مع ظل خفيف عند الضغط، وتكون رمادية في الحالة العادية
          color: _focusNode.hasFocus
              ? Colors.white
              : const Color.fromARGB(255, 242, 244, 248),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _focusNode.hasFocus
              ? [
                  BoxShadow(
                    color: BTNgreen.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
            widget.onSearchChanged(
                value); // تمرير النص لصفحة الـ Home فلترة المنتجات
          },
          decoration: InputDecoration(
            hintText: "Search for products...",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),

            // يتغير لون أيقونة البحث للأخضر عند التفاعل
            prefixIcon: Icon(
              Icons.search_rounded,
              color: _focusNode.hasFocus ? BTNgreen : Colors.grey,
            ),

            // زر الحذف (X) يظهر فقط عندما يبدأ المستخدم في الكتابة
            suffixIcon: _currentValue.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.cancel_rounded, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        _currentValue = "";
                      });
                      widget.onSearchChanged(
                          ""); // تصفير البحث وإعادة كل المنتجات في الـ Home
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
