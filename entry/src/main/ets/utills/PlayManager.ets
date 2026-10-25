import { media } from '@kit.MediaKit'
import { GlobalMusic } from '../model/GlobalMusic'
import { SongItemType } from '../model/SongData'
import { AppStorageV2 } from '@kit.ArkUI'

class PlayManager {
  avPlayer: media.AVPlayer | null = null;
  currSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'currSong', () => new GlobalMusic()) as GlobalMusic;

  async init() {
    try {
      this.avPlayer = await media.createAVPlayer();
      this.avPlayer.on('stateChange', async (state, reason) => {
        switch (state) {
          case 'initialized':
            console.info('AVPlayerState initializes called.');
            this.avPlayer?.prepare();
            break;
          case 'prepared':
            console.info('AVPlayerState prepared called.');
            this.avPlayer?.play();
            this.currSong.isPlay = true;
            break;
          case 'completed':
            // 播放结束：按当前模式切歌（repeat 模式保持索引，等价于单曲循环）
            console.info('AVPlayerState completed called.');
            this.next();
            break;
        }
      })
      this.avPlayer.on('durationUpdate', (duration: number) => {
        this.currSong.duration = duration;
      })
      this.avPlayer.on('timeUpdate', (time: number) => {
        this.currSong.time = time;
      })
    } catch (error) {
      console.log(error)
    }
  }

  async changePlay(item?: SongItemType) {
    const player = this.avPlayer
    // 列表可能被删空，播放器也可能初始化失败
    if (!item || !player) {
      return
    }
    this.currSong.isPlay = false
    await player.reset()
    this.currSong.duration = 0
    this.currSong.time = 0
    this.currSong.img = item.img
    this.currSong.name = item.name
    this.currSong.author = item.author
    this.currSong.url = item.url
    player.url = item.url // 设置属性url，AVPlayer进入initialized状态
  }

  // 拖动进度条跳转
  async seek(time: number) {
    const player = this.avPlayer
    if (!player) {
      return
    }
    try {
      await player.seek(time)
      this.currSong.time = time
    } catch (error) {
      console.error(`seek failed: ${JSON.stringify(error)}`)
    }
  }

  singPlay(song: SongItemType) {
    let isArr = this.currSong.playList.some(item => item.id == song.id)
    if (isArr) {
      if (this.currSong.url == song.url) {
        this.avPlayer?.play()
        this.currSong.isPlay = true
      } else {
        this.currSong.playIndex = this.currSong.playList.findIndex(item => item.id == song.id)
        // 切歌
        this.changePlay(song)
      }
    } else {
      this.currSong.playList.unshift(song)
      this.currSong.playIndex = 0
      // 切歌
      this.changePlay(song)
    }
  }

  //暂停播放
  pause() {
    this.avPlayer?.pause();
    this.currSong.isPlay = false;
  }

  //继续
  resume() {
    this.avPlayer?.play();
    this.currSong.isPlay = true;
  }

  //上一首
  prev() {
    const lenth = this.currSong.playList.length;
    if (lenth === 0) {
      this.currSong.isPlay = false;
      return;
    }
    let newIndex = this.currSong.playIndex;
    if (this.currSong.playMode == 'auto') {
      newIndex = (newIndex - 1 + lenth) % lenth;
    } else if (this.currSong.playMode == 'random') {
      newIndex = Math.floor(Math.random() * lenth);
    }
    if (newIndex < 0 || newIndex >= lenth) {
      newIndex = 0;
    }
    this.currSong.playIndex = newIndex;
    this.changePlay(this.currSong.playList[newIndex]);
  }

  //下一首
  next() {
    const lenth = this.currSong.playList.length;
    if (lenth === 0) {
      this.currSong.isPlay = false;
      return;
    }
    let newIndex = this.currSong.playIndex;
    if (this.currSong.playMode == 'auto') {
      newIndex = (newIndex + 1) % lenth;
    } else if (this.currSong.playMode == 'random') {
      newIndex = Math.floor(Math.random() * lenth);
    }
    if (newIndex < 0 || newIndex >= lenth) {
      newIndex = 0;
    }
    this.currSong.playIndex = newIndex;
    this.changePlay(this.currSong.playList[newIndex]);
  }
}

export const playManager = new PlayManager();