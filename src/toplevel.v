module toplevel(
    input io_clk,
    input io_resetn,
    output io_gpio,
    output led_r,
    output led_g,
    output led_b
);
    parameter memfile = "zephyr_hello.hex";
    parameter memsize = 8192;

    wire      wb_clk;
    reg       wb_rst;
    wire      lock;

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