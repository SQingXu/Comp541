
 add_fsm_encoding \
       {SPI_If.StC} \
       { }  \
       {{00001001 01} {00001110 11} {01011011 10} {10100000 00} }

 add_fsm_encoding \
       {ADXL362Ctrl.StC_Spi_SendRec} \
       { }  \
       {{0000000 000} {0000111 011} {0001011 010} {0001110 100} {0010101 110} {0100100 101} {1000001 001} }

 add_fsm_encoding \
       {ADXL362Ctrl.StC_Spi_Trans} \
       { }  \
       {{0000000000 000} {0000000010 011} {0000001110 100} {0000110011 010} {1111100001 001} }

 add_fsm_encoding \
       {ADXL362Ctrl.StC_Adxl_Ctrl} \
       { }  \
       {{000001011111 1000} {000010101101 0111} {000100000110 0100} {010000000011 0010} {011000000101 0110} {011001000001 0001} {011001000010 0011} {011001000111 0101} {100100000000 0000} }
