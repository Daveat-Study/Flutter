import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_from_scratch/ui/common/ui_helpers.dart';
import 'package:stacked_from_scratch/ui/views/login/login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel>{

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child){

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text(
              'Hello, I\'a god!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
              ),
            ),

            verticalSpaceMedium,

            MaterialButton(
              onPressed: viewModel.incrementCounter,
              child: Text(viewModel.counterLabel, style: const TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

}