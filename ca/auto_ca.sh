#!/bin/bash

FILE_PREFIX=wiscom  # 相关文件名称
RSA_BITS_NUM=2048  # rsa 长度（位数）
VALID_DAYS=3650  # 有效时间（天）

PASS_RSA=wiscom  # 临时密码，最后会被清空

# 生成证书要填写的信息
CRT_COUNTRY_NAME=CN  # 国家
CRT_PROVINCE_NAME=wiscom  # 洲/省
CRT_CITY_NAME=Beijing  # 市
CRT_ORGANIZATION_NAME=wiscom  # 组织名称
CRT_ORGANIZATION_UNIT_NAME=wiscom  # 单位名称
CRT_DOMAIN=*.my_domain.com  # 域名
CRT_EMAIL=root@my_domain.com  # 邮箱
CRT_EXTRA_CHALLENGE_PASSWD=wiscom  # 私钥保护密码
CRT_EXTRA_OPTINAL_COMPANY_NAME=wiscom  # 公司名称

# 2.1 生成私钥
echo -e "\n---------------------------- 生成私钥 ----------------------------\n"
openssl genrsa -des3 -passout pass:$PASS_RSA -out $FILE_PREFIX.pem $RSA_BITS_NUM

# 2.2 除去密码口令
echo -e "\n---------------------------- 除去密码口令 ----------------------------\n"
openssl rsa -in $FILE_PREFIX.pem -out $FILE_PREFIX.key -passin pass:$PASS_RSA
rm -f $FILE_PREFIX.pem

# 2.3 生成证书请求
echo -e "\n---------------------------- 生成证书请求 ----------------------------\n"
openssl req -new -days $VALID_DAYS -key $FILE_PREFIX.key -out $FILE_PREFIX.csr << EOF
$CRT_COUNTRY_NAME
$CRT_PROVINCE_NAME
$CRT_CITY_NAME
$CRT_ORGANIZATION_NAME
$CRT_ORGANIZATION_UNIT_NAME
$CRT_DOMAIN
$CRT_EMAIL
$CRT_EXTRA_CHALLENGE_PASSWD
$CRT_EXTRA_OPTINAL_COMPANY_NAME
EOF

# 2.4 生成证书
echo -e "\n\n---------------------------- 生成证书 ----------------------------\n"
openssl x509 -req -days $VALID_DAYS -signkey $FILE_PREFIX.key -in $FILE_PREFIX.csr -out $FILE_PREFIX.crt

# 输出相关配置
echo -e "\n\n\n---------------------------- Nginx 配置 ----------------------------"
echo -e "\tssl_certificate $FILE_PREFIX.crt;"
echo -e "\tssl_certificate_key $FILE_PREFIX.key;"
echo -e "\n"
