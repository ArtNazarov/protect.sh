function protect(){
	echo "apply protection"
	read -p "Input password: " pass
	echo -n $pass | md5sum > md5.sum
	mv md5.sum $1
	sudo find "$1" -type d -exec chmod 700 {} \; 
	sudo find "$1" -type f -exec chmod 600 {} \;
	sudo chown root:root "$1" -R
	sudo chattr +i -R "$1"
}
function unprotect(){
	echo "apply unprotection"
	read -p "Input password for folder: " pass
	tst=$(echo -n $pass | md5sum )
	sudo cp "$1/md5.sum" ./md5.sum
	sudo chmod 755 md5.sum
	sudo chown $USER:$USER md5.sum
	estr=$(cat md5.sum)
	sudo rm ./md5.sum
	if [[ $tst == $estr ]]; then
		echo "Okay, confirmed"
		sudo chattr -i -R "$1"
		sudo find "$1" -type d -exec chmod 755 {} \;
		sudo find "$1" -type f -exec chmod 644 {} \;
		sudo chown $USER:$USER "$1" -R
	else
		echo "Fail, mismatch"
	fi


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
