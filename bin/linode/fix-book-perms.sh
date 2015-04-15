cd /home/flatcap/books/

chown -R flatcap.nginx .
chcon -R -t public_content_t .
fff chmod 640
ffd chmod 2750
chattr -R +i .

