import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyClass(),
  ));
}

class MyClass extends StatefulWidget {
  const MyClass({Key? key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  var phone = "";
  var msg = "";
  var code = "+91";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp Direct"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CountryCodePicker(
                  onChanged: (val) {
                    code = val.toString();
                  },

                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'IN',
                  favorite: ['+91', 'IN'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
              ),
              TextField(
                onChanged: (value) {
                  phone = value;
                },
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(), hintText: "Phone"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  msg = value;
                },
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(), hintText: "Message"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    // https://wa.me/1XXXXXXXXXX?text=I'm%20interested%20in%20your%20car%20for%20sale

                    code = code.replaceAll("+", "");

                    var url = "https://wa.me/$code$phone?text=$msg";
                    if (await canLaunch(url))
                      await launch(url);
                    else
                      // can't launch url, there is some error
                      throw "Could not launch $url";
                    print(code);
                  },
                  child: const Text('Send'))
            ],
          ),
        ),
      ),
    );
  }
}
