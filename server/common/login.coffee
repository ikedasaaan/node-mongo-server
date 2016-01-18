conf = require "config"
bcrypt = require "bcrypt"
util = require "./util"

exports.login = (req, res, logger, redisClient, mongoose, Users, arrRes) ->

  # 初期値設定
  arrRes['result']  = 0
  arrRes['message']  = ''

  # 入力値
  email  = req.param("email")
  passwd = req.param("password")

  # ID(e-mail)で検索
  Users.find { memLoginId: email }, (err, docs) ->

    unless err
      if docs.length > 0

        # Hitしたデータをparse
        userData = JSON.parse(JSON.stringify(docs[0]))

        # パスワードチェック
        auth = bcrypt.compareSync(passwd, userData["memPassword"]);
        if auth
          # パスワード一致の場合、home画面へ

          # セッション情報をRedisに書き込み
          now = new Date()
          date = util.getDateTimestamp(now)
          salt = bcrypt.genSaltSync(10)
          hash = bcrypt.hashSync(date, salt)

          sid = "session-" + hash
          redisClient.set sid, hash
          redisClient.expire sid, conf.auth.tov, (err, didSetExpiry) ->
            # Redis Key の有効期限設定に失敗
            logger.error '{ result: 1, message: ' + conf.MSG.L_002 + ', stack: err }'
            return

        else
          # パスワード不一致
          arrRes['message'] = conf.MSG.N_001

      else
        # IDが一致するユーザーがいない場合
        arrRes['message'] = conf.MSG.N_001

    else
      # データベース系エラー
      logger.error '{ result: 1, message: ' + conf.MSG.L_001 + ', stack: err }'
      arrRes['result']  = 1
      arrRes['message'] = conf.MSG.E_999
      arrRes['stack']   = err

    unless arrRes['result']
      unless arrRes['message']
        # メッセージが空の場合は正常処理（home画面へ）
        res.setHeader('Set-Cookie', ['sid=' + sid])
        res.render "adminHome.jade"

      else
        # メッセージがある場合は、ログインIDまたはパスワード不一致メッセージを表示
        res.render "index.jade", arrRes

    else
      res.render "error",
        error: arrRes

    return

