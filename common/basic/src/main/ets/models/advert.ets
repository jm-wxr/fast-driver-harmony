/**
 * 广告类型
 */
export interface Advert {
  /**
   * 是否显示广告
   */
  showAd: boolean
  /**
   * 广告时长
   */
  adTime: number
  /**
   * 广告链接
   */
  adUrl?: string
  /**
   * 广告图片地址
   */
  adImg?: ResourceStr
}