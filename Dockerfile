FROM ubuntu:16.04

## For chinese user
#RUN sed -i "s/http:\/\/archive\.ubuntu\.com/http:\/\/mirrors\.aliyun\.com/g" /etc/apt/sources.list

ENV NOTVISIBLE "in users profile"

RUN apt-get update && apt-get install \
		-y --no-install-recommends \
				openssh-server \
				ca-certificates \
				curl \
				wget \
				vim \
				git \
				zsh \
				autojump \
				locales-all \
	&& mkdir /var/run/sshd \
	&& echo 'root:password' | chpasswd \
	&& sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
	&& echo "export VISIBLE=now" >> /etc/profile \
	&& wget -q https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
	&& sed -i "s/robbyrussell/gianu/g" $HOME/.zshrc \
	&& echo ". /usr/share/autojump/autojump.zsh" >> $HOME/.zshrc \
	&& echo "set fileencodings=utf-8,gb2312,gbk,gb18030" >> /etc/vim/vimrc \
	&& echo "set termencoding=utf-8" >> /etc/vim/vimrc \
	&& echo "set encoding=prc" >> /etc/vim/vimrc \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
