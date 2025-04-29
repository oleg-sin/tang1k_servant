module toplevel(
    input wire io_clk,
    input wire io_resetn,
    output wire io_gpio,
    output wire led_r,
    output wire led_g,
    output wire led_b
);
    parameter memfile = "blinky.hex";
    parameter memsize = 8192;

    wire      wb_clk;
    reg       wb_rst;
    wire      lock;

    assign led_r = !io_gpio;

    Gowin_rPLL pll(
        .clkout(wb_clk), //output clkout
        .lock(lock), //output lock
        .reset(!io_resetn), //input reset
        .clkin(io_clk) //input clkin
    );

    always @(posedge wb_clk) begin
        wb_rst <= !lock;
    end

    servant #(
        .memfile(memfile),
        .memsize(memsize)
    ) servant (
        .wb_clk(wb_clk),
        .wb_rst(wb_rst),
        .q(io_gpio)
    );

    wire bgen;
    assign bgen = 1'b1;
    Gowin_BANDGAP bandgap(
        .bgen(bgen) //input bgen
    );
endmodule