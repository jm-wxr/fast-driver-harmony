import { Advert, UserSettingClass } from '@hm/basic/Index';
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage) {
    // 获取
    const setting: UserSettingClass = new UserSettingClass(this.context)
    // 模拟请求拿到广告信息
    const result = await new Promise<Advert>((resolve, reject) => {
      setTimeout(() => {
        resolve({
          showAd: true,
          adTime: 5,
          adImg: $r('app.media.start')
        } as Advert)
      }, 500)
    })
    await setting.setUserAd(result)
    if (result.showAd) {
      // 展示广告
      const win = await windowStage.createSubWindow("ad_window")
      await win.showWindow()
      win.setUIContent('pages/Start/Start')
    }
    windowStage.loadContent('pages/Index')
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
