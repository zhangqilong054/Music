import { SongItemType } from './SongData'

@ObservedV2
export class GlobalMusic{
  @Trace img:string = ''
  @Trace name:string = ''
  @Trace author:string = ''
  @Trace url:string = ''
  @Trace time:number = 0
  @Trace duration:number = 0

  // 定义开关灯
  @Trace isPlay:boolean = false

  // 歌曲的索引
  @Trace playIndex:number = 0

  // 存储点过的歌曲
  @Trace playList:SongItemType[] = []

  // 播放模式
  @Trace playMode:'auto'|'random'|'repeat' = 'auto'
}