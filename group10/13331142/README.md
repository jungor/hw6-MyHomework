# 安装
1. install MonogoDB
2. run mongod (on default port 27017)
3. npm install mongoose(因为我在windows上尝试安装mongoose并不是每次都成功，所以单独拿出来安装，请确认安装成功后再进入下一步，否则也是白装)
4. npm install
5. grunt watch

## 使用
1. 开始注册时学号输入00000000即注册为老师帐号，否则为学生帐号
2. 老师可以看到所有的作业要求和所有学生提交的作业，学生能看到所有的作业要求，但只能够看到自己的作业。
3. 发布作业要求：老师可以发布作业要求，也可以修改一个已发布但是尚未截止的作业要求。
4. 提交作业：学生可以提交作业（可以多次提交作业，系统将保留最新的版本）。
5. deadline：老师可以设定/修改作业要求的截止时间，截止时间到达后，任何学生都将无法提交作业。
6. 作业评分: 截止时间到达之后，老师可以批改作业给出分数。

###注意
1. 上交的作业在/public/homework文件夹里
2. 点击myHomework可以返回主页
3. 如有问题请联系1219810894@qq.com，多谢