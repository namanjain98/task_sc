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
RUN aws configure set aws_access_key_id "AKIAYEEH6FAJAMGRRQ5X"
RUN aws configure set aws_secret_access_key "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"
RUN aws configure set default.region "us-east-1"
ENTRYPOINT ["/bin/bash"]
RUN apt update
RUN apt install -y apache2
RUN apt install -y apache2-utils
RUN cmd1="$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].InstanceId")" && cd /var/www/html && echo "Instanceid=$cmd1 \n" > index.html
RUN cmd1="$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].PrivateIpAddress")" && cd /var/www/html && echo "PrivateIP=$cmd1 \n" >> index.html
RUN  cmd1="$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].Tags")" && cd /var/www/html && echo "TAGS=$cmd1 \n" >> index.html

EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
