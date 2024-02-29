# tool-web后端

## 版本

PHP >= 7.3

Composer >= 2

## OpenAi使用

拉取项目后通过composer安装组件库， composer >= 2
``` 
composer install
```

添加`.env`
```
cp .env.example .env
```

配置`.env`, 只用填写`mysql`和`redis`的配置即可


## 启动项目

``` 
# 启动
./bin/server.sh start

# 停止
./bin/server.sh stop

# 重启
./bin/server.sh restart
```