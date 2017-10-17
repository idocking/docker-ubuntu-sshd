FROM ubuntu:16.04

## For chinese user
#RUN sed -i "s/http:\/\/archive\.ubuntu\.com/http:\/\/mirrors\.aliyun\.com/g" /etc/apt/sources.list

ENV NOTVISIBLE "in users profile"

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server ca-certificates \
	&& mkdir /var/run/sshd \
	&& echo 'root:password' | chpasswd \
	&& sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
	&& echo "export VISIBLE=now" >> /etc/profile \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]