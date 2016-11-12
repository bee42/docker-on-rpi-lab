# start a ssh commands at every host of your pi cluster

* Create a new ssh Key
* Deploy your key at all pis at your crew Cluster
* Setup your config
* install csshx at your MAC
* use csshx


## ssh key setup


```
$ ssh-keygen -f i~/.ssh/id_crew42_${USER}_rsa \
 -t rsa -b 2048 -c "bee42 crew user"
$ curl -L https://raw.githubusercontent.com/beautifulcode/ssh-copy-id-for-OSX/master/install.sh | sh
$ ssh-copy-id -i ~/.ssh/id_crew42_${USER}_rsa.pub \
 pirate@192.168.3.1
# or
$ cat ~/.ssh/id_crew42_${USER}_rsa.pub \
 | ssh pirate@192.168.3.1 \
 'umask 077; cat >>.ssh/authorized_keys'
```

* https://github.com/beautifulcode/ssh-copy-id-for-OSX

## setup ssh usage config

```
$ cat >> ~/.ssh/config <<EOF
Host 192.168.3.1
IdentityFile ${HOME}/.ssh/id_crew42_${USER}_rsa
User pirate

cat >> ~/.ssh/config <<EOF
Host 192.168.3.3
IdentityFile ${HOME}/.ssh/id_crew42_${USER}_rsa
User pirate

cat >> ~/.ssh/config <<EOF
Host 192.168.3.3
IdentityFile ${HOME}/.ssh/id_crew42_${USER}_rsa
User pirate
EOF
```

## use csshx

```
$ brew install csshx
$ csshx --login pirate 192.168.3.1 192.168.3.2 --remote_command ls
```

setup csshx config

```
$ cat >csshx.config <<EOF
clusters=bee42-crew-03
bee42-crew-03=192.168.3.1 192.168.3.2 192.168.3.3
EOF
$ csshx --config csshx.config -l pirate --remote_command ls bee42-crew-03
```

### TODO

* wrote a script to add your ssh key to all pi's
* define an alias
* build a tool container for that.
  * ssh-copy-id on the mac?


### tmux and cluster ssh

* https://www.reddit.com/r/linuxadmin/comments/375rz5/tmuxcluster_a_clustersshlike_tmux_wrapper_that/

## use pssh

* https://github.com/ParallelSSH/parallel-ssh
* http://www.tecmint.com/execute-commands-on-multiple-linux-servers-using-pssh/

```
$ brew install pssh

```

missing setup

* ssh-agent
* ssh-add

```
$ cat >bee42-crew-03.txt <<EOF
192.168.3.1
192.168.3.2
192.168.3.3
EOF
$ pssh -h bee42-crew-03.txt -l pirate -o /home/pirate/pssh-uname.out uname
```

## Links

* http://linoxide.com/tools/clusterssh-multiple-ssh/
* https://github.com/duncs/clusterssh
* http://www.schlittermann.de/doc/ssh.html
