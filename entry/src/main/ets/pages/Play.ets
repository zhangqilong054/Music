import { AppStorageV2 } from '@kit.ArkUI'
import { GlobalMusic } from '../model/GlobalMusic'
import { SongItemType } from '../model/SongData'
import { playManager } from '../utills/PlayManager';

@Entry
@Component
struct Play {
  @State panelY: string = '100%';
  currSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'currSong', () => new GlobalMusic()) as GlobalMusic

  /*
    aboutToAppear(): void {
      // 添加一些假数据
      this.currSong.img = 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg'
      this.currSong.name = '直到世界的尽头'
      this.currSong.author = 'WANDS'
      this.currSong.url = 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a'
      this.currSong.time = 100000
      this.currSong.duration = 300000
      this.currSong.isPlay = false
      this.currSong.playIndex = 0
      this.currSong.playList.push({
        img: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.jpg',
        name: '直到世界的尽头',
        author: 'WANDS',
        url: 'http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/0.m4a',
        id: '0000'
      })
      this.currSong.playMode = 'auto'
    }
  */
  numberToTime(num: number) {
    const n = num / 1000;
    const second = Math.floor(n % 60);
    const minute = Math.floor(n / 60);
    //补前导0
    const s = second.toString().padStart(2, '0');
    const mm = minute.toString().padStart(2, '0');
    return `${mm}:${s}`
  }

  @Builder
  deleteBtnBuilder(item: SongItemType) {
    Text(`删除`)
      .fontSize(20)
      .textAlign(TextAlign.Center)
      .fontColor(Color.White)
      .backgroundColor("#eb5c86")
      .width(100)
      .height('100%')
      .onClick(() => {
        const i = this.currSong.playList.findIndex((s: SongItemType) => s.id === item.id)
        if (i === -1) {
          return
        }
        const isCurrent = i === this.currSong.playIndex
        this.currSong.playList.splice(i, 1)
        const len = this.currSong.playList.length
        if (isCurrent) {
          if (len === 0) {
            playManager.pause()
          } else {
            const newIndex = i % len
            this.currSong.playIndex = newIndex
            playManager.changePlay(this.currSong.playList[newIndex])
          }
        } else if (i < this.currSong.playIndex) {
          this.currSong.playIndex--
        }
        this.panelY = '100%'
      })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Image(this.currSong.img)
        .width('100%')
        .height('100%')
        .blur(1000)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])

      // 内容
      Column() {
        Image($r("app.media.ic_stylus"))
          .width(200)
          .aspectRatio(1)
          .rotate({ angle: -60 })
          .margin({
            left: 100,
            top: -20
          })
        // CD唱片
        Stack() {
          Image($r("app.media.ic_cd"))
            .width(260)

          Image(this.currSong.img)
            .width(180)
            .borderRadius('100%')
        }.margin({
          top: -100
        })

        Text(this.currSong.name)
          .fontColor(Color.White)
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .margin({
            top: 30
          })
        Text(this.currSong.author)
          .fontColor("#eee")
          .fontSize(22)
          .margin({
            top: 15
          })

        // 脚标区域
        Row() {
          Badge({
            style: {
              badgeSize: 16,
              fontSize: 14,
              badgeColor: "#8a8985",
              borderWidth: 2
            },
            value: '99+'
          }) {
            Image($r("app.media.ic_like"))
              .width(30)
              .aspectRatio(1)
              .fillColor(Color.White)
          }

          Badge({ style: { badgeSize: 16, fontSize: 14 }, value: '10w' }) {
            Image($r("app.media.ic_comment_o"))
              .width(30)
              .aspectRatio(1)
              .fillColor(Color.White)
          }

          Badge({ style: { badgeSize: 16, fontSize: 14 }, value: 'hot' }) {
            Image($r("app.media.ic_share"))
              .width(30)
              .aspectRatio(1)
              .fillColor(Color.White)
          }

          Badge({ style: { badgeSize: 16, fontSize: 14 }, value: 'vip' }) {
            Image($r("app.media.ic_download_o"))
              .width(30)
              .aspectRatio(1)
              .fillColor(Color.White)
          }
        }.width('100%')
        .margin({
          top: 40
        })
        .justifyContent(FlexAlign.SpaceEvenly)


        // 播放时间 滑动条
        Row() {
          Text(this.numberToTime(this.currSong.time))
            .fontColor(Color.White)
          Slider({ min: 0, max: this.currSong.duration, value: this.currSong.time })
            .trackColor(Color.White)
            .layoutWeight(1)
          Text(this.numberToTime(this.currSong.duration))
            .fontColor(Color.White)
        }.width('100%')
        .padding(10)
        .margin({
          top: 30
        })

        // 控制按钮
        Row() {
          if (this.currSong.playMode == "auto") {
            Image($r("app.media.ic_auto"))
              .width(30)
              .fillColor(Color.White)
              .onClick(() => {
                this.currSong.playMode = "random"
              })
          } else if (this.currSong.playMode == "random") {
            Image($r("app.media.ic_random"))
              .width(30)
              .fillColor(Color.White)
              .onClick(() => {
                this.currSong.playMode = "repeat"
              })
          } else {
            Image($r("app.media.ic_repeat"))
              .width(30)
              .fillColor(Color.White)
              .onClick(() => {
                this.currSong.playMode = "auto"
              })
          }
          Image($r("app.media.ic_prev"))
            .width(30)
            .fillColor(Color.White)
            .onClick(() => {
              playManager.prev();
            })
          Image(this.currSong.isPlay ? $r("app.media.ic_paused") : $r("app.media.ic_play"))
            .width(45)
            .fillColor(Color.White)
            .onClick(() => {
              if (this.currSong.isPlay) {
                playManager.pause();
              } else {
                // 已有 url 且是同一首歌时，直接 resume；否则才切歌
                if (this.currSong.url && this.currSong.url === this.currSong.playList[this.currSong.playIndex]?.url) {
                  playManager.resume();
                } else {
                  playManager.changePlay(this.currSong.playList[this.currSong.playIndex]);
                }
              }
            })
          Image($r("app.media.ic_next"))
            .width(30)
            .fillColor(Color.White)
            .onClick(() => {
              playManager.next();
            })
          Image($r("app.media.ic_song_list"))
            .width(30)
            .fillColor(Color.White)
            .onClick(() => {
              this.panelY = '0%'
            })

        }.width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .padding(20)

      }.width('100%')
      .height('100%')

      // 列表弹窗
      Column() {
        Row({ space: 15 }) {
          Image($r("app.media.ic_play"))
            .fillColor("#fe5185")
            .width(30)
            .aspectRatio(1)

          Text(`播放列表（${this.currSong.playList.length}）`)
            .fontColor(Color.White)
            .layoutWeight(1)

          Image($r("app.media.ic_close"))
            .width(26)
            .fillColor("#eee")
            .onClick(() => {
              this.panelY = '100%'
            })
        }.padding(20)

        List() {

          ForEach(this.currSong.playList, (item: SongItemType, index) => {

            ListItem() {
              Row({ space: 20 }) {
                Text(`${index + 1}`)
                  .fontSize(20)
                  .fontColor("#eee")
                Column() {
                  Text(item.name)
                    .fontSize(20)
                    .fontColor("#eee")
                  Text(item.author)
                    .fontSize(16)
                    .fontColor("#eee")
                }.layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Image($r("app.media.ic_more"))
                  .width(28)
                  .fillColor("#eee")
              }.width('100%')
              .padding(20)
            }
            .swipeAction({ end: this.deleteBtnBuilder(item) })
            .onClick(()=>{
              const i = this.currSong.playList.findIndex((s: SongItemType) => s.id === item.id)
              if (i !== -1) {
                this.currSong.playList.splice(i, 1)
                this.currSong.playList.unshift(item)
              }
              this.currSong.playIndex = 0
              playManager.changePlay(item)
              this.panelY='100%'
            })
          }, (item: SongItemType) => item.id)
        }.width('100%')
        .height('100%')

      }
      .width('100%')
      .height('50%')
      .translate({ y: this.panelY })
      // .clip(true)
      // .opacity(1) // 盒子的透明度 0 完全透明  1  完全不透明
      .backgroundColor("#353333")
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      .animation({
        duration: 300  // 300 毫秒 , 面板高度变化时的 动画 时长
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }
}

