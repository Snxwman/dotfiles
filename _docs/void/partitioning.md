# Void - Partitioning

| Mount Point | Size      | Type             | Filesystem |
|-------------|-----------|------------------|------------|
| /boot/efi   | 1 Gb      | EFI              | FAT32      |
| /           | 128 Gb    | Linux Filesystem | ext4       |
| /home       | Remaining | Linux Home       | ext4       |

Using gpt partition tables.
