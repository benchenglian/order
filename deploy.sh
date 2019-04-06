#!/usr/bin/env bash
#编译+部署order站点

#需要配置如下参数
# 项目路径, 在Execute Shell中配置项目路径, pwd 就可以获得该项目路径
# export PROJ_PATH=这个jenkins任务在部署机器上的路径

# 输入你的环境上tomcat的全路径
# export TOMCAT_APP_PATH=tomcat在部署机器上的路径

### base 函数
cd $PROJ_PATH/princeqjzh
mvn clean install

#准备ROOT.war包
cd $PROJ_PATH/princeqjzh/target
mv order.war ROOT.war

#制作新的docker image - iweb
cd $PROJ_PATH/princeqjzh
docker stop orderObj
docker rm orderObj
docker rmi order
docker build -t order .

# 启动docker image，宿主机暴露端口 8111
docker run --name orderObj -d -p 8111:8080 order
