{ config, pkgs, ... }:
{
  programs.mpv = {
    enable = true;

    bindings = {
      # 鼠标滚轮：±10 秒
      "WHEEL_UP" = "seek 10";
      "WHEEL_DOWN" = "seek -10";

      # z：恢复正常播放速度
      "z" = "set speed 1.0";

      # x/c：以 0.1 为步进调整播放速度
      "x" = "add speed -0.1";
      "c" = "add speed 0.1";

      # 鼠标侧键：Forward 加速 0.15；Back 恢复 1.0
      "MBTN_FORWARD" = "add speed 0.15";
      "MBTN_BACK" = "set speed 1.0";

      # 鼠标中键：1.5x
      "MBTN_MID" = "set speed 1.5";
    };

    config = {
      # 开启缓存（在 mpv 的缓存体系里通常与 demuxer 缓存配合使用）
      cache = true;

      # 缓存最多“提前缓存”多少秒：这里 3600s = 1 小时
      cache-secs = 3600;

      # 缓存大小上限：400MiB（接近你说的 400M）
      demuxer-max-bytes = "400MiB";

      # （可选但推荐）限制“回看缓冲”（已播放内容）也不超过 400MiB，
      # 否则 mpv 可能把“已播内容”也保留到较大的上限，占用更多内存。
      # demuxer-max-back-bytes = "400MiB";
    };

  };
}
