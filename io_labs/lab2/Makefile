obj-m = lab2.o
PWD = $(shell pwd)

all:
	make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" modules
	
load:
	sudo insmod lab2.ko

unload:
	sudo rmmod lab2.ko
	
clean:
	make -C /lib/modules/$(shell uname -r)/build M="$(PWD)" clean
	
reload: unload clean all load

