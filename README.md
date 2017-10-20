# ubuntu-sshd

```bash
ID=$(docker run -d -p 10222:22 idocking/ubuntu:16.04)
docker logs $ID
```

root password is random generate by `pwgen -Bsv1 16`, 

