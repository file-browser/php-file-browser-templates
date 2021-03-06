<!DOCTYPE html>
<html lang="zh-CN" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>{{__TITLE__}}</title>
    <meta name="viewport" content="width=device-width,height=device-height,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js" charset="utf-8"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-file-download@1.4.6/src/Scripts/jquery.fileDownload.js" charset="utf-8"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js" charset="utf-8"></script>
    <style media="screen" type="text/css">
      a {
        text-decoration: none;
      }
      a:hover {
        text-decoration: none;
      }
      .list-30 > li {
        line-height: 30px;
      }
    </style>
    <template id="list_dir">
      <tr>
        <th scope="row" onclick="opendir('{{__PATH__}}')" colspan="2">
          <i class="fas {{__ICON__}} fa-fw"></i>
          {{__NAME__}}
        </th>
      </tr>
    </template>
    <template id="list_item">
      <tr>
        <th scope="row">
          <i class="fas {{__ICON__}} fa-fw"></i>
          {{__NAME__}}
        </th>
        <td>
          {{__DOWNLOAD__}}
          {{__VIDEO__}}
          {{__AUDIO__}}
        </td>
      </tr>
    </template>

    <!-- 下载按钮 -->
    <template id="list_item_download">
      <a href="{{__PATH__}}" download="{{__NAME__}}">
        <i class="fas fa-download fa-fw"></i>
      </a>
    </template>
    <!-- ./下载按钮 -->

    <!-- 视频播放按钮 -->
    <template id="list_item_video">
      <a href="javascript:void(0);" onclick="play('{{__PATH__}}', '{{__NAME__}}');">
        <i class="fas fa-play fa-fw"></i>
      </a>
    </template>
    <!-- ./视频播放按钮 -->

    <!-- ./播放按钮 -->
    <template id="list_item_audio">
      <a href="javascript:void(0);" onclick="play_audio('{{__PATH__}}', '{{__NAME__}}');">
        <i class="fas fa-play fa-fw"></i>
      </a>
    </template>
    <!-- ./音频播放按钮 -->

    <!-- 导航 -->
    <template id="nav_item">
      <a href="javascript:void(0);" onclick="opendir('{{__PATH__}}')">{{__NAME__}}</a>
    </template>
    <!-- ./导航 -->
  </head>
  <body>
    <!-- TITLE -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="javascript:void(0);">{{__TITLE__}}</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
        </ul>
        <span class="navbar-text">
          <a href="{{__SUBTITLE_LINK__}}">{{__SUBTITLE_TEXT__}}</a>
        </span>
      </div>
    </nav>
    <!-- ./TITLE -->

    <!-- Container -->
    <div class="container my-4">

      <!-- NAV_PART -->
      <div class="card my-4">
        <div class="card-body">
          <div id="container">
            <div id="nav" class="mb-4">当前位置：</div>
            <div id="content">
              <table class="table table-hover">
                <thead>
                  <tr>
                    <th scope="col">文件名</th>
                    <th scope="col">操作</th>
                  </tr>
                </thead>
                <tbody id="list">
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    <!-- ./NAV_PART -->

    <!-- FOOTER -->
      <footer class="card">
        <div class="card-body">
          <div class="card-title">
            <h5>关于与鸣谢</h5>
          </div>
          <ul class="list-30">
            <li>
              项目地址：<a href="{{__AKM_LINK__}}" target="_blank">{{__AKM_TEXT__}}</a>
            </li>
            <li>
              当前版本：<img src="https://img.shields.io/badge/tag-v{{__VERSION__}}-orange"/>
            </li>
            <li>
              最新版本：<img src="https://img.shields.io/github/v/tag/file-browser/php-file-browser?style=flat-square"/>
            </li>
          </ul>
        </div>
      </footer>
    <!-- ./FOOTER -->

    </div>
    <!-- ./Container -->


    <!-- BOTTOM -->
    <p class="bottom text-center grey">
      Powered by <a href="https://github.com/file-browser/php-file-browser" target="_blank">File Browser</a>
    </p>
    <!-- ./BOTTOM -->

    <!-- Player -->
    <div class="modal fade" id="player" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="player_title">播放器</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body text-center">
            <video src="" id="player_v" controls width="100%" autoplay></video>
          </div>
        </div>
      </div>
    </div>
    <!-- ./Player -->

    <!-- Audio Player -->
    <div class="modal fade" id="audio_player" data-keyboard="false" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="audio_player_title">播放器</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body text-center">
            <audio src="" id="audio_player_a" controls width="100%" autoplay></audio>
          </div>
        </div>
      </div>
    </div>
    <!-- ./Audio Player -->
    <script type="text/javascript">
      var map = "{{__MAP__}}";
      var nav = '';
      var list;
      var w_path = window.location.hash;
      var video_download_btn = {{__VIDEO_DOWNLOAD_BTN__}};
      var audio_download_btn = {{__AUDIO_DOWNLOAD_BTN__}};
      console.log(map);

      $(function(){
        // map载入
        list = $.parseJSON(map);
        // 打开目录
        opendir(w_path);
        // css-download-btn
        if (video_download_btn === false) {
          $('#player_v').attr('controlsList', 'nodownload');
        }
        if (audio_download_btn === false) {
          $('#audio_player_a').attr('controlsList', 'nodownload');
        }
        // 关闭播放器时停止播放视频
        $('#player').on('hide.bs.modal', function() {
          $('#player_v').trigger('pause');
        });
        // 关闭播放器时停止播放音频
        $('#audio_player').on('hide.bs.modal', function() {
          $('#audio_player_a').trigger('pause');
        });
      });

      function opendir(path = '') {
        path = path.substring(0, 1) == '#' ? path.substring(2) : path;
        console.log('open: ' + path);
        location.href = '#/' + path;
        $('#list').html('');
        if (path == '') {
          arr = list;
          $('#nav').html('当前位置：' + $('#nav_item').html().replace('{{__NAME__}}', '根目录').replace('{{__PATH__}}', ''));
        }else{
          var sp = path.split('/');
          var arr = list;
          var nav_path = '';
          var nav_item = '';
          $('#nav').html('当前位置：' + $('#nav_item').html().replace('{{__NAME__}}', '根目录').replace('{{__PATH__}}', ''));
          $.each(sp, function(key, value){
            nav_path = (nav_path == '' ? nav_path : nav_path + '/') + value;
            nav_item = '/ ' + value;
            $('#nav').html($('#nav').html() + $('#nav_item').html().replace('{{__NAME__}}', nav_item).replace('{{__PATH__}}', nav_path));
            arr = arr[value];
          });
        }
        // 文件夹优先显示
        $.each(arr, function(key, value) {
          if (typeof value == 'object' || Array.isArray(value)) {
            tpl = $('#list_dir').html();
            tpl = tpl.replace(/{{__ICON__}}/g, 'fa-folder');
            tpl = tpl.replace(/{{__PATH__}}/g, (path == '' ? path : path + '/') + key);
            tpl = tpl.replace(/{{__NAME__}}/g, key);
            $('#list').append(tpl);
          }
        });
        // 显示文件
        $.each(arr, function(key, value) {
          if (typeof value != 'object' && !Array.isArray(value)) {
            tpl = $('#list_item').html();
            tpl = tpl.replace(/{{__ICON__}}/g, 'fa-file');
            tpl = tpl.replace(/{{__PATH__}}/g, (path == '' ? './' : './' + path + '/') + value);
            tpl = tpl.replace(/{{__NAME__}}/g, value);
            // 判断是否为mp4文件
            ext = value.split('.');
            ext = ext.pop();
            // 视频
            if (ext == 'mp4' || ext == 'mkv') {
              // 增加播放按钮
              v = $('#list_item_video').html();
              v = v.replace(/{{__PATH__}}/g, (path == '' ? './' : './' + path + '/') + value);
              v = v.replace(/{{__NAME__}}/g, value);
              tpl = tpl.replace(/{{__VIDEO__}}/g, v);
              // 下载按钮处理
              if (video_download_btn === true) {
                download = $('#list_item_download').html();
                download = download.replace(/{{__PATH__}}/g, (path == '' ? './' : './' + path + '/') + value);
                download = download.replace(/{{__NAME__}}/g, value);
                tpl = tpl.replace(/{{__DOWNLOAD__}}/g, download);
              }else{
                tpl = tpl.replace(/{{__DOWNLOAD__}}/g, '');
              }
            }else{
              tpl = tpl.replace(/{{__VIDEO__}}/g, '');
            }
            // 音频
            if (ext == 'mp3' || ext == 'ogg') {
              // 增加播放按钮
              v = $('#list_item_audio').html();
              v = v.replace(/{{__PATH__}}/g, (path == '' ? './' : './' + path + '/') + value);
              v = v.replace(/{{__NAME__}}/g, value);
              tpl = tpl.replace(/{{__AUDIO__}}/g, v);
              // 下载按钮处理
              if (audio_download_btn === true) {
                download = $('#list_item_download').html();
                download = download.replace(/{{__PATH__}}/g, (path == '' ? './' : './' + path + '/') + value);
                download = download.replace(/{{__NAME__}}/g, value);
                tpl = tpl.replace(/{{__DOWNLOAD__}}/g, download);
              }else{
                tpl = tpl.replace(/{{__DOWNLOAD__}}/g, '');
              }
            }else{
              tpl = tpl.replace(/{{__AUDIO__}}/g, '');
            }

            // 下载按钮最终处理
            if (ext != 'mp3' && ext != 'ogg' && ext != 'mp4' && ext != 'mkv') {
              download = $('#list_item_download').html();
              download = download.replace(/{{__PATH__}}/g, (path == '' ? './' : './' + path + '/') + value);
              download = download.replace(/{{__NAME__}}/g, value);
              tpl = tpl.replace(/{{__DOWNLOAD__}}/g, download);
            }

            $('#list').append(tpl);
          }
        });
      }

      function play(path, name) {
        $('#player').modal('show');
        $('#player_title').html(name);
        $('#player_v').attr('src', path);
      }

      function play_audio(path, name) {
        $('#audio_player').modal('show');
        $('#audio_player_title').html(name);
        $('#audio_player_a').attr('src', path);
      }
    </script>

  </body>
</html>
