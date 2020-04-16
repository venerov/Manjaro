#Создать файл `usbreset.c` со следующим содержимым:
```
/* usbreset -- send a USB port reset to a USB device */

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

#include <linux/usbdevice_fs.h>


int main(int argc, char **argv)
{
const char *filename;
int fd;
int rc;

if (argc != 2) {
fprintf(stderr, "Usage: usbreset device-filename\n");
return 1;
}
filename = argv[1];

fd = open(filename, O_WRONLY);
if (fd < 0) {
perror("Error opening output file");
return 1;
}

printf("Resetting USB device %s\n", filename);
rc = ioctl(fd, USBDEVFS_RESET, 0);
if (rc < 0) {
perror("Error in ioctl");
return 1;
}
printf("Reset successful\n");

close(fd);
return 0;
}
```
Скомпилировать:
```
cc usbreset.c -o usbreset
```
скопировать в `/usr/bin/`, сделать исполняемым:
```
udo chmod +x /usr/bin/usbreset
```
Создать скрипт:
```
#!/bin/bash
bus=$(lsusb | grep Xbox360 | gawk '{print $2}')
port=$(lsusb | grep Xbox360 | gawk '{print $4}' | cut -d":" -f1)
sudo usbreset /dev/bus/usb/$bus/$port
```
сделать исполняемым.
