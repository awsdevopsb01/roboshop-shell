dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y
useradd roboshop
npm install
cp catalogue.service /etc/systemd/system/catalogue.service
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cd roboshop-shell
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y

mongo --host mongodb-dev.nldevopsb01.online </app/schema/catalogue.js
