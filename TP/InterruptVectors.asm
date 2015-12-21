// Handler de las interrupciones.
//
// Direcciones: 0x000 - 0x019
//

rjmp RESET ; Reset Handler
rjmp RESET ; IRQ0 Handler
rjmp RESET ; IRQ1 Handler
rjmp RESET ; PCINT0 Handler
rjmp RESET ; PCINT1 Handler
rjmp RESET ; PCINT2 Handler
rjmp RESET ; Watchdog Timer Handler
rjmp RESET ; Timer2 Compare A Handler
rjmp RESET ; Timer2 Compare B Handler
rjmp RESET ; Timer2 Overflow Handler
rjmp TIM1_CAPT ; Timer1 Capture Handler
rjmp RESET ; Timer1 Compare A Handler
rjmp RESET ; Timer1 Compare B Handler
rjmp RESET ; Timer1 Overflow Handler
rjmp RESET ; Timer0 Compare A Handler
rjmp RESET ; Timer0 Compare B Handler
rjmp RESET ; Timer0 Overflow Handler
rjmp RESET ; SPI Transfer Complete Handler
rjmp RESET ; USART, RX Complete Handler
rjmp RESET ; USART, UDR Empty Handler
rjmp RESET ; USART, TX Complete Handler
rjmp RESET ; ADC Conversion Complete Handler
rjmp RESET ; EEPROM Ready Handler
rjmp ANA_COMP ; Analog Comparator Handler
rjmp RESET ; 2-wire Serial Interface Handler
rjmp RESET ; Store Program Memory Ready Handler

/*
rjmp RESET ; Reset Handler
rjmp EXT_INT0 ; IRQ0 Handler
rjmp EXT_INT1 ; IRQ1 Handler
rjmp PCINT0 ; PCINT0 Handler
rjmp PCINT1 ; PCINT1 Handler
rjmp PCINT2 ; PCINT2 Handler
rjmp WDT ; Watchdog Timer Handler
rjmp TIM2_COMPA ; Timer2 Compare A Handler
rjmp TIM2_COMPB ; Timer2 Compare B Handler
rjmp TIM2_OVF ; Timer2 Overflow Handler
rjmp TIM1_CAPT ; Timer1 Capture Handler
rjmp TIM1_COMPA ; Timer1 Compare A Handler
rjmp TIM1_COMPB ; Timer1 Compare B Handler
rjmp TIM1_OVF ; Timer1 Overflow Handler
rjmp TIM0_COMPA ; Timer0 Compare A Handler
rjmp TIM0_COMPB ; Timer0 Compare B Handler
rjmp TIM0_OVF ; Timer0 Overflow Handler
rjmp SPI_STC ; SPI Transfer Complete Handler
rjmp USART_RXC ; USART, RX Complete Handler
rjmp USART_UDRE ; USART, UDR Empty Handler
rjmp USART_TXC ; USART, TX Complete Handler
rjmp ADC ; ADC Conversion Complete Handler
rjmp EE_RDY ; EEPROM Ready Handler
rjmp ANA_COMP ; Analog Comparator Handler
rjmp TWI ; 2-wire Serial Interface Handler
rjmp SPM_RDY ; Store Program Memory Ready Handler

*/
