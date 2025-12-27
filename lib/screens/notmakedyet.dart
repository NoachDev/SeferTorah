
import 'package:flutter/material.dart';
import 'package:sefertorah/util.dart';

class NotMakedYet extends StatelessWidget {
  const NotMakedYet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/working.png", width: 200,),
            const SizedBox(width: 300, child: Text("we are working on this feature, so for maintain the project ", textAlign: TextAlign.center)),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: launchRepo,
              style : ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(200),
                foregroundColor: Theme.of(context).colorScheme.onPrimary.withAlpha(200),
              ),
              child: const Text("buy me a coffee"),
            )
          ],
        ),
      ),
    );
  }
}