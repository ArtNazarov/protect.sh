  GNU nano 6.3                                                                           /home/artem/protect.sh                                                                                     
function protect(){
echo "apply protection"
sudo chattr +i -R "$1"
}

function unprotect(){
echo "apply unprotection"
sudo chattr -i -R "$1"
}

if [ $# -lt 2 ] ; then
echo " need 2 args command and path "
else

action=$1
path="$2"
echo "Param count is $#"
echo "Chosen action is $action"
echo "Chosen path is $path"

case "$action" in
"protect" )
protect "$path"
;;
"unprotect" )
unprotect "$path"
;;
*)
echo "commands protect or unprotect require"
esac

fi
