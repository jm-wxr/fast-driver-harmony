import { Advert, UserSettingClass } from '@hm/basic/Index'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct Start {
  /** 用户设置对象 */
  userSetting: UserSettingClass = new UserSettingClass(getContext(this))
  /** 广告配置 */
  @State advert: Advert = {
    showAd: false,
    adTime: 0
  }
  /** 定时器id */
  timerId: number = -1

  async aboutToAppear() {
    await this.countdown()
  }

  async aboutToDisappear() {
    clearInterval(this.timerId)
  }

  /**
   * 广告倒计时
   */
  async countdown() {
    this.advert = await this.userSetting.getUserAd()
    this.timerId = setInterval(() => {
      if (this.advert.adTime === 0) {
        clearInterval(this.timerId)
        this.closeAdWin()
        return
      }
      this.advert.adTime--
    }, 1000)
  }

  /**
   * 关闭广告窗口
   */
  closeAdWin() {
    window.findWindow("ad_window").destroyWindow()
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image(this.advert.adImg).objectFit(ImageFit.Cover)
      Text(`${this.advert.adTime}秒后跳过`)
        .padding({ left: 10, right: 10 })
        .margin({ right: 20, top: 20 })
        .height(30)
        .fontSize(14)
        .borderRadius(15)
        .backgroundColor($r("app.color.background_page"))
        .textAlign(TextAlign.Center)
    }
    .height('100%')
    .width('100%')
  }
}