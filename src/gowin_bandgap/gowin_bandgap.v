//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.11
//Part Number: GW1NZ-LV1QN48C6/I5
//Device: GW1NZ-1
//Created Time: Tue Apr 29 22:17:55 2025

module Gowin_BANDGAP (bgen);

input wire bgen;

BANDGAP bandGap_inst (
    .BGEN(bgen)
);

endmodule //Gowin_BANDGAP
