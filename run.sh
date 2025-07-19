echo -e "choose a file without .asm"
read file
nasm -f elf64 $file.asm -o $file.o
mv $file.o bin/
ld bin/$file.o -o $file
mv $file linked/
chmod +x linked/$file
./linked/$file