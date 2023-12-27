dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y
useradd roboshop


mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
npm install
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cd roboshop-shell
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y

mongo --host mongodb-dev.nldevopsb01.online </app/schema/catalogue.js
