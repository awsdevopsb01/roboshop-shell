echo -e "************\e[36m Correct NodeJs version ************\e[0m"

dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "************\e[36m Install NodeJs ************\e[0m"
dnf install nodejs -y

echo -e "************\e[36m Create Functional User ************\e[0m"
useradd roboshop

echo -e "************\e[36m Create App directory ************\e[0m"
mkdir /app

echo -e "************\e[36m Download app content ************\e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo -e "************\e[36m Extract App Content ************\e[0m"
cd /app
unzip /tmp/user.zip

echo -e "************\e[36m Install dependencies ************\e[0m"
npm install

echo -e "************\e[36m Create User Service ************\e[0m"
cp /home/centos/user.service /etc/systemd/system/user.service

echo -e "************\e[36m Create Enable and start ************\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

cd roboshop-shell
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y

mongo --host mongdb.nldevopsb01.online </app/schema/user.js