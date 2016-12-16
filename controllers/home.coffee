#首页
async = require 'async'

exports.index = (req, res, next) ->
  res.render 'index'
