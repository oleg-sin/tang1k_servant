module toplevel(
    input wire io_clk,
    input wire io_resetn,
    output wire io_gpio,
    output wire io_led_r,
    output wire io_led_g,
    output wire io_led_b
);

    parameter SYS_CLK_FREQ = 27_000_000; // Hz
    parameter PWM_FREQ = 50_000;         // Hz
    parameter memfile = "blinky_my.hex";
    parameter memsize = 8192;

    wire      wb_clk;
    reg       wb_rst;
    wire      lock;

//    assign io_led_g = !io_gpio;   
//    assign io_led_b = io_led_g;

    Gowin_rPLL pll(
        .clkout (wb_clk),     //output clkout
        .lock   (lock),       //output lock
        .reset  (!io_resetn), //input reset
        .clkin  (io_clk)      //input clkin
    );

    always @(posedge wb_clk) begin
        wb_rst <= !lock;
    end

    servant #(
        .memfile  (memfile),
        .memsize  (memsize)
//        .compress (1'b1)
    ) servant (
        .wb_clk   (wb_clk),
        .wb_rst   (wb_rst),
        .q        (io_gpio)
    );

    wire [7:0] duty_r = 8'h01;
    wire [7:0] duty_g = 8'hCC;
    wire [7:0] duty_b = 8'hFF;

    wire pwm_red;
    wire pwm_green;
    wire pwm_blue;

    assign io_led_r = !pwm_red;
    assign io_led_g = !pwm_green;
    assign io_led_b = !pwm_blue;

    pwm #(
        .CLK_FREQ(SYS_CLK_FREQ),
        .PWM_FREQ(PWM_FREQ)
    ) pwm_r (  
        .clk(io_clk),  
        .reset(!io_resetn),  
        .duty(duty_r), 
        .pwm_out(pwm_red)  
    );  

    pwm #(
        .CLK_FREQ(SYS_CLK_FREQ),
        .PWM_FREQ(PWM_FREQ)
    ) pwm_g (  
        .clk(io_clk),  
        .reset(!io_resetn),  
        .duty(duty_g), 
        .pwm_out(pwm_green)  
    ); 

    pwm #(
        .CLK_FREQ(SYS_CLK_FREQ),
        .PWM_FREQ(PWM_FREQ)
    ) pwm_b (  
        .clk(io_clk),  
        .reset(!io_resetn),  
        .duty(duty_b), 
        .pwm_out(pwm_blue)  
    ); 

    wire bgen;
    assign bgen = 1'b1;
    Gowin_BANDGAP bandgap(
        .bgen (bgen) //input bgen
    );
endmodule