dnf install maven -y
useradd roboshop
cp shipping.service /etc/systemd/system/shipping.service
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip
mvn clean package
mv target/shipping-1.0.jar shipping.jar

systemctl daemon-reload
systemctl enable shipping
systemctl start shipping

dnf install mysql -y
mysql -h mysql.nldevopsb01.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping