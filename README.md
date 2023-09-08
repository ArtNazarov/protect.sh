# protect.sh

Disable or enable modification flag at folder recursively and changes permissions and user owner to disallow open under non root user

Example:
```
mkdir ~/important
sudo ./protect.sh protect important
```
to allow modification
```
sudo ./protect.sh unprotect important
```

The script creates the file md5.sum with a password hash for a given protected directory 
for comparison if user tries to allow modification and return permissions
