# Лабораторная работа 2

**Название:** "Разработка драйверов блочных устройств"

**Цель работы:** Получить знания и навыки работы с драйверми блочных устройств для Linux

## Описание функциональности драйвера

Реализовать драйвер блочного устройства, создающего виртуальный диск в RAM со следующими разделами:

- Один первичный раздел 10 Мбайт
- Один расширенный раздел, содержащий 2 раздела по 20 Мбайт

## Инструкция по сборке

Для сборки использовать

`make`

Для загрузки модуля в ядро:

`make load`

Для выгрузки модуля:

`make unload`

Для очистки:

`make clean`

## Инструкция пользователя

С помощью команды `sudo fdisk -l /dev/vramdisk` можно посмотреть информацию о разделах диска:

```bash
Диск /dev/vramdisk: 50 MiB, 52428800 байт, 102400 секторов
Единицы: секторов по 1 * 512 = 512 байт
Размер сектора (логический/физический): 512 байт / 512 байт
Размер I/O (минимальный/оптимальный): 512 байт / 512 байт
Тип метки диска: dos
Идентификатор диска: 0x36e5756d

Устр-во        Загрузочный начало  Конец Секторы Размер Идентификатор Тип
/dev/vramdisk1                  1  20479   20479    10M            83 Linux
/dev/vramdisk2              20480 102399   81920    40M             5 Расширенны
/dev/vramdisk5              20481  61439   40959    20M            83 Linux
/dev/vramdisk6              40961  81919   40959    20M            83 Linux
```

Чтобы посмотреть время загрузки и выгрузки данных использовать скрипт `script.sh`:

```bash
./script.sh
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 2559 4k blocks and 2560 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 5119 4k blocks and 5120 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 5119 4k blocks and 5120 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

5+0 records in
5+0 records out
5242880 bytes (5,2 MB, 5,0 MiB) copied, 0,0205646 s, 255 MB/s
5+0 records in
5+0 records out
5242880 bytes (5,2 MB, 5,0 MiB) copied, 0,0164688 s, 318 MB/s
5+0 records in
5+0 records out
5242880 bytes (5,2 MB, 5,0 MiB) copied, 0,0165564 s, 317 MB/s
Copying files from virtual file to virtual file
5,00MiB 0:00:00 [1,64GiB/s] [================================================================================================>] 100%
5,00MiB 0:00:00 [1,79GiB/s] [================================================================================================>] 100%
5,00MiB 0:00:00 [ 331MiB/s] [================================================================================================>] 100%
5+0 records in
5+0 records out
5242880 bytes (5,2 MB, 5,0 MiB) copied, 0,0286135 s, 183 MB/s
5+0 records in
5+0 records out
5242880 bytes (5,2 MB, 5,0 MiB) copied, 0,0241369 s, 217 MB/s
5+0 records in
5+0 records out
5242880 bytes (5,2 MB, 5,0 MiB) copied, 0,0153829 s, 341 MB/s
Copying files from virtual file to real file
5,00MiB 0:00:00 [ 935MiB/s] [================================================================================================>] 100%
5,00MiB 0:00:00 [ 459MiB/s] [================================================================================================>] 100%
5,00MiB 0:00:00 [ 278MiB/s] [================================================================================================>] 100%

```

## Примеры использования

```bash
scuf@scuf-VirtualBox:/media/sf_buba20/io_labs/io_labs/lab2$ sudo echo "1" | sudo dd of=/dev/vramdisk6
0+1 records in
0+1 records out
2 bytes copied, 0,00529758 s, 0,4 kB/s
scuf@scuf-VirtualBox:/media/sf_buba20/io_labs/io_labs/lab2$ sudo xxd /dev/vramdisk6 | head -n 5
00000000: 6164 0000 0000 0000 0000 0000 0000 0000  ad..............
00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000030: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................
```
