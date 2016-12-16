#工具
async = require 'async'
phpjs = require 'phpjs'
utils = require '../lib/utils'


exports.index = (req, res, next) ->
  data = {}
  async.waterfall [(callback) ->
    utils.getIp (err, result) ->
      if err
        return callback err
      data.osIp = result.ip or ''
      callback null
      return
  , (callback) ->
      utils.getIpByNet '', (err, result) ->
        if err
          return callback err
        data.netIp = result.ip or ''
        data.address = result.address or ''
        callback null
        return
  ], (error) ->
    if error
      console.log error
    return res.render 'tool', data


exports.get = (req, res, next) ->

  ip = req.params.ip || ''
  if not ip
    return res.send {code: 1, msg: 'params error'}
  utils.getIpByNet ip, (err, result) ->
    return res.send result


exports.time = (req, res, next) ->

  intTime = req.params.time || ''

  if not intTime
    return res.send {code: 1, msg: 'params error'}
  utils.unixTime {intTime: intTime}, (err, result) ->
    return res.send result