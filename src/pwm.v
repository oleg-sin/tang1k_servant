module pwm #(
    parameter CLK_FREQ = 27_000_000,  // Main pipe clock (50MHz like good Soviet oscillator)
    parameter PWM_FREQ = 1000         // User's frequency choice (khz like weak western toilet)
) (
    input wire clk,         // Main clock flow
    input wire reset,       // Emergency stop (like hammer to pipe)
    input wire [7:0] duty, // 0-255% power (like vodka bottle levels)
    output reg pwm_out      // Our fixed pipe signal
);

// Calculate how many clk cycles before pipe overflows
localparam COUNTER_MAX = (CLK_FREQ / PWM_FREQ) - 1;  // Precision math, da?
localparam COUNTER_WIDTH = $clog2(COUNTER_MAX) + 1;  // Size matters, unlike ex-wife's patience

reg [COUNTER_WIDTH-1:0] counter;  // Our main pressure gauge
wire [COUNTER_WIDTH-1:0] threshold = (duty * COUNTER_MAX) >> 8;  // Real plumber's math, no floating-point shit

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;            // When emergency valve pulled
        pwm_out <= 1'b0;         // Shut off flow completely
    end else begin
        // Main pipe pressure control
        counter <= (counter == COUNTER_MAX) ? 0 : counter + 1;  // Reset when full
        pwm_out <= (counter < threshold);  // Open valve until threshold (like good diarrhea)
    end
end

endmodule