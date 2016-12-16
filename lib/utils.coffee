#工具类

os = require 'os'
phpjs = require 'phpjs'
superagent = require 'superagent'

###
  通过 Express 的 os 包获取 ip
###
exports.getIp = (callback) ->
  callback = callback or ->
  ifaces = os.networkInterfaces()
  data = {}
  ip = ''

  Object.keys(ifaces).forEach (ifname) ->
    ifaces[ifname].forEach (item) ->
      if item.family == 'IPv4' and item.internal == false
        ip = item.address
  data.ip = ip
  callback null, data


###
  抓取 ip.cn 的结果获取 ip 信息
###
exports.getIpByNet = (ip, callback)->
  callback = callback or ->
  url = if ip then 'http://ip.cn/index.php?ip=' + ip else 'http://ip.cn/'
  data = {};
  ipArrs = ''

  superagent
    .get url
    .set 'User-Agent', 'curl/7.37.1'
    .end (err, res)->
      if err
        callback err

      ipArrs = res.text.replace(/[\r|\n|来自]/g, '')
      ipArrs = if ipArrs then ipArrs.split '：' else []

      data.ip = if ipArrs[1] then ipArrs[1] else ''
      data.address = if ipArrs[2] then ipArrs[2] else ''
      callback null, data


#时间戳转换
exports.unixTime = (info, callback) ->
  callback = callback or ->
  info = info or {}
  data = {}

  if info.intTime
    data.stringTime = phpjs.date "Y-m-d H:i:s", info.intTime
  if info.stringTime
    data.intTime = phpjs.date info.stringTime

  return callback null, data