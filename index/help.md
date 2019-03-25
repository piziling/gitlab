#  code_server_name《帮助文档》

--- 

## 一、进入邮箱账号

*  [点击进入邮箱](http://mail.my_domain.com/)

* 账号：`名字的全拼@my_domain.com`

* 密码：`12345678`

* 暂不支持用户更改密码

## 二、确认Gitlab账号

* gitlab不支持用户自己注册账号，只能由管理员增添

* 管理员添加账号后，在个人邮箱里会收到相应邮件

* 按照邮件提示，进入相关链接，设置密码，确认账号即可

## 三、Gitlab 中文设置

* 先登陆 gitlab

* [点击这里跳转](http://gitlab.my_domain.com/profile)

* 找到 【Preferred language】 设置为 【简体中文】

* 刷新页面即可

* 提示：同一页面有更多个性化的设置，例如：头像等用户资料

## 四、设置 SSH 密钥

* 为什么要设置 ssh 密钥？因为在本地电脑使用 `git clone` 命令时需要认证

* 在自己的电脑上生成密钥，步骤如下：

    * 进入 cmd 命令行
    
    * 输入命令：`ssh-keygen`，期间会要填写一些信息，一路回车确认，保持默认即可
    
    * 打开文件：`C:\Users\【这里替换成你的电脑名称】\.ssh\id_rsa.pub`
    
    * 把内容复制到下面链接的信息框内
    
 * [点击设置个人密钥](http://gitlab.my_domain.com/profile/keys)
 
## 五、更多帮助文档
 
 * [Gitlab 官方文档（英文原版）](http://gitlab.my_domain.com/help)
 
 * [ 代码服务器指引](http://my_domain.com/gitlab/index.html)