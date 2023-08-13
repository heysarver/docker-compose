# samba
docker-compose file for a simple Samba file server

## Notes:
I want everything in my underlying OS owned by UID and GID 1000.  I also only have 2 users because passwords with some characters do not work when escaped weirdly for USER1 in the samba.sh script.  Until I update my fork I have to add a fake USER1.

Add as many shares, users, volumes, as you want.  All options: https://github.com/heysarver/samba
