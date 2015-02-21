#!/bin/bash

# We don't want the AWS servers to have access to the internal git
# repo.  Therefore, fake out a local repo on the server.

DEPLOY_USER=deployer

if [ `hostname` == cen6631.donlaw.lab ]; then
    echo "ERROR: Should run on deployed server"
    exit 1
fi

grep -q calliope /etc/hosts
if [ $? -ne 0 ]; then
    sed -i /etc/hosts -e "s/localhost.localdomain/& calliope/"
fi

grep -q git /etc/passwd
if [ $? -ne 0 ]; then
    useradd -m git
fi

if [ ! -e /usr/bin/git ]; then
    yum install -y git
fi

su -c "mkdir -p /home/$DEPLOY_USER/.ssh" $DEPLOY_USER
kf=/home/$DEPLOY_USER/.ssh/id_rsa
if [ ! -e $kf ]; then
    su -c "ssh-keygen -t rsa -N '' -f $kf" $DEPLOY_USER
fi
chmod 755 /home/$DEPLOY_USER

su -c "mkdir -p /home/git/.ssh" git
su -c "chmod 700 /home/git/.ssh" git
su -c "touch /home/git/.ssh/authorized_keys" git
grep -q $DEPLOY_USER /home/git/.ssh/authorized_keys
if [ $? -ne 0 ]; then
    cat $kf.pub >> /home/git/.ssh/authorized_keys
fi
grep -q "dlaw@cen6631" /home/git/.ssh/authorized_keys
if [ $? -ne 0 ]; then
    cat /tmp/dlaw-cen6631.pub >> /home/git/.ssh/authorized_keys
fi
grep -q "dlaw@samantha" /home/git/.ssh/authorized_keys
if [ $? -ne 0 ]; then
    cat /tmp/dlaw-clpe.pub >> /home/git/.ssh/authorized_keys
fi

su -c "ssh -o StrictHostKeyChecking=no -l git calliope hostname" $DEPLOY_USER

echo " "
echo "Run /home/git/scripts/sendgit.sh on calliope to copy git repo."
