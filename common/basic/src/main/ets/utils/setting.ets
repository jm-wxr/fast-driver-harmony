import { Advert } from '../models'
import { Context } from '@kit.AbilityKit'
import { preferences } from '@kit.ArkData'
import { USER_SETTING, USER_SETTING_AD } from '../constants/setting'

// 没有设置广告配置时的默认配置
const defaultAd: Advert = {
  showAd: true,
  adTime: 5,
  adImg: $r('app.media.start')
}

export class UserSettingClass {
  context: Context
  /**
   * 用于对用户的设置进行操作
   * @param context 上下文，用于获取首选项
   */
  constructor(context: Context) {
    this.context = context
  }
  /**
   * 获取存储用户设置的首选项仓库
   * @returns 首选项仓库
   */
  getStore() {
    return preferences.getPreferences(this.context, USER_SETTING)
  }
  /**
   * 设置用户广告配置
   * @param ad 广告配置
   */
  async  setUserAd (ad: Advert) {
    const adStore = await this.getStore()
    await adStore.put(USER_SETTING_AD, JSON.stringify(ad))
    await adStore.flush()
  }
  /**
   * 获取广告配置
   * @returns 广告配置
   */
  async getUserAd() {
    const adStore = await this.getStore()
    return JSON.parse(adStore.getSync(USER_SETTING_AD, JSON.stringify(defaultAd)) as string) as Advert
  }
}