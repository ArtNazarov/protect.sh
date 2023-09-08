function protect(){
	echo "apply protection"
	sudo find "$1" -type d -exec chmod 700 {} \; 
	sudo find "$1" -type f -exec chmod 600 {} \;
	sudo chown root:root "$1" -R
	sudo chattr +i -R "$1"
}
function unprotect(){
	echo "apply unprotection"
	sudo chattr -i -R "$1"
	sudo find "$1" -type d -exec chmod 755 {} \; 
	sudo find "$1" -type f -exec chmod 644 {} \;
	sudo chown $USER:$USER "$1" -R	
}

if  [ $# -lt 2 ] ; then
	echo " need 2 args command (protect or unprotect)  and path "
fi

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
