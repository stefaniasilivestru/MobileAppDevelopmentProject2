import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SharePage extends StatelessWidget {
  const SharePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(AppLocalizations.of(context)!.share_text),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.share_page_text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24.0,
                color: Color(0xFF1c2143),
                fontWeight: FontWeight.bold,

              ),
            ),
            const SizedBox(height: 40.0),
            Image.asset(
              'assets/logo_tripify.jpg', // Replace with your image path
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                _showModalBottomSheet(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1c2143)), // Background color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Set border radius to zero for square corners
                    side: BorderSide.none, // Remove border
                  ),
                ),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                child: Text(
                  AppLocalizations.of(context)!.share_text,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Get link'),
              onTap: () => {},
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit name'),
              onTap: () => {},
            ),
          ],
        );
      },
    );
  }
}
