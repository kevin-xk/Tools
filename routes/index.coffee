express = require 'express'
router  = express.Router()
home    = require '../controllers/home'
tool    = require '../controllers/tool'

#Home Page
router.get '/', home.index

# 工具页
router.get '/tool', tool.index

# 根据 ip 或者域名查询地理位置
router.get '/tool/ips/:ip', tool.get

# 时间格式转换
router.get '/tool/times/:time', tool.time


module.exports = router