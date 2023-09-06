import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_from_scratch/ui/common/ui_helpers.dart';
import 'package:stacked_from_scratch/ui/views/startup/startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel>{
  
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(context, StartupViewModel viewModel, Widget? child){
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text('GOD', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text('Loading ...', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),),

                horizontalSpaceSmall,

                SizedBox(
                  width: 16, height: 16,
                  child: CircularProgressIndicator(color: Colors.black, strokeWidth: 6,),
                )
                
              ],
            )
            
          ],
        ),
      ),
    );
  }
  
  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    viewModel.runStartupLogic();
  });
}