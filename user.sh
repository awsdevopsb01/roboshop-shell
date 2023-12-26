dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y
useradd roboshop
npm install
cp user.service /etc/systemd/system/user.service
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

systemctl daemon-reload
systemctl enable user
systemctl start user

cd roboshop-shell
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y

mongo --host mongdb.nldevopsb01.online </app/schema/user.js