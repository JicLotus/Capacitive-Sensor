setear_puerto_drive:
	cpi PinDrive,pinDrive_cap1
	breq setpuertodrive2
	sbi PORTD,pinDrive_cap2
	ret
	setpuertodrive2:
	sbi PORTD,pinDrive_cap1
	ret

limpiar_puerto_drive:
	cpi PinDrive,pinDrive_cap1
	breq limppuertodrive2
	cbi PORTD,pinDrive_cap2
	ret
	limppuertodrive2:
	cbi PORTD,pinDrive_cap1
	ret


setear_sentido_drive:
	cpi PinDrive,pinDrive_cap1
	breq setsentidodrive2
	sbi DDRD,pinDrive_cap2
	ret
	setsentidodrive2:
	sbi DDRD,pinDrive_cap1
	ret

limpiar_sentido_drive:
	cpi PinDrive,pinDrive_cap1
	breq limpsentidodrive2
	cbi DDRD,pinDrive_cap2
	ret
	limpsentidodrive2:
	cbi DDRD,pinDrive_cap1
	ret

