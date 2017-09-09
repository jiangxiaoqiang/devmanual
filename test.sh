#echo '{"foo": 42, "bar": "less interesting data"}' | jq .
#weather=`curl http://www.weather.com.cn/data/cityinfo/101010100.html|jq '.'`
#echo $weather|jq '.'

readonly APP_ID="hlb1451j6d136334gh2"
readonly APP_KEY="test"
ECHOSTR=`head -n 1 /dev/urandom|sed 's/[^a-z0-9]//g'|md5sum|awk '{print $1}'`
CURRENT_TIME=`date '+%Y-%m-%d %H:%M:%S'`
CONST_STR="ysf"
#
# 生成TOKEN
# hlb1451j6d136334gh2接口各项认证参数的排列顺序是：
# 时间戳(timestamp)、AppKey、随机字符串(echostr)
# \$1接收来自命令行传入的参数
# 第二个参数用\$2接收，以此类推
# \$@表示所有的参数，相当于Java中main函数中定义的参数数组
#
TOKEN=`echo -n ${APP_ID}${APP_KEY}${CURRENT_TIME}${CONST_STR}|md5sum|awk '{print $1}'`

aSEQUENCE_TOKEN=`echo -n ${CURRENT_TIME}_${APP_ID}_${APP_KEY}_${CONST_STR}|tr '_' '\t'|sort|tr -d '\011'`
SEQUENCE_TOKEN=`echo -n ${CURRENT_TIME}${APP_ID}${APP_KEY}${CONST_STR}|shasum -a 1|awk '{print $1}'`

# 请求服务端
COMMAND=`curl -H "APPID:$APP_ID" -H "TIMESTAMP:$CURRENT_TIME" -H "ECHOSTR:$CONST_STR" -H "TOKEN:$SEQUENCE_TOKEN" \
	http://localhost:28080/api/blacklist/page?xdr= | jq '.'`
echo -n 'b a'|tr ' ' '\t' |sort|tr -d '\040\011\012\015'



