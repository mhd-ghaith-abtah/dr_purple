import 'package:dr_purple/app/app_configurations/assets.dart';
import 'package:dr_purple/app/app_management/strings_manager.dart';
import 'package:dr_purple/features/splash/data/local/models/get_started_screen_model/get_started_screen_model.dart';

class GetStartedLocalDataSource {
  List<GetStartedScreenModel> getStartedScreenData() => [
        /// first slide
        GetStartedScreenModel(
          imagePath: ImageAssets.firstSlideImage,
          title: AppStrings.firstSlideTitle,
          subtitle: AppStrings.firstSlideSubtitle,
        ),

        /// second slide
        GetStartedScreenModel(
          imagePath: ImageAssets.secondSlideImage,
          title: AppStrings.secondSlideTitle,
          subtitle: AppStrings.secondSlideSubtitle,
        ),

        /// third slide
        GetStartedScreenModel(
          imagePath: ImageAssets.thirdSlideImage,
          title: AppStrings.thirdSlideTitle,
          subtitle: AppStrings.thirdSlideSubtitle,
        ),
      ];
}
