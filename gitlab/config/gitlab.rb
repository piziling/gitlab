# wiscom setting

## 资源控制配置
unicorn['worker_processes'] = 4  #  默认为 CPU核数+1
# 限制内存
unicorn['worker_memory_limit_max'] = "300 * 1 << 20"  # 最大 300 M
unicorn['worker_memory_limit_min'] = "200 * 1 << 20"  # 最小 200 M
# 限制 sidekiq 的并发数
sidekiq['concurrency'] = 16
# 限制 postgresql 数据库缓存
postgresql['shared_buffers'] = "256MB"
# 限制数据库并发数
postgresql['max_worker_process'] = 8


## 用于浏览器访问 gilab 的 url，也是提供git clone 的url
external_url 'http://gitlab.my_domain.com'

gitlab_rails['time_zone'] = 'Asia/Shanghai' ## 时区设置为 【 亚洲/上海 东八时 】

## 备份文件的存放目录
gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"

## 备份文件保留 7 天，单位：秒
gitlab_rails['backup_keep_time'] = 604800

## 发送邮件配置
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "mail.my_domain.com" # 邮箱服务器的地址
gitlab_rails['smtp_domain'] = "my_domain.com" # 自定义域名,尚未发现其实际用途
gitlab_rails['smtp_port'] = 465

gitlab_rails['smtp_user_name'] = "gitlab@my_domain.com" # 以后的邮件由此邮箱发出
gitlab_rails['gitlab_email_from'] = "gitlab@my_domain.com"  # 必须和smtp_user_name 相同
gitlab_rails['smtp_password'] = "123456" # 邮箱的授权码
gitlab_rails['gitlab_email_reply_to'] = "gitlab@my_domain.com" # 用户回复的邮箱

gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
gitlab_rails['smtp_openssl_verify_mode'] = 'none'  # 禁用 SSL 验证
