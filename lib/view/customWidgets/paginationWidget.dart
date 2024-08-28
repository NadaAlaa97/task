import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;

  const PaginationWidget({Key? key, required this.currentPage, required this.totalPages,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final pageIndex = index + 1;
          return InkWell(
            onTap: () => onPageSelected(pageIndex),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('$pageIndex',
                style: TextStyle(
                  color: currentPage == pageIndex ? Colors.blue : Colors.black,
                  fontSize: 20.spMin,
                  fontWeight: currentPage == pageIndex ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
