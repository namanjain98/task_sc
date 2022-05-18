#!/bin/bash
exec 1> /var/log/userdata.log 2>&1
curl -L https://get.docker.com -o docker.sh
bash +x docker.sh
cat <<EOF >> /tmp/Dockerfile
FROM ubuntu
RUN apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-setuptools \
        groff \
        less \
    && pip3 install --upgrade pip \
    && apt-get clean
RUN pip3 --no-cache-dir install --upgrade awscli
RUN aws configure set aws_access_key_id "AKIAYEEH6FAJN7JPRQO3"
RUN aws configure set aws_secret_access_key "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"
RUN aws configure set default.region "us-east-1"
ENTRYPOINT ["/bin/bash"]
RUN apt update
RUN apt install -y apache2
RUN apt install -y apache2-utils
RUN cmd1="\$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].InstanceId")" && cd /var/www/html && echo "Instanceid=\$cmd1 \n" > index.html
RUN cmd1="\$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].PrivateIpAddress")" && cd /var/www/html && echo "PrivateIP=\$cmd1 \n" >> index.html
RUN cmd1="\$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].Tags")" && cd /var/www/html && echo "TAGS=\$cmd1 \n" >> index.html

EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
EOF

docker build -t apacheaws /tmp/
docker run --name apacheaws -d -p 8000:80 apacheaws