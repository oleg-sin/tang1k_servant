TOOLCHAIN_PREFIX?=riscv64-unknown-elf-

# New default target - like main water valve!
all: $(patsubst %.S,%.hex,$(wildcard *.S))  
	cp -p *.hex ../

%.elf: %.S link.ld
	$(TOOLCHAIN_PREFIX)gcc -nostartfiles -nostdlib -march=rv32i_zicsr -mabi=ilp32 -Tlink.ld -o$@ $<
	$(TOOLCHAIN_PREFIX)size $@
	$(TOOLCHAIN_PREFIX)strip $@
%.bin: %.elf
	$(TOOLCHAIN_PREFIX)objcopy -O binary $< $@
%.hex: %.bin
	python3 makehex.py $< > $@

clean:
	rm -f *.elf *.bin *.hex
