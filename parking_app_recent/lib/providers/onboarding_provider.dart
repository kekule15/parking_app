
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/viewmodels/onbaording_vm.dart';

final onbaordingProvider = ChangeNotifierProvider<OnBoardingViewModel>(
    (ref) => OnBoardingViewModel(ref));
