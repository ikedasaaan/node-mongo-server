#
# formatDateTime
# 
exports.getDateTimestamp = (time) ->
  myD = time
  myYear = myD.getYear()
  myYear4 = ((if myYear < 2000 then myYear + 1900 else myYear))
  myMonth = myD.getMonth() + 1
  myDate = myD.getDate()
  myDay = myD.getDay()
  myHours = myD.getHours()
  myMinutes = myD.getMinutes()
  mySeconds = myD.getSeconds()
  myMill = myD.getMilliseconds()
  myMess1 = myYear4 + "" + myMonth + "" + myDate
  myMess2 = myHours + "" + myMinutes + "" + mySeconds + "" + myMill
  myMess = myMess1 + myMess2
  myMess

exports.formatDateTimestamp = (time) ->
  myD = time
  myYear = myD.getYear()
  myYear4 = ((if myYear < 2000 then myYear + 1900 else myYear))
  myMonth = myD.getMonth() + 1
  myDate = myD.getDate()
  myDay = myD.getDay()
  myHours = myD.getHours()
  myMinutes = myD.getMinutes()
  mySeconds = myD.getSeconds()
  myMill = myD.getMilliseconds()
  myMess1 = myYear4 + "-" + myMonth + "-" + myDate
  myMess2 = myHours + ":" + myMinutes + ":" + mySeconds + "." + myMill
  myMess = myMess1 + " " + myMess2
  myMess

exports.formatDateTime = (time) ->
  myD = time
  myYear = myD.getYear()
  myYear4 = ((if myYear < 2000 then myYear + 1900 else myYear))
  myMonth = myD.getMonth() + 1
  myDate = myD.getDate()
  myDay = myD.getDay()
  myHours = myD.getHours()
  myMinutes = myD.getMinutes()
  mySeconds = myD.getSeconds()
  myMill = myD.getMilliseconds()
  myMess1 = myMonth + "/" + myDate
  myMess2 = myHours + ":" + myMinutes
  myMess = myMess1 + " " + myMess2
  myMess


#
# 金額フォーマット
#
exports.formatAmount = (val) ->
  if not val is ""
    ret = val.replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
    return ret
  else
    return val
  return

