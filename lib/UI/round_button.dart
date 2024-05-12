import 'package:flutter/material.dart';

class RoundBut extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;

  const RoundBut({
    super.key,
    required this.title,
    required this.ontap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        color: Colors.lightBlue,
        height: 40,
        child: Center(
          child: Center(
              child: loading
                  ? CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Colors.white,
                    )
                  : Text(title)),
        ),
      ),
    );
  }
}
