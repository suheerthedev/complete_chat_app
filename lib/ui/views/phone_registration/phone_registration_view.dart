import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'phone_registration_viewmodel.dart';

class PhoneRegistrationView extends StatelessWidget {
  const PhoneRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhoneRegistrationViewModel>.reactive(
      viewModelBuilder: () => PhoneRegistrationViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'ENTER YOU NUMBER',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  TextField(
                    controller: model.phoneCont,
                    decoration: InputDecoration(
                      hintText: '+92-xxx-xxxxxxx',
                      labelText: 'Phone Number',
                      labelStyle: const TextStyle(color: Colors.black),
                      suffixIcon: const Icon(
                        FontAwesomeIcons.phone,
                        color: Color.fromARGB(255, 133, 203, 135),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        model.submitPhoneNumber(model.phoneCont.text.trim());
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
