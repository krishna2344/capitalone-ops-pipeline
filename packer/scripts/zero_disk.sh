
dd if=/dev/zero of=/free-space bs=1M
rm -f /free-space

# su -c "cat /dev/null > ~/.bash_history && history -c" - vagrant
# cat /dev/null > ~/.bash_history && history -c
